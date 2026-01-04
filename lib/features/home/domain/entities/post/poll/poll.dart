import 'package:academe_x/features/home/domain/entities/post/poll/poll_option.dart';

class Poll {
  final int id;
  final String question;
  final List<PollOption>? pollOptions;
  final int totalVotes;

  const Poll({
    required this.id,
    required this.question,
    this.pollOptions,
    required this.totalVotes,
  });

  Poll copyWith({
    int? id,
    String? question,
    List<PollOption>? pollOptions,
    int? totalVotes,
  }) {
    return Poll(
      id: id ?? this.id,
      question: question ?? this.question,
      pollOptions: pollOptions ?? this.pollOptions,
      totalVotes: totalVotes ?? this.totalVotes,
    );
  }
}