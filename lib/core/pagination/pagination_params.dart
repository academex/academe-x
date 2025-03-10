class PaginationParams {
  final int page;
  final int limit;
  final String? postId;
  final int? tagId;
  final int? yearNum;
  final String? username;

  const PaginationParams(
      {required this.page,
      this.limit = 10,
      this.postId = '',
      this.tagId,
      this.yearNum,
      this.username = ''});

  Map<String, dynamic> toJson() => {
        'page': page,
        'limit': limit,
        'postId': postId,
        'tagId': tagId,
        'yearNum': yearNum,
        'userName': username
      };
}
