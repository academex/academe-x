
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/home/post_entity_s.dart';
import '../../../../domain/entities/post/post_entity.dart';

enum PostStatus { initial, loading, success, failure }

class PostsState extends Equatable {
  final PostStatus status;
  final List<PostEntity> posts;
  final bool hasReachedMax;
    int currentPage;
    bool isSaved;
  final String? errorMessage;
  final DateTime? lastUpdated;  // Add this to track cache freshness
  final Set<int> savedPostIds;


  PostsState({
    this.status = PostStatus.initial,
    this.posts = const <PostEntity>[],
    this.hasReachedMax = false,
    this.isSaved = false,
    this.currentPage = 1,
    this.errorMessage,
    this.lastUpdated,
    this.savedPostIds = const {},

  });

  PostsState copyWith({
    PostStatus? status,
    List<PostEntity>? posts,
    bool? hasReachedMax,
    bool? isSaved,
    int? currentPage,
    String? errorMessage,
    Set<int>? savedPostIds,

  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isSaved: isSaved ?? this.isSaved,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
      savedPostIds: savedPostIds ?? this.savedPostIds,

    );
  }

  @override
  List<Object?> get props => [
    status,
    posts,
    hasReachedMax,
    currentPage,
    errorMessage,
    isSaved,
    savedPostIds
  ];
}