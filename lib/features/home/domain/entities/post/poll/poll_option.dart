class PollOption{
  final int id;
  final String content;
  final int order;
  final int count;
  final bool isVoted;

  PollOption({
    required this.id,
    required this.content,
    required this.order,
    required this.count,
    required this.isVoted,
  });
}