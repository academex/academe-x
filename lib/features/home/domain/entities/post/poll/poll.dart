import 'package:academe_x/features/home/domain/entities/post/poll/poll_option.dart';

class Poll{
  final int id;
  final String question;
  final List<PollOption>? pollOptions; // Nullable list of PollOption
  final int? votedOptionId;

  Poll({
    required this.id,
    required this.question,
    required this.pollOptions,
    this.votedOptionId,
  });

}