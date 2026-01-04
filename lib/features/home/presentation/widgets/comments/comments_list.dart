import 'package:academe_x/features/home/presentation/controllers/cubits/comment/comments_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/comment/comments_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/core.dart';
import 'comment_item.dart';

class CommentList extends StatelessWidget {
  final int postId;
  final int userId;

   const CommentList({
    required this.postId,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        // Loading state
        if (state.status == CommentsStatus.loading && state.comments.isEmpty) {
          return _buildLoadingState();
        }

        // Error state
        if (state.status == CommentsStatus.failure && state.comments.isEmpty) {
          return _buildErrorState(context, state.error);
        }

        // Empty state
        if (state.comments.isEmpty) {
          return _buildEmptyState();
        }

        // Success state
        return _buildCommentsList(context, state,userId);
      },
    );
  }

  Widget _buildCommentsList(BuildContext context, CommentsState state,int userId) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          final metrics = notification.metrics;
          if (metrics.pixels / metrics.maxScrollExtent > 0.8) {
            context.read<CommentsCubit>().loadComments(
                  postId: postId,
                  refresh: false,
                );
          }
        }
        return false;
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: state.comments.length + (state.hasReachedMax ? 0 : 1),
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          // Loading indicator at the end
          if (index == state.comments.length) {
            return _buildLoadingIndicator();
          }

          final comment = state.comments[index];
          return CommentItem(
            comment: comment,
            postId: postId,
            userId: userId
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, __) => _buildCommentShimmer(),
    );
  }

  Widget _buildCommentShimmer() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar shimmer
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        // Content shimmer
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 200,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, String? error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          AppText(
            text: error ?? 'فشل تحميل التعليقات',
            fontSize: 14,
            color: Colors.grey[600]!,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<CommentsCubit>().loadComments(
                    postId: postId,
                    refresh: true,
                  );
            },
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 48, color: Colors.grey[300]),
          const SizedBox(height: 16),
          AppText(
            text: 'لا توجد تعليقات بعد',
            fontSize: 14,
            color: Colors.grey[600]!,
          ),
          const SizedBox(height: 4),
          AppText(
            text: 'كن أول من يعلق!',
            fontSize: 12,
            color: Colors.grey[400]!,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
