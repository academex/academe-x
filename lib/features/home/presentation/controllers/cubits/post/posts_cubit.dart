import 'dart:math';

import 'package:academe_x/core/constants/cache_keys.dart';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/features.dart';
import 'package:academe_x/features/home/data/models/post/comment_model.dart';
import 'package:academe_x/features/home/domain/entities/post/comment_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/post_user_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/reaction_item_entity.dart';
import 'package:academe_x/features/profile/presentation/controllers/cubits/profile_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../../../../../academeX_main.dart';
import '../../../../../../core/pagination/paginated_response.dart';
import '../../../../../../core/pagination/pagination_params.dart';
import '../../../../../../core/utils/storage/cache/hive_cache_manager.dart';
import '../../../../domain/entities/post/post_entity.dart';
import '../../../../domain/entities/post/reactions_entity.dart';
import '../../states/post/post_state.dart';



class PostsCubit extends Cubit<PostsState> {
  final PostUseCase postUseCase;
  final HiveCacheManager _cacheManager;
  // final ProfileCubit profileCubit;
  final ScrollController homePostsScrollController = ScrollController();
  // final ScrollController profilePostsScrollController = ScrollController();
  final ScrollController commentScrollController = ScrollController();



  bool _isLoading = false; // Add loading flag to prevent multiple simultaneous calls
  bool _postsOtherUserisLoading = false; // Add loading flag to prevent multiple simultaneous calls
  bool _commentIsLoading = false; // Add loading flag to prevent multiple simultaneous calls

  PostsCubit({
    required this.postUseCase,
    // required this.profileCubit,
  }) : _cacheManager = getIt<HiveCacheManager>(),
        super(PostsState());



