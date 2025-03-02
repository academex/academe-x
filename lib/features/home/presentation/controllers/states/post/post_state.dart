
import 'package:academe_x/features/auth/auth.dart';
import 'package:academe_x/features/home/domain/entities/post/comment_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/reaction_item_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/statistics_entity.dart';
import 'package:academe_x/features/profile/presentation/controllers/states/profile_state.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/home/post_entity_s.dart';
import '../../../../domain/entities/post/post_entity.dart';

enum PostStatus { initial, loading, success, failure }
enum PostProfileStatus { initial, loading, success, failure }
enum PostDetailsStatus { initial, loading, success, failure }
enum ReactionStatus { initial, loading, success, failure }
enum CreationStatus { initial, loading, success, failure }
enum CommentsStatus { initial, loading, success, failure }
enum CreateCommentStatus { initial, loading, success, failure }
enum UpdateDeleteCommentStatus { initial, loading, success, failure }
enum CommentAction { create, delete, update }

class PostsState extends Equatable {
  final PostStatus status;
  final PostProfileStatus profileStatus;
  final ReactionStatus reactionStatus;
  final PostDetailsStatus postDetailsStatus;
  final CreationStatus creationState;
  final StatisticsEntity? statisticsEntity;
  final List<PostEntity> posts;
  final List<PostEntity> currentProfilePosts;
  final List<PostEntity> otherProfilePosts;
  final PostEntity? post;
  List<ReactionItemEntity>? reactionItems;
  final bool hasPostsReachedMax;
  int postsCurrentPage;
  int currentProfilePostsCurrentPage;
  int otherProfilePostsCurrentPage;
  final bool hasReactionsReachedMax;
  final bool hasCurrentUserProfilePostsReachedMax;
  final bool hasOtherUserProfilePostsReachedMax;
  int reactionsCurrentPage;
  bool isSaved;
  final String? errorMessage;
  final String? creationPostErrorMessage;
  final String? selectedType;
  final DateTime? lastUpdated;  // Add this to track cache freshness
  // this for comment
  final CommentsStatus commentsStatus;
   CreateCommentStatus createCommentStatus;
  UpdateDeleteCommentStatus updateDeleteCommentStatus;
  final List<CommentEntity> comments;
  final List<CommentEntity> failureComments;
  final int latestPostIdGetHereComments;
  final String? commentError;
  final String? createCommentError;
   bool hasCommentReachedMax;
  int commentCurrentPage;
  int actionCommentId;
  CommentAction commentAction;
  final UserResponseEntity? currentUser;






  PostsState({
    this.status = PostStatus.initial,
    this.profileStatus = PostProfileStatus.initial,
    this.creationState = CreationStatus.initial,
    this.postDetailsStatus = PostDetailsStatus.initial,
    this.posts = const <PostEntity>[],
    this.currentProfilePosts = const <PostEntity>[],
    this.otherProfilePosts = const <PostEntity>[],
    this.reactionItems = const <ReactionItemEntity>[],
    this.statisticsEntity,
    this.post,
    this.reactionStatus = ReactionStatus.initial,
    this.isSaved = false,
    this.hasPostsReachedMax = false,
    this.hasCurrentUserProfilePostsReachedMax = false,
    this.hasOtherUserProfilePostsReachedMax = false,
    this.postsCurrentPage = 1,
    this.currentProfilePostsCurrentPage = 1,
    this.otherProfilePostsCurrentPage = 1,
    this.hasReactionsReachedMax=false,
    this.reactionsCurrentPage= 1,
    this.errorMessage,
    this.selectedType,
    this.lastUpdated,
    this.creationPostErrorMessage,
    //for comment
    this.commentsStatus = CommentsStatus.initial,
    this.createCommentStatus = CreateCommentStatus.initial,
    this.updateDeleteCommentStatus = UpdateDeleteCommentStatus.initial,
    this.comments = const [],
    this.failureComments = const [],
    this.commentError,
    this.createCommentError,
    this.commentCurrentPage = 1,
    this.hasCommentReachedMax = false,
    this.latestPostIdGetHereComments = -1,
    this.actionCommentId = -1,
    this.commentAction = CommentAction.create,
    this.currentUser,


  });

