import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';

/// "You've reached the end" indicator for posts list.
///
/// Displayed at the bottom of the posts list when all posts
/// have been loaded and there are no more to fetch.
class CommunityEndIndicator extends StatelessWidget {
  const CommunityEndIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.ph(),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: const Text(
            'You\'ve reached the end!',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
