class PaginationParams {
  final int page;
  final int limit;
  final String? postId;

  const PaginationParams({
    required this.page,
    this.limit = 10,
    this.postId=''
  });

  Map<String, dynamic> toJson() => {
    'page': page,
    'limit': limit,
    'postId': postId,
  };
}