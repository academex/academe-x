import 'package:dartz/dartz.dart';

import '../../../../features/home/data/models/post/post_model.dart';

class CachedPaginatedData {
  final List<PostModel> posts;
  final Map<int, List<int>> pageToPostIds;
  final Map<int, DateTime> pageTimestamps;

  CachedPaginatedData({
    required this.posts,
    required this.pageToPostIds,
    required this.pageTimestamps,
  });

  Map<String, dynamic> toJson() => {
    'posts': posts.map((post) => post.toJson()).toList(),
    'pageToPostIds': pageToPostIds.map(
          (key, value) => MapEntry(key.toString(), value),
    ),
    'pageTimestamps': pageTimestamps.map(
          (key, value) => MapEntry(key.toString(), value.toIso8601String()),
    ),
  };

  factory CachedPaginatedData.fromJson(Map<String, dynamic> json) {
    final posts = (json['posts'] as List)
        .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
        .toList();

    final pageToPostIds = (json['pageToPostIds'] as Map<String, dynamic>)
        .map((key, value) => MapEntry(
      int.parse(key),
      (value as List).cast<int>(),
    ));

    final pageTimestamps = (json['pageTimestamps'] as Map<String, dynamic>)
        .map((key, value) => MapEntry(
      int.parse(key),
      DateTime.parse(value as String),
    ));

    return CachedPaginatedData(
      posts: posts,
      pageToPostIds: pageToPostIds,
      pageTimestamps: pageTimestamps,
    );
  }
}