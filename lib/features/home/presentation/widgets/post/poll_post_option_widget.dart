import 'package:flutter/material.dart';

import '../../../domain/entities/post/poll/poll_option.dart';

class PollOptionWidget extends StatelessWidget {
  final PollOption option;

  const PollOptionWidget({
    Key? key,
    required this.option,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[100],
      ),
      child: Stack(
        children: [
          // Progress bar background
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FractionallySizedBox(
              alignment: Alignment.centerRight,
              // widthFactor: option.percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.15),
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              textDirection: TextDirection.rtl, // RTL support
              children: [
                // Checkmark for selected option
                if (option.isVoted)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.blue[400],
                      size: 20,
                    ),
                  ),

                // Option text
                Expanded(
                  child: Text(
                    option.content,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),

                // Percentage
                Text(
                  '${option.count}%',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}