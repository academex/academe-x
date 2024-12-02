
import 'package:academe_x/features/home/domain/entities/post/reaction_item_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/home/post_entity_s.dart';
import '../../../../domain/entities/post/post_entity.dart';

enum PostStatus { initial, loading, success, failure }
enum ReactionStatus { initial, loading, success, failure }

class PostsState extends Equatable {
  final PostStatus status;
  final ReactionStatus reactionStatus;
  final List<PostEntity> posts;
  List<ReactionItemEntity>? reactionItems;
  final bool hasReachedMax;
    int currentPage;
    bool isSaved;
  final String? errorMessage;
  final String? selectedType;
  final DateTime? lastUpdated;  // Add this to track cache freshness
  final Set<int> savedPostIds;




  PostsState({
    this.status = PostStatus.initial,
    this.posts = const <PostEntity>[],
    this.reactionItems = const <ReactionItemEntity>[],
    this.hasReachedMax = false,
    this.reactionStatus = ReactionStatus.initial,
    this.isSaved = false,
    this.currentPage = 1,
    this.errorMessage,
    this.selectedType,
    this.lastUpdated,
    this.savedPostIds = const {},

  });

  PostsState copyWith({
    PostStatus? status,
    ReactionStatus? reactionStatus,
    List<PostEntity>? posts,
    List<ReactionItemEntity>? reactionItems,
    bool? hasReachedMax,
    bool? isSaved,
    int? currentPage,
    String? errorMessage,
    String? selectedType,
    Set<int>? savedPostIds,

  }) {
    return PostsState(
      status: status ?? this.status,
      reactionStatus: reactionStatus ?? this.reactionStatus,
      posts: posts ?? this.posts,
      reactionItems: reactionItems ?? this.reactionItems,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isSaved: isSaved ?? this.isSaved,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedType: selectedType ?? this.selectedType,
      savedPostIds: savedPostIds ?? this.savedPostIds,

    );
  }

  @override
  List<Object?> get props => [
    status,
    reactionStatus,
    posts,
    reactionItems,
    hasReachedMax,
    currentPage,
    errorMessage,
    selectedType,
    isSaved,
    savedPostIds
  ];
}