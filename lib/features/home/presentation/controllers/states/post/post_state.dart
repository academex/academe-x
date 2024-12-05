
import 'package:academe_x/features/home/domain/entities/post/reaction_item_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/statistics_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/home/post_entity_s.dart';
import '../../../../domain/entities/post/post_entity.dart';

enum PostStatus { initial, loading, success, failure }
enum ReactionStatus { initial, loading, success, failure }

class PostsState extends Equatable {
  final PostStatus status;
  final ReactionStatus reactionStatus;
  final StatisticsEntity? statisticsEntity;
  final List<PostEntity> posts;
  List<ReactionItemEntity>? reactionItems;
  final bool hasPostsReachedMax;
  int postsCurrentPage;
  final bool hasReactionsReachedMax;
  int reactionsCurrentPage;
  bool isSaved;
  final String? errorMessage;
  final String? selectedType;
  final DateTime? lastUpdated;  // Add this to track cache freshness





  PostsState({
    this.status = PostStatus.initial,
    this.posts = const <PostEntity>[],
    this.reactionItems = const <ReactionItemEntity>[],
    this.statisticsEntity,
    this.reactionStatus = ReactionStatus.initial,
    this.isSaved = false,
    this.hasPostsReachedMax = false,
    this.postsCurrentPage = 1,
    this.hasReactionsReachedMax=false,
    this.reactionsCurrentPage= 1,
    this.errorMessage,
    this.selectedType,
    this.lastUpdated,

  });

  PostsState copyWith({
    PostStatus? status,
    ReactionStatus? reactionStatus,
    List<PostEntity>? posts,
     StatisticsEntity? statisticsEntity,
    List<ReactionItemEntity>? reactionItems,
    bool? hasPostsReachedMax,
     bool? hasReactionsReachedMax,
    int? reactionsCurrentPage,
    bool? isSaved,
    int? postsCurrentPage,
    String? errorMessage,
    String? selectedType,

  }) {
    return PostsState(
      status: status ?? this.status,
      reactionStatus: reactionStatus ?? this.reactionStatus,
      posts: posts ?? this.posts,
      statisticsEntity: statisticsEntity ?? this.statisticsEntity,
      // posts: posts ?? this.posts,
      hasReactionsReachedMax: hasReactionsReachedMax ?? this.hasReactionsReachedMax,
      reactionsCurrentPage: reactionsCurrentPage ?? this.reactionsCurrentPage,

      reactionItems: reactionItems ?? this.reactionItems,
      hasPostsReachedMax: hasPostsReachedMax ?? this.hasPostsReachedMax,
      isSaved: isSaved ?? this.isSaved,
      postsCurrentPage: postsCurrentPage ?? this.postsCurrentPage,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedType: selectedType ?? this.selectedType,

    );
  }

  @override
  List<Object?> get props => [
    status,
    reactionStatus,
    posts,
    statisticsEntity,
    reactionItems,
    hasPostsReachedMax,
    hasReactionsReachedMax,
    reactionsCurrentPage,
    postsCurrentPage,
    errorMessage,
    selectedType,
    isSaved,
  ];
}