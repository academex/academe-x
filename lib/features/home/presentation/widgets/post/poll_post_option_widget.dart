import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post/poll/poll_option.dart';
import '../../controllers/cubits/post/posts_cubit.dart';

class PollOptionWidget extends StatelessWidget {
  final PollOption option;
  final int pollId;
  final int postId;
  final int totalVotes;
  final int? currentVotedOptionId;

  const PollOptionWidget({
    Key? key,
    required this.option,
    required this.pollId,
    required this.postId,
    required this.totalVotes,
    this.currentVotedOptionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentage = totalVotes > 0 
        ? (option.count / totalVotes * 100).round() 
        : 0;

    return InkWell(
      onTap: () => _handleVote(context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: option.isVoted ? Color(0xFF0077FF) : Colors.grey.shade300,
            width: option.isVoted ? 2 : 1,
          ),
          color: option.isVoted 
              ? Color(0xFF0077FF).withOpacity(0.1) 
              : Colors.grey.shade50,
        ),
        child: Stack(
          children: [
            // Progress bar background
            if (totalVotes > 0)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: percentage / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: option.isVoted
                            ? Color(0xFF0077FF).withOpacity(0.2)
                            : Colors.blue.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
              ),
            
            // Content
            Row(
              children: [
                Expanded(
                  child: AppText(
                    text: option.content,
                    fontSize: 14,
                    fontWeight: option.isVoted ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    AppText(
                      text: '$percentage%',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: option.isVoted ? Color(0xFF0077FF) : Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    if (option.isVoted)
                      Icon(
                        Icons.check_circle,
                        size: 20,
                        color: Color(0xFF0077FF),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleVote(BuildContext context) {
    // If clicking the same option that's already voted, do nothing
    if (option.isVoted) return;

    context.read<PostsCubit>().voteOnPoll(
      postId: postId,
      pollId: pollId,
      optionId: option.id,
      previousOptionId: currentVotedOptionId ?? -1,
    );
  }
}