import 'package:academe_x/core/constants/cache_keys.dart';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/features.dart';
import 'package:academe_x/features/home/domain/entities/post/post_user_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/reaction_item_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/pagination/pagination_params.dart';
import '../../../../data/models/post/post_model.dart';
import '../../../../domain/entities/post/post_entity.dart';
import '../../../../domain/entities/post/reactions_entity.dart';
import '../../states/post/post_state.dart';



class PostsCubit extends Cubit<PostsState> {
  final PostUseCase postUseCase;
  final HiveCacheManager _cacheManager;


  bool _isLoading = false; // Add loading flag to prevent multiple simultaneous calls

  PostsCubit({
    required this.postUseCase,
  }) : _cacheManager = getIt<HiveCacheManager>(),
        super(PostsState());



  Future<void> loadPosts({bool refresh = false}) async {
    if (_isLoading) return;
    if (state.hasReachedMax && !refresh) return;
    try {
      _isLoading = true;

      final page = refresh ? 1 : state.currentPage;
      if (kDebugMode) {
        print('Before load - Current page: ${state.currentPage}');
        print('Loading page: $page');
        print('After load - Next page will be: ${state.currentPage + 1}');


      }
        emit(state.copyWith(status: PostStatus.loading));

      final result = await postUseCase.getPosts(PaginationParams(page: page));

      result.fold(
            (failure)async  {
              final cachedPosts = await _getCachedPosts();

              if (cachedPosts != null && cachedPosts.isNotEmpty) {
                // If we have cached posts, use them
                emit(state.copyWith(
                  status: PostStatus.success,
                  posts: cachedPosts,
                  errorMessage: 'Using cached data: ${failure.message}',
                  hasReachedMax: true, // Prevent pagination in offline mode
                ));
              } else {
                // If no cache, show error
                emit(state.copyWith(
                  status: PostStatus.failure,
                  errorMessage: failure.message,
                ));
              }
        },
            (paginatedData) {

              if (refresh) {
                emit(state.copyWith(
                  status: PostStatus.success,
                  posts: paginatedData.items,
                  hasReachedMax: !paginatedData.hasNextPage,
                  currentPage: 2,
                  errorMessage: null,
                ));
                return;
              }
              final List<PostEntity> newPosts = [...state.posts];

              // Add only non-duplicate items from paginatedData
              for (var newPost in paginatedData.items) {
                if (!newPosts.any((existingPost) => existingPost.id == newPost.id)) {
                  newPosts.add(newPost);
                }
              }
              final nextPage = state.currentPage + 1;
          emit(state.copyWith(
            status: PostStatus.success,
            posts: newPosts,
            hasReachedMax: !paginatedData.hasNextPage,
            currentPage:nextPage,
            errorMessage: null,
          ));
        },
      );
    } catch (e) {
      final cachedPosts = await _getCachedPosts();

      if (cachedPosts != null && cachedPosts.isNotEmpty) {
        emit(state.copyWith(
          status: PostStatus.success,
          posts: cachedPosts,
          errorMessage: 'Using cached data: $e',
          hasReachedMax: true, // Prevent pagination in offline mode
        ));
      } else {
        emit(state.copyWith(
          status: PostStatus.failure,
          errorMessage: e.toString(),
        ));
      }
    }finally {
      _isLoading = false;
    }
  }