  PostsState copyWith({
    PostStatus? status,
    PostProfileStatus?profileStatus,
    CreationStatus? creationStatus,
    PostDetailsStatus? postDetailsStatus,
    ReactionStatus? reactionStatus,
    List<PostEntity>? posts,
    List<PostEntity>? currentProfilePosts,
    List<PostEntity>? otherProfilePosts,
    PostEntity? post,
     StatisticsEntity? statisticsEntity,
    List<ReactionItemEntity>? reactionItems,
    bool? hasPostsReachedMax,
    bool? hasCommentReachedMax,
     bool? hasReactionsReachedMax,
     bool? hasCurrentUserProfilePostsReachedMax,
     bool? hasOtherUserProfilePostsReachedMax,
    int? reactionsCurrentPage,
    bool? isSaved,
    int? postsCurrentPage,
    int? currentProfilePostsCurrentPage,
    int? otherProfilePostsCurrentPage,
    String? errorMessage,
    String? selectedType,
    String? creationPostErrorMessage,
    CommentsStatus? commentsStatus,
    CreateCommentStatus? createCommentStatus,
    String? commentError,
    String? createCommentError,
    List<CommentEntity>? comments,
    List<CommentEntity>? failureComments,
    int? commentCurrentPage,
    int? latestPostIdGetHereComments,
    int? actionCommentId,
    CommentAction? commentAction,
    UpdateDeleteCommentStatus? updateDeleteCommentStatus,
    UserResponseEntity? currentUser,


  }) {
    return PostsState(
      status: status ?? this.status,
      profileStatus: profileStatus ?? this.profileStatus,
      creationState: creationStatus ?? this.creationState,
      reactionStatus: reactionStatus ?? this.reactionStatus,
      post: post ?? this.post,
      posts: posts ?? this.posts,
      currentProfilePosts: currentProfilePosts ?? this.currentProfilePosts,
      otherProfilePosts: otherProfilePosts ?? this.otherProfilePosts,
      statisticsEntity: statisticsEntity ?? this.statisticsEntity,
      postDetailsStatus: postDetailsStatus ?? this.postDetailsStatus,
      // posts: posts ?? this.posts,
      hasReactionsReachedMax: hasReactionsReachedMax ?? this.hasReactionsReachedMax,
      reactionsCurrentPage: reactionsCurrentPage ?? this.reactionsCurrentPage,

      reactionItems: reactionItems ?? this.reactionItems,
      hasCurrentUserProfilePostsReachedMax: hasCurrentUserProfilePostsReachedMax ?? this.hasCurrentUserProfilePostsReachedMax,
      hasOtherUserProfilePostsReachedMax: hasOtherUserProfilePostsReachedMax ?? this.hasOtherUserProfilePostsReachedMax,
      hasPostsReachedMax: hasPostsReachedMax ?? this.hasPostsReachedMax,
      hasCommentReachedMax: hasCommentReachedMax ?? this.hasCommentReachedMax,
      isSaved: isSaved ?? this.isSaved,
      postsCurrentPage: postsCurrentPage ?? this.postsCurrentPage,
      currentProfilePostsCurrentPage: currentProfilePostsCurrentPage ?? this.currentProfilePostsCurrentPage,
      otherProfilePostsCurrentPage: otherProfilePostsCurrentPage ?? this.otherProfilePostsCurrentPage,
      errorMessage: errorMessage ?? this.errorMessage,
      creationPostErrorMessage: creationPostErrorMessage ?? this.creationPostErrorMessage,
      selectedType: selectedType ?? this.selectedType,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      // comment
      comments: comments ?? this.comments,
      failureComments: failureComments ?? this.failureComments,
      commentsStatus: commentsStatus ?? this.commentsStatus,
      createCommentStatus: createCommentStatus ?? this.createCommentStatus,
      commentError: commentError ?? this.commentError,
      createCommentError: createCommentError ?? this.createCommentError,
      commentCurrentPage: commentCurrentPage ?? this.commentCurrentPage,
      latestPostIdGetHereComments: latestPostIdGetHereComments ?? this.latestPostIdGetHereComments,
      actionCommentId: actionCommentId ?? this.actionCommentId,
      commentAction: commentAction ?? this.commentAction,
      updateDeleteCommentStatus: updateDeleteCommentStatus ?? this.updateDeleteCommentStatus,
      currentUser: currentUser ?? this.currentUser,

    );
  }

  @override
  List<Object?> get props => [
    creationState,
    postDetailsStatus,
    status,
    profileStatus,
    reactionStatus,
    posts,
    statisticsEntity,
    currentProfilePostsCurrentPage,
    otherProfilePostsCurrentPage,
    hasCurrentUserProfilePostsReachedMax,
    hasOtherUserProfilePostsReachedMax,
    reactionItems,
    currentProfilePosts,
    hasPostsReachedMax,
    hasCommentReachedMax,
    hasReactionsReachedMax,
    reactionsCurrentPage,
    postsCurrentPage,
    errorMessage,
    selectedType,
    isSaved,
    creationPostErrorMessage,
    comments,
    commentError,
    commentsStatus,
    commentCurrentPage,
    latestPostIdGetHereComments,
    createCommentStatus,
    createCommentError,
    failureComments,
    actionCommentId,
    commentAction,
    updateDeleteCommentStatus,
    currentUser,
  ];
}