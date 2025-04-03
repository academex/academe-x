import 'package:academe_x/features/home/presentation/widgets/post/poll_post_option_widget.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/post/poll/poll_option.dart';

class PollWidget extends StatelessWidget {
  final List<PollOption> options;
  final String title;
  final int totalVotes;
  final int totalViews;

  const PollWidget({
    Key? key,
    required this.options,
    required this.title,
    required this.totalVotes,
    required this.totalViews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Text(
            title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Poll Options
          ...options.map((option) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: PollOptionWidget(option: option),
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
                    totalVotes.toString(),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Text(
                    'مشاهدة',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    totalViews.toString(),
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