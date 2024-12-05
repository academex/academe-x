import '../../../domain/entities/post/statistics_entity.dart';

class StatisticsModel extends StatisticsEntity {
  StatisticsModel({Map<String, int>? statistics}) : super(statistics: statistics);

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      statistics: {
        'HEART': json['HEART'] as int? ?? 0,
        'FUNNY': json['FUNNY'] as int? ?? 0,
        'QUESTION': json['QUESTION'] as int? ?? 0,
        'CELEBRATE': json['CELEBRATE'] as int? ?? 0,
        'INSIGHTFUL': json['INSIGHTFUL'] as int? ?? 0,
      },
    );
  }

  Map<String, dynamic> toJson() {
    return statistics;
  }

  // If you need to create from specific values
  factory StatisticsModel.fromValues({
    int? heart,
    int? funny,
    int? question,
    int? insightful,
    int? celebrate,
  }) {
    return StatisticsModel(
      statistics: {
        'HEART': heart ?? 0,
        'FUNNY': funny ?? 0,
        'QUESTION': question ?? 0,
        'CELEBRATE': celebrate ?? 0,
        'INSIGHTFUL': insightful ?? 0,
      },
    );
  }
}