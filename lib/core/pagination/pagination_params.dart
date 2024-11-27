class PaginationParams {
  final int page;
  final int limit;

  const PaginationParams({
    required this.page,
    this.limit = 10,
  });

  Map<String, dynamic> toJson() => {
    'page': page,
    'limit': limit,
  };
}