  Future<void> loadPosts({bool refresh = false, int? tagId}) async {
    if (_isLoading) return;
    if (state.hasPostsReachedMax && !refresh) return;

    try {
      _isLoading = true;
      final page = refresh ? 1 : state.postsCurrentPage;

      final result = await postUseCase.getPosts(
        PaginationParams(page: page, tagId: tagId),
      );

      result.fold(
            (failure) {
          emit(state.copyWith(
            status: PostStatus.failure,
            errorMessage: failure.message,
          ));
        },
            (paginatedData) => _handleSuccessResponse(paginatedData, refresh),
      );
    } catch (e) {
      emit(state.copyWith(
        status: PostStatus.failure,
        errorMessage: e.toString(),
      ));
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loadProfilePosts(BuildContext context,{
    required String? username,
    bool fromProfile = false,

  }) async {
    final Either<Failure, PaginatedResponse<PostEntity>> result;
    // if (_postsOtherUserisLoading) return;
    // if (state.hasProfilePostsReachedMax) return;
    if(!fromProfile){
      emit(state.copyWith(
        profileStatus: PostProfileStatus.loading,
      ));
    }
    try {
      // _postsOtherUserisLoading = true;

      if (username == null) {
      final page = state.currentProfilePostsCurrentPage;

        // Load current user from cache
        final currentUser = await context.cachedUser;

        result = await postUseCase.loadProfilePosts(
          PaginationParams(page: page, username: currentUser!.user.username),
        );

        result.fold(
          (l) => emit(state.copyWith(
            profileStatus: PostProfileStatus.failure,
            errorMessage: l.message,
          )),
          (r) => _handleSuccessCurrentProfilePostResponse(r),
        );
      }
      else {
        final page = state.otherProfilePostsCurrentPage;
        result = await postUseCase.loadProfilePosts(
          PaginationParams(page: page, username: username),
        );


        result.fold(
              (l) => emit(state.copyWith(
            profileStatus: PostProfileStatus.failure,
            errorMessage: l.message,
          )),
              (r) => _handleSuccessOtherProfilePostResponse(r),
        );
      }

    } catch (e) {
      emit(state.copyWith(
        profileStatus: PostProfileStatus.failure,
        errorMessage: e.toString(),
      ));
    } finally {
      _postsOtherUserisLoading = false;
    }
  }

  void _handleSuccessResponse(PaginatedResponse<PostEntity> paginatedData, bool refresh) {
    if (refresh) {
      emit(state.copyWith(
        status: PostStatus.success,
        posts: paginatedData.items,
        hasPostsReachedMax: !paginatedData.hasNextPage,
        postsCurrentPage: 2,
        errorMessage: null,
      ));
      return;
    }

    final List<PostEntity> newPosts = [...state.posts];
    for (var newPost in paginatedData.items) {
      if (!newPosts.any((existingPost) => existingPost.id == newPost.id)) {
        newPosts.add(newPost);
      }
    }

    emit(state.copyWith(
      status: PostStatus.success,
      posts: newPosts,
      hasPostsReachedMax: !paginatedData.hasNextPage,
      postsCurrentPage: state.postsCurrentPage + 1,
      errorMessage: null,
    ));
  }


  void _handleSuccessCurrentProfilePostResponse(
      PaginatedResponse<PostEntity> paginatedData,
      ) {
    final List<PostEntity> newPosts = [...state.currentProfilePosts];
    for (var newPost in paginatedData.items) {
      if (!newPosts.any((existingPost) => existingPost.id == newPost.id)) {
        newPosts.add(newPost);
      }
    }

    emit(state.copyWith(
      profileStatus: PostProfileStatus.success,
      currentProfilePosts: newPosts,
      hasCurrentUserProfilePostsReachedMax: !paginatedData.hasNextPage,
      currentProfilePostsCurrentPage: state.currentProfilePostsCurrentPage + 1,
      errorMessage: null,
    ));
  }

  void _handleSuccessOtherProfilePostResponse(
      PaginatedResponse<PostEntity> paginatedData,
      ) {
    final List<PostEntity> newPosts = [...state.otherProfilePosts];
    for (var newPost in paginatedData.items) {
      if (!newPosts.any((existingPost) => existingPost.id == newPost.id)) {
        newPosts.add(newPost);
      }
    }

    emit(state.copyWith(
      profileStatus: PostProfileStatus.success,
      otherProfilePosts: newPosts,
      hasOtherUserProfilePostsReachedMax: !paginatedData.hasNextPage,
      otherProfilePostsCurrentPage: state.otherProfilePostsCurrentPage + 1,
      errorMessage: null,
    ));
  }
  bool isAtTop() {
    return homePostsScrollController.position.pixels <= 0;
  }

  void goToTop() {
    homePostsScrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> loadTagPosts({int? tagId}) async {
    try {
      emit(state.copyWith(status: PostStatus.loading));
      final result = await postUseCase.getPosts(PaginationParams(page:1,tagId:tagId));

      result.fold(
            (failure)async  {
              emit(state.copyWith(
                status: PostStatus.failure,
                errorMessage: failure.message,
              ));
        },
            (paginatedData) {
          emit(state.copyWith(
            status: PostStatus.success,
            posts: paginatedData.items,
            hasPostsReachedMax: !paginatedData.hasNextPage,
            errorMessage: null,
          ));


        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: PostStatus.failure,
        errorMessage: e.toString(),
      ));
    }finally {
      _isLoading = false;
    }
  }

  Future<void> loadPostDetails({required String postId}) async {

      emit(state.copyWith(postDetailsStatus: PostDetailsStatus.loading));

      final result = await postUseCase.getPostDetails(PaginationParams(page: 1,postId: postId));

      result.fold(
            (failure)async  {
          emit(state.copyWith(
            postDetailsStatus: PostDetailsStatus.failure,
            errorMessage: failure.message,
          ));
        },
            (data) {
              emit(state.copyWith(
                postDetailsStatus: PostDetailsStatus.success,
                // posts: [data.data!],
                post: data.data,

                errorMessage: null,
              ));
        },
      );
    }



 Future<void> reactToPost({required String reactType, required int postId,required BuildContext context}) async {
   // context.
    try {
      final mainPostIndex = state.posts.indexWhere((post) => post.id == postId);
      final profilePostIndex = state.currentProfilePosts.indexWhere((post) => post.id == postId);
      final updatedMainPosts = List<PostEntity>.from(state.posts);
      final updatedProfilePosts = List<PostEntity>.from(state.currentProfilePosts);

      final currentUser = await context.cachedUser;
      if (currentUser == null) return;

      final sourcePost = mainPostIndex != -1 ? state.posts[mainPostIndex]
          : state.currentProfilePosts[profilePostIndex];
      final currentReactions = List<ReactionItemEntity>.from(sourcePost.reactions?.items ?? []);



      final existingReactionIndex = currentReactions.indexWhere(
              (reaction) => reaction.user.id == currentUser.user.id
      );

      if (existingReactionIndex != -1) {
        final existingReaction = currentReactions[existingReactionIndex];

        // If it's the same reaction type, remove it (toggle off)
        if (existingReaction.type == reactType) {
          currentReactions.removeAt(existingReactionIndex);
        } else {
          // If it's a different reaction type, replace it
          currentReactions[existingReactionIndex] = ReactionItemEntity(
            id: DateTime.now().millisecondsSinceEpoch,
            type: reactType,
            user: PostUserEntity(
                id: currentUser.user.id,
                username: currentUser.user.username,
                firstName: currentUser.user.firstName,
                lastName: currentUser.user.lastName
            ),
          );
        }
      } else if (reactType != 'none') {
        // Add new reaction if user hasn't reacted before
        currentReactions.add(
          ReactionItemEntity(
            id: DateTime.now().millisecondsSinceEpoch,
            type: reactType,
            user: PostUserEntity(
                id: currentUser.user.id,
                username: currentUser.user.username,
              firstName:  currentUser.user.firstName,
                lastName:  currentUser.user.lastName
          ),
        ));
      }

      // Create updated post with new reactions
      final updatedPost = sourcePost.copyWith(
        reactions: ReactionsEntity(
          count: currentReactions.length,
          items: currentReactions,
        ),
      );

      // Update posts list

      if (mainPostIndex != -1) updatedMainPosts[mainPostIndex] = updatedPost;
      if (profilePostIndex != -1) updatedProfilePosts[profilePostIndex] = updatedPost;

      emit(state.copyWith(
        posts: updatedMainPosts,
        currentProfilePosts: updatedProfilePosts,
        status: PostStatus.success,
      ));
      // AppLogger.success('reaction in updated post: ${currentPosts[postIndex].reactions!.items[0].type}');  // Debug log


      // Make API call
      final result = await postUseCase.reactToPost(reactType, postId);

      result.fold(
            (failure) async {
          AppLogger.e('API call failed: ${failure.message}');  // Debug log
          // Revert changes in case of failure
          emit(state.copyWith(
            posts: state.posts,
            errorMessage: failure.message,
          ));
        },
            (data) {
          AppLogger.success('API call succeeded');  // Debug log

        },
      );
    } catch (e) {
      AppLogger.e('Error in reactToPost: $e');  // Debug log
      emit(state.copyWith(
        status: PostStatus.failure,
        errorMessage: e.toString(),
      ));
    } finally {
      _isLoading = false;
    }
  }

  Future<void> getReactions({required String reactType,required int postId,bool fromScroll=false}) async {
    if (_isLoading) return;
    // if (state.hasReactionsReachedMax) return;
    try {
      _isLoading = true;
      final page = !fromScroll?1: state.reactionsCurrentPage;
      if (kDebugMode) {
        print('Before load - Current page reaction: ${state.reactionsCurrentPage}');
        print('Loading page reaction: $page');
        print('After load - Next page reaction will be: ${state.reactionsCurrentPage + 1}');
      }
      emit(state.copyWith(reactionStatus: ReactionStatus.loading,selectedType: reactType));

      // Make API call
      final result = await postUseCase.getReactions(PaginationParams(page: page),reactType,postId);

      result.fold(
            (failure) async {
          AppLogger.e('API call failed: ${failure.message}');  // Debug log

          // Revert changes in case of failure
          emit(state.copyWith(
            reactionStatus: ReactionStatus.failure,
            reactionItems: [],
            errorMessage: failure.message,
              selectedType: reactType
          ));
        },
            (data) {
              final List<ReactionItemEntity> newReactions = [...?state.reactionItems];
              if (!fromScroll) {
                newReactions.clear();
              }
              for (var newReaction in data.items) {
                if (!newReactions.any((existingReaction) => existingReaction.id == newReaction.id)) {
                  newReactions.add(newReaction);
                }
              }
              final nextPage =!fromScroll?1: state.reactionsCurrentPage + 1;
              emit(state.copyWith(
                reactionStatus: ReactionStatus.success,
                reactionItems: !fromScroll?data.items: newReactions,                // posts: newPosts,
                hasReactionsReachedMax: !data.hasNextPage,
                statisticsEntity: data.statisticsModel!,
                reactionsCurrentPage:nextPage,
                errorMessage: null,
              ));

          // AppLogger.success('API call succeeded ${data.statisticsModel!}');  // Debug log
          // emit(state.copyWith(
          //   reactionStatus: ReactionStatus.success,
          //   reactionItems:data.items,
          //     statisticsEntity: data.statisticsModel,
          //     selectedType: reactType
          // ));

        },
      );
    } catch (e) {
      // final cachedPosts = await _getCachedPosts();
      emit(state.copyWith(
        status: PostStatus.failure,
        errorMessage: e.toString(),
      ));

    } finally {
      _isLoading = false;
    }
  }
  Future<void> savePost({required int postId,required BuildContext context,required bool isSaved}) async {
    try {

      // Create a deep copy of current posts
      final updatedPosts = List<PostEntity>.from(state.posts);

      // Update post in the list
      final postIndex = updatedPosts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        updatedPosts[postIndex] = updatedPosts[postIndex].copyWith(
            isSaved: !isSaved
        );

      }
      List<PostEntity> savedPostsList= updatedPosts.where((element) => element.isSaved!,).toList();

      context.read<ProfileCubit>().addPostOrDeleteToSavedPosts(context,updatedPosts[postIndex]);

      emit(state.copyWith(
        posts: updatedPosts,
        postsSavedList: savedPostsList,
        status: PostStatus.success,
      ));


      final result = await postUseCase.savePost(postId);

      result.fold(
            (failure) async {
          AppLogger.e('API call failed: ${failure.message}');
          // Revert changes in case of failure
          emit(state.copyWith(
            errorMessage: failure.message,
          ));
        },
            (paginatedData) {},
      );
    } catch (e) {
      emit(state.copyWith(
        status: PostStatus.failure,
        errorMessage: e.toString(),
      ));
    } finally {
      _isLoading = false;
    }
  }

  @override
  void emit(PostsState state) {
    // Logger().d(state);
    super.emit(state);
  }

  // Future<List<PostEntity>?> _getCachedPosts() async {
  //   try {
  //      final postsFromCache=  await _cacheManager.getCachedResponse<List<PostEntity>>(
  //       CacheKeys.POSTS,
  //           (json) => (json as List)
  //           .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
  //           .toList(),
  //     );
  //      AppLogger.success(postsFromCache!.length.toString());
  //
  //      return postsFromCache;
  //   } catch (e) {
  //     AppLogger.w('Failed to get posts from cache: $e');
  //     return null;
  //   }
  // }

  Future<void> clearCache() async {
    try {
      await _cacheManager.removeCacheItem(CacheKeys.POSTS);
    } catch (e) {
      AppLogger.w('Failed to clear cache: $e');
    }
  }

  Future<void> refreshPosts(int tagId) async {
    emit(state.copyWith(
      status: PostStatus.loading,
      posts: [],
      hasPostsReachedMax: false,
      postsCurrentPage: 1,
    ));
    // await clearCache();
    await loadPosts(refresh: true,tagId:tagId);
  }

  cancelCreationPostState(){
    emit(state.copyWith(creationStatus: CreationStatus.initial));
  }

  sendPost({required PostEntity post,required BuildContext context}) async {
    // Logger().d(post);
    emit(state.copyWith(creationStatus: CreationStatus.loading));
    var createPostRes = await postUseCase.createPost(post,context);
    createPostRes.fold(
      (l) {
        emit(
          state.copyWith(
            creationStatus: CreationStatus.failure,
            creationPostErrorMessage: l.message,
          ),
        );
      },
      (r) {
        emit(state.copyWith(
            creationStatus: CreationStatus.success,
            posts: [r, ...state.posts]));


      },
    );
  }

  getComments({bool refresh = false,required int postId}) async {



    bool noComments = state.posts[_getPostIndexByPostId(postId)].commentsCount == 0;
    if (state.latestPostIdGetHereComments != postId) {
      refresh = true;
      emit(state.copyWith(
        commentsStatus: noComments? CommentsStatus.success:CommentsStatus.loading,
        hasCommentReachedMax: false,
        latestPostIdGetHereComments: postId,
        commentCurrentPage: 1,
        comments: [],

      ));
    }
    if(noComments)return;
    if ((refresh && state.commentsStatus == CommentsStatus.failure)) {
      emit(state.copyWith(
        commentsStatus: CommentsStatus.initial,
        latestPostIdGetHereComments: postId,
      ));
    }

    Logger().f('$_commentIsLoading ${state.hasCommentReachedMax}');
    if(_commentIsLoading) return;
    if(state.hasCommentReachedMax) return;

      // emit(state.copyWith(commentsStatus: CommentsStatus.loading));
    _commentIsLoading = true;
        emit(state.copyWith(
          commentsStatus: CommentsStatus.loading,
        ));

      final page = refresh ? 1 : state.commentCurrentPage;
     Logger().d('current page:$page');

      final result = await postUseCase.getComments(PaginationParams(page: page),postId);
      result.fold(
      (failure) async {
        emit(
          state.copyWith(
            commentsStatus: CommentsStatus.failure,
            commentError: failure.message,
          ),
        );
      },
            (paginatedData) {
          if (refresh) {
            emit(state.copyWith(
              commentsStatus: CommentsStatus.success,
              comments: paginatedData.items,
              hasCommentReachedMax: !paginatedData.hasNextPage,
              commentCurrentPage: state.commentCurrentPage+1,
              commentError: null,
            ));
            return;
          }
          final List<CommentEntity> newComments = state.comments;
          for (var newComment in paginatedData.items) {
            if (!newComments.any((existingComment) => existingComment.id == newComment.id)) {
              newComments.add(newComment);
            }
          }
          emit(state.copyWith(
            commentsStatus: CommentsStatus.success,
            comments: newComments,
            hasCommentReachedMax: !paginatedData.hasNextPage,
            commentCurrentPage:state.postsCurrentPage +1,
            commentError: null,
          ));
        },
      );
    // } catch (e) {
    //   emit(state.copyWith(
    //     commentsStatus: CommentsStatus.failure,
    //     errorMessage: e.toString(),
    //   ));
    // }finally {
      _commentIsLoading = false;
    // }


  }

  retrySendFailureComments(){
    List<CommentEntity> failureComments = state.failureComments;
    // int length = failureComments.length;
    // for(int i =0; i< failureComments.length;i++){
    //   if(state.createCommentStatus == CreateCommentStatus.success || i == 0){
    //     if(i!=0) state.failureComments.removeAt(i-1);
    //     createComment(postId: failureComments[i].postId!, content: failureComments[i].content!,withoutAddNew: true);
    //   }
    // }

  }
  int _getPostIndexByPostId(int postId){
    for(int i =0; i<state.posts.length;i++){
      if(state.posts[i].id == postId) {
        return i;
      };
    }
    return -1;
  }
  int _getCommentIndexByCommentId(int commentId){
    for(int i =0; i<state.comments.length;i++){
      if(state.comments[i].id == commentId) {
        return i;
      };
    }
    return -1;
  }
  int _getCommentIndexByContent(String content){
    for(int i =state.comments.length - 1; i>=0;i--){
      if(state.comments[i].content == content) {
        return i;
      };
    }
    return -1;
  }
  actionsOnComment({required int postId,String? content,withoutAddNew = false}){
    Logger().w(state.commentAction);
    emit(state.copyWith(commentsStatus: CommentsStatus.loading));
    if(state.commentAction == CommentAction.create){
      createComment(postId: postId, content: content!,withoutAddNew: withoutAddNew);
    }else if(state.commentAction == CommentAction.update){
      updateComment(postId: postId,commentId: state.actionCommentId, content: content!);
    }else if(state.commentAction == CommentAction.delete){
      deleteComment(postId: postId,commentId: state.actionCommentId);
    }
    emit(state.copyWith(commentAction: CommentAction.create));
    Future.delayed(const Duration(milliseconds: 500),() => emit(state.copyWith(commentsStatus: CommentsStatus.success)),);
  }
  deleteComment({required int postId,required int commentId}) async {
    emit(state.copyWith(
      updateDeleteCommentStatus: UpdateDeleteCommentStatus.loading,
    ));
    Either<Failure, Unit> response = await postUseCase.deleteComment(postId: postId, commentId: commentId);
    response.fold((l) {
      Logger().e(l.message);
      emit(state.copyWith(
        updateDeleteCommentStatus: UpdateDeleteCommentStatus.failure,
        commentError: l.message,
          commentsStatus: CommentsStatus.success,
      ));
    }, (r) {
      state.comments.removeAt(_getCommentIndexByCommentId(commentId));
      state.posts[_getPostIndexByPostId(postId)].commentsCount = state.posts[_getPostIndexByPostId(postId)].commentsCount! -1;

      emit(state.copyWith(
        updateDeleteCommentStatus: UpdateDeleteCommentStatus.success,
          commentsStatus: CommentsStatus.success,

      ));
    },);
  }
  updateComment({required int postId,required String content,required int commentId}) async {
    emit(state.copyWith(
      updateDeleteCommentStatus: UpdateDeleteCommentStatus.loading,
    ));
    Either<Failure, CreatePostBaseResponse> response = await postUseCase.updateComment(postId: postId, content: content, commentId: commentId);
    response.fold((l) {
      emit(state.copyWith(
        updateDeleteCommentStatus: UpdateDeleteCommentStatus.failure,
      ));
    }, (r) {
      state.comments[_getCommentIndexByCommentId(commentId)] = r.data!;
      emit(state.copyWith(
        updateDeleteCommentStatus: UpdateDeleteCommentStatus.success,

      ));
    },);
  }
  createComment({required int postId,required String content,withoutAddNew = false}) async {
    UserResponseEntity user = (await NavigationService.navigatorKey.currentContext!.cachedUser)!.user;
    if(!withoutAddNew) {
      CommentEntity newComment = CommentModel(user: user,
          content: content,
          postId: postId,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isSending: true,
          likes: 0);
      state.comments.add(newComment);
      state.posts[_getPostIndexByPostId(postId)].commentsCount = state.posts[_getPostIndexByPostId(postId)].commentsCount! + 1;
    }
    Logger().d(state.createCommentStatus);
    // if(state.createCommentStatus == CreateCommentStatus.loading) return;
    CommentsStatus previusCommentStatus = state.commentsStatus;
    emit(state.copyWith(
      createCommentStatus: CreateCommentStatus.loading,
      comments: state.comments,
      commentsStatus: CommentsStatus.loading,
    ));
    emit(state.copyWith(commentsStatus: previusCommentStatus));
    Either<Failure, CreatePostBaseResponse> response = await postUseCase.createComment(postId: postId, content: content);

    response.fold(
    (l) {
      Logger().e(l.message);
      emit(state.copyWith(
        createCommentStatus: CreateCommentStatus.failure,
        createCommentError: l.message,
        failureComments: [...state.failureComments,CommentEntity(content: content,postId: postId)]

      ));
    }, (r) {

      // state.comments[_getCommentIndexByContent(content)] = r.data!;
      try {

        emit(state.copyWith(
          createCommentStatus: CreateCommentStatus.success,
        ));
        Future.delayed(const Duration(milliseconds: 500),() => state.comments[_getCommentIndexByContent(content)] = r.data!,);
      }catch (_, e){
        Logger().e('error$e');
      }


    },);

  }

  Future<UserResponseEntity?> getUser(BuildContext context) async {
    UserResponseEntity user = (await context.cachedUser)!.user;
    emit(state.copyWith(
      currentUser: user,
    ));
    return user;
  }
  increaseReplyCunt(int commentId){
    state.comments[_getCommentIndexByCommentId(commentId)].replyCount = (state.comments[_getCommentIndexByCommentId(commentId)].replyCount??0 )+ 1;

    emit(state.copyWith(
      comments: state.comments,
    ));
  }

  @override
  Future<void> close() {
    homePostsScrollController.dispose();
    return super.close();
  }
}