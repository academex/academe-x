class PollOption {
  final int id;
  final String content;
  final int order;
  final int count;
  final bool isVoted;

  const PollOption({
    required this.id,
    required this.content,
    required this.order,
    required this.count,
    required this.isVoted,
  });

  PollOption copyWith({
    int? id,
    String? content,
    int? order,
    int? count,
    bool? isVoted,
  }) {
    return PollOption(
      id: id ?? this.id,
      content: content ?? this.content,
      order: order ?? this.order,
      count: count ?? this.count,
      isVoted: isVoted ?? this.isVoted,
    );
  }
}