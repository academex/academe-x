class PaginationParams {
  final int page;
  final int limit;
  final String? postId;
  final int? tagId;
  final String? username;

  const PaginationParams(
      {required this.page,
      this.limit = 10,
      this.postId = '',
      this.tagId,
      this.username = ''});

  Map<String, dynamic> toJson() => {
        'page': page,
        'limit': limit,
        'postId': postId,
        'tagId': tagId,
        'userName': username
      };
}
