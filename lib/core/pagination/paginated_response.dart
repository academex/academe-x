import 'package:academe_x/core/pagination/paginated_meta.dart';

class PaginatedResponse<T> {
  final List<T> items;
  final PaginatedMeta paginatedMeta;

  const PaginatedResponse({
    required this.items,
    required this.paginatedMeta
  });

  factory PaginatedResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJson,
      ) {
    return PaginatedResponse(
      items: (json['data'] as List)
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList(),
      paginatedMeta: PaginatedMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  bool get hasNextPage => paginatedMeta.page < paginatedMeta.pagesCount;

}

