class PaginatedMeta {
  final int page;
  final int limit;
  final int pagesCount;
  final int totalPosts;

  const PaginatedMeta({
    required this.page,
    required this.limit,
    required this.pagesCount,
    required this.totalPosts,
  });

  factory PaginatedMeta.fromJson(Map<String, dynamic> json) {
    return PaginatedMeta(
      page: json['page'] as int,
      limit: json['limit'] as int,
      pagesCount: json['PagesCount'] as int,
      totalPosts: json['total'] as int,
    );
  }
}