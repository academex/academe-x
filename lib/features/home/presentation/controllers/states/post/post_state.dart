
import 'package:academe_x/features/home/domain/entities/post/comment_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/reaction_item_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/statistics_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/home/post_entity_s.dart';
import '../../../../domain/entities/post/post_entity.dart';

enum PostStatus { initial, loading, success, failure }
enum PostDetailsStatus { initial, loading, success, failure }
enum ReactionStatus { initial, loading, success, failure }
enum CreationStatus { initial, loading, success, failure }
enum CommentsStatus { initial, loading, success, failure }

class PostsState extends Equatable {
  final PostStatus status;
  final ReactionStatus reactionStatus;
  final PostDetailsStatus postDetailsStatus;
  final CreationStatus creationState;
  final StatisticsEntity? statisticsEntity;
  final List<PostEntity> posts;
  final PostEntity? post;
  List<ReactionItemEntity>? reactionItems;
  final bool hasPostsReachedMax;
  int postsCurrentPage;
  final bool hasReactionsReachedMax;
  int reactionsCurrentPage;
  bool isSaved;
  final String? errorMessage;
  final String? creationPostErrorMessage;
  final String? selectedType;
  final DateTime? lastUpdated;  // Add this to track cache freshness
  // this for comment
  final CommentsStatus commentsStatus;
  final List<CommentEntity> comments;
  final int latestPostIdGetHereComments;
  final String? commentError;
   bool hasCommentReachedMax;
  int commentCurrentPage;






  PostsState({
    this.status = PostStatus.initial,
    this.creationState = CreationStatus.initial,
    this.postDetailsStatus = PostDetailsStatus.initial,
    this.posts = const <PostEntity>[],
    this.reactionItems = const <ReactionItemEntity>[],
    this.statisticsEntity,
    this.post,
    this.reactionStatus = ReactionStatus.initial,
    this.isSaved = false,
    this.hasPostsReachedMax = false,
    this.postsCurrentPage = 1,
    this.hasReactionsReachedMax=false,
    this.reactionsCurrentPage= 1,
    this.errorMessage,
    this.selectedType,
    this.lastUpdated,
    this.creationPostErrorMessage,
    //for comment
    this.commentsStatus = CommentsStatus.initial,
    this.comments = const [],
    this.commentError,
    this.commentCurrentPage = 1,
    this.hasCommentReachedMax = false,
    this.latestPostIdGetHereComments = -1,


  });

  PostsState copyWith({
    PostStatus? status,
    CreationStatus? creationStatus,
    PostDetailsStatus? postDetailsStatus,
    ReactionStatus? reactionStatus,
    List<PostEntity>? posts,
    PostEntity? post,
     StatisticsEntity? statisticsEntity,
    List<ReactionItemEntity>? reactionItems,
    bool? hasPostsReachedMax,
    bool? hasCommentReachedMax,
     bool? hasReactionsReachedMax,
    int? reactionsCurrentPage,
    bool? isSaved,
    int? postsCurrentPage,
    String? errorMessage,
    String? selectedType,
    String? creationPostErrorMessage,
    CommentsStatus? commentsStatus,
    String? commentError,
    List<CommentEntity>? comments,
    int? commentCurrentPage,
    int? latestPostIdGetHereComments,

  }) {
    return PostsState(
      status: status ?? this.status,
      creationState: creationStatus ?? this.creationState,
      reactionStatus: reactionStatus ?? this.reactionStatus,
      post: post ?? this.post,
      posts: posts ?? this.posts,
      statisticsEntity: statisticsEntity ?? this.statisticsEntity,
      postDetailsStatus: postDetailsStatus ?? this.postDetailsStatus,
      // posts: posts ?? this.posts,
      hasReactionsReachedMax: hasReactionsReachedMax ?? this.hasReactionsReachedMax,
      reactionsCurrentPage: reactionsCurrentPage ?? this.reactionsCurrentPage,

      reactionItems: reactionItems ?? this.reactionItems,
      hasPostsReachedMax: hasPostsReachedMax ?? this.hasPostsReachedMax,
      hasCommentReachedMax: hasCommentReachedMax ?? this.hasCommentReachedMax,
      isSaved: isSaved ?? this.isSaved,
      postsCurrentPage: postsCurrentPage ?? this.postsCurrentPage,
      errorMessage: errorMessage ?? this.errorMessage,
      creationPostErrorMessage: creationPostErrorMessage ?? this.creationPostErrorMessage,
      selectedType: selectedType ?? this.selectedType,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      // comment
      comments: comments ?? this.comments,
      commentsStatus: commentsStatus ?? this.commentsStatus,
      commentError: commentError ?? this.commentError,
      commentCurrentPage: commentCurrentPage ?? this.commentCurrentPage,
      latestPostIdGetHereComments: latestPostIdGetHereComments ?? this.latestPostIdGetHereComments,

    );
  }

  @override
  List<Object?> get props => [
    creationState,
    postDetailsStatus,
    status,
    reactionStatus,
    posts,
    statisticsEntity,
    reactionItems,
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
  ];
}