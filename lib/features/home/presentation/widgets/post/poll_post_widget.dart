import 'package:academe_x/features/home/presentation/widgets/post/poll_post_option_widget.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/post/poll/poll_option.dart';

class PollWidget extends StatefulWidget {
  final int pollId;
  final int postId;
  final List<PollOption> options;
  final String title;
  final int totalVotes;
  final int totalViews;

  const PollWidget({
    Key? key,
    required this.pollId,
    required this.postId,
    required this.options,
    required this.title,
    required this.totalVotes,
    required this.totalViews,
  }) : super(key: key);

  @override
  State<PollWidget> createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
  PollOption? votedOption; // Changed to nullable

  @override
  void initState() {
    super.initState();
    // Use try-catch or orElse to handle when no option is voted
    try {
      votedOption = widget.options.firstWhere(
        (opt) => opt.isVoted,
      );
    } catch (e) {
      votedOption = null; // No voted option found
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Text(
            widget.title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Poll Options
          ...widget.options.map((option) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: PollOptionWidget(
                  option: option,
                  pollId: widget.pollId,
                  postId: widget.postId,
                  totalVotes: widget.totalVotes,
                  currentVotedOptionId: votedOption?.id, // Use null-safe access
                ),
              )),

          // Footer Stats
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    'صوت',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.totalVotes.toString(),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
