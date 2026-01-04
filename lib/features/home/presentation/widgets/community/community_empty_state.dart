import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';

/// Empty or error state display for community posts.
///
/// Shows appropriate message and retry button when there's an error
/// or when no posts are available.
class CommunityEmptyState extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  final bool isError;

  const CommunityEmptyState({
    super.key,
    this.message,
    this.onRetry,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message ??
                (isError ? 'Failed to fetch posts' : 'No posts found'),
          ),
          if (isError && onRetry != null) ...[
            16.ph(),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
