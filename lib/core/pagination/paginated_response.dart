import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/pagination/paginated_meta.dart';
import '../../features/home/data/models/post/statistics_model.dart';

class PaginatedResponse<T> {
  final List<T> items;
  final PaginatedMeta paginatedMeta;
  final StatisticsModel? statisticsModel;

  const PaginatedResponse({
    required this.items,
    required this.paginatedMeta,
    this.statisticsModel,  // Made optional since it can be null
  });

  factory PaginatedResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJson,
      ) {

    // Handle statistics if present
    final statData = json['stat'];
    final StatisticsModel? stats = statData != null
        ? StatisticsModel.fromJson(Map<String, dynamic>.from(statData))
        : null;

    return PaginatedResponse(
      items: (json['data'] as List)
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList(),
      paginatedMeta: PaginatedMeta.fromJson(json['meta'] as Map<String, dynamic>),
      statisticsModel: stats,
    );
  }

  bool get hasNextPage => paginatedMeta.page < paginatedMeta.pagesCount;

}