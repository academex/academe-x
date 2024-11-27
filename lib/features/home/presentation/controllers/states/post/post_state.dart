
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/home/post_entity_s.dart';
import '../../../../domain/entities/post/post_entity.dart';

enum PostStatus { initial, loading, success, failure }

class PostsState extends Equatable {
  final PostStatus status;
  final List<PostEntity> posts;
  final bool hasReachedMax;
  late final bool isLoadingPosts;
  final int currentPage;
  final String? errorMessage;

   PostsState({
    this.status = PostStatus.initial,
    this.posts = const <PostEntity>[],
    this.hasReachedMax = false,
    this.isLoadingPosts = false,
    this.currentPage = 1,
    this.errorMessage,
  });

  PostsState copyWith({
    PostStatus? status,
    List<PostEntity>? posts,
    bool? hasReachedMax,
    bool? isLoadingPosts,
    int? currentPage,
    String? errorMessage,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingPosts: isLoadingPosts ?? this.isLoadingPosts,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    posts,
    hasReachedMax,
    isLoadingPosts,
    currentPage,
    errorMessage,
  ];
}