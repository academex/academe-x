class StatisticsEntity {
  final Map<String, int> statistics;

  StatisticsEntity({Map<String, int>? statistics})
      : statistics = statistics ?? {
    'HEART': 0,
    'FUNNY': 0,
    'QUESTION': 0,
    'INSIGHTFUL': 0,
    'CELEBRATE': 0,
  };

  // Convenience getters
  int get heart => getValue('HEART');
  int get funny => getValue('FUNNY');
  int get question => getValue('QUESTION');
  int get celebrate => getValue('CELEBRATE');
  int get insightful => getValue('INSIGHTFUL');

  // Safe value access
  int getValue(String key) => statistics[key] ?? 0;
}