  Future<void> reactToPost({required String reactType, required int postId,required BuildContext context}) async {

    try {
      // If posts are empty, try to get them from cache first
      if (state.posts.isEmpty) {
        final cachedPosts = await _getCachedPosts();
        if (cachedPosts != null && cachedPosts.isNotEmpty) {
          emit(state.copyWith(
            posts: cachedPosts,
            status: PostStatus.success,
          ));
        } else {
          AppLogger.e('No posts found in state or cache');  // Debug log
          return; // Exit if we can't find any posts
        }
      }

      // Create a copy of current posts
      final currentPosts = List<PostEntity>.from(state.posts);
      final postIndex = currentPosts.indexWhere((post) => post.id == postId);


      if (postIndex == -1) {
        return;
      }

      // Get current user
      final currentUser = await context.cachedUser;
      if (currentUser == null) {
        return;
      }

      // Get current post
      final currentPost = currentPosts[postIndex];

      // Create updated reactions list
      final currentReactions = List<ReactionItemEntity>.from(currentPost.reactions?.items ?? []);


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
      final updatedPost = currentPost.copyWith(
        reactions: ReactionsEntity(
          count:currentReactions.length ,
          items: currentReactions,
        ),

      );

      // Update posts list
      currentPosts[postIndex] = updatedPost;

      // Emit new state with updated posts
      emit(state.copyWith(
        posts: currentPosts,
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
      final cachedPosts = await _getCachedPosts();

      if (cachedPosts != null && cachedPosts.isNotEmpty) {
        emit(state.copyWith(
          status: PostStatus.success,
          posts: cachedPosts,
          errorMessage: 'Using cached data: $e',
          hasReachedMax: true,
        ));
      } else {
        emit(state.copyWith(
          status: PostStatus.failure,
          errorMessage: e.toString(),
        ));
      }
    } finally {
      _isLoading = false;
    }
  }

  Future<void> getUsersByReactionType({required String reactType,required int postId}) async {
    try {
      emit(state.copyWith(reactionStatus: ReactionStatus.loading,selectedType: reactType));

      // Make API call
      final result = await postUseCase.getUsersByReactionType(PaginationParams(page: 1),reactType,postId);

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

          AppLogger.success('API call succeeded');  // Debug log
          emit(state.copyWith(
            reactionStatus: ReactionStatus.success,
            reactionItems:data.items,
              selectedType: reactType
          ));

        },
      );
    } catch (e) {
      AppLogger.e('Error in reactToPost: $e');  // Debug log
      final cachedPosts = await _getCachedPosts();

      if (cachedPosts != null && cachedPosts.isNotEmpty) {
        emit(state.copyWith(
          status: PostStatus.success,
          posts: cachedPosts,
          errorMessage: 'Using cached data: $e',
          hasReachedMax: true,
        ));
      } else {
        emit(state.copyWith(
          status: PostStatus.failure,
          errorMessage: e.toString(),
        ));
      }
    } finally {
      _isLoading = false;
    }
  }




  Future<void> savePost({required int postId,required bool isSaved}) async {
    try {

      // Create a deep copy of current posts
      final updatedPosts = List<PostEntity>.from(state.posts);
      final updatedSavedPostIds = Set<int>.from(state.savedPostIds);

      // Update post in the list
      final postIndex = updatedPosts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        updatedPosts[postIndex] = updatedPosts[postIndex].copyWith(
            isSaved: !isSaved
        );
      }

      // Update saved post IDs set
      if (isSaved) {
        updatedSavedPostIds.remove(postId);
      } else {
        updatedSavedPostIds.add(postId);
      }

      // Emit optimistic update immediately
      emit(state.copyWith(
        posts: updatedPosts,
        savedPostIds: updatedSavedPostIds,
        status: PostStatus.success,
      ));
      final result = await postUseCase.savePost(postId);

      result.fold(
            (failure) async {
          AppLogger.e('API call failed: ${failure.message}');
          // Revert changes in case of failure
          emit(state.copyWith(
            savedPostIds: state.savedPostIds,
            errorMessage: failure.message,
          ));
        },
            (paginatedData) {
        },
      );
    } catch (e) {
      final cachedPosts = await _getCachedPosts();

      if (cachedPosts != null && cachedPosts.isNotEmpty) {
        emit(state.copyWith(
          status: PostStatus.success,
          posts: cachedPosts,
          errorMessage: 'Using cached data: $e',
          hasReachedMax: true,
        ));
      } else {
        emit(state.copyWith(
          status: PostStatus.failure,
          errorMessage: e.toString(),
        ));
      }
    } finally {
      _isLoading = false;
    }
  }


// Also add this to your PostsCubit class:
  @override
  void emit(PostsState state) {
    AppLogger.success('Emitting new state -$state');  // Debug log
    super.emit(state);
  }
  Future<List<PostEntity>?> _getCachedPosts() async {
    try {
      return await _cacheManager.getCachedResponse<List<PostEntity>>(
        CacheKeys.POSTS,
            (json) => (json as List)
            .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      AppLogger.w('Failed to get posts from cache: $e');
      return null;
    }
  }

  Future<void> clearCache() async {
    try {
      await _cacheManager.removeCacheItem(CacheKeys.POSTS);
    } catch (e) {
      AppLogger.w('Failed to clear cache: $e');
    }
  }

  Future<void> refreshPosts() async {
    emit(state.copyWith(
      status: PostStatus.loading,
      posts: [],
      hasReachedMax: false,
      currentPage: 1,
    ));
    await clearCache();
    await loadPosts(refresh: true);
  }
}