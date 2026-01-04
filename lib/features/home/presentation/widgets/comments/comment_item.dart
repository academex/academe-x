import 'package:academe_x/features/home/domain/entities/post/comment_entity.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/comment/comments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../../core/core.dart';
import 'reply_list.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  final int postId;
  final bool isReply;
  final int userId;

  const CommentItem({
    required this.comment,
    required this.postId,
    this.isReply = false,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CommentsCubit>();
    final isOwner = comment.user?.id == userId;

    return Slidable(
      enabled: isOwner && !isReply,
      endActionPane: isOwner
          ? ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) => _showDeleteDialog(context),
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete_outline,
                  label: 'حذف',
                  borderRadius: BorderRadius.circular(12),
                ),
                SlidableAction(
                  onPressed: (_) {
                    cubit.startEdit(comment);
                  },
                  backgroundColor: const Color(0xFF0077FF),
                  foregroundColor: Colors.white,
                  icon: Icons.edit_outlined,
                  label: 'تعديل',
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            )
          : null,
      child: _buildCommentContent(context),
    );
  }

  Widget _buildCommentContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: isReply ? 56 : 16,
        left: 16,
        top: 12,
        bottom: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          _buildAvatar(),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 4),
                _buildContent(),
                const SizedBox(height: 8),
                _buildActions(context),

                // Replies
                if (!isReply && (comment.replyCount ?? 0) > 0)
                  _buildRepliesSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.grey[200],
      backgroundImage: comment.user?.photoUrl != null
          ? NetworkImage(comment.user!.photoUrl!)
          : null,
      child: comment.user?.photoUrl == null
          ? Text(
              comment.user?.firstName?[0]?.toUpperCase() ?? '?',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF0077FF),
              ),
            )
          : null,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // Name
        Expanded(
          child: AppText(
            text: '${comment.user?.firstName} ${comment.user?.lastName}',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Time
        AppText(
          text: getTimeAgo(
            comment.createdAt ?? DateTime.now(),
          ),
          fontSize: 12,
          color: Colors.grey[500]!,
        ),

        // Sending indicator
        if (comment.isSending ?? false) ...[
          const SizedBox(width: 8),
          SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.grey[400],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: AppText(
        text: comment.content ?? '',
        fontSize: 14,
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        // Like button
        _buildLikeButton(context),
        const SizedBox(width: 16),

        // Reply button (only for top-level comments)
        if (!isReply) _buildReplyButton(context),
      ],
    );
  }

  Widget _buildLikeButton(BuildContext context) {
    final isLiked = comment.isLiked ?? false;
    final likesCount = comment.likes ?? 0;

    return InkWell(
      onTap: () {
        context.read<CommentsCubit>().toggleCommentLike(
              postId: postId,
              commentId: comment.id!,
            );
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              size: 16,
              color: isLiked ? const Color(0xFFFF5D5D) : Colors.grey[600],
            ),
            if (likesCount > 0) ...[
              const SizedBox(width: 4),
              AppText(
                text: likesCount.toString(),
                fontSize: 12,
                color: isLiked ? const Color(0xFFFF5D5D) : Colors.grey[600]!,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildReplyButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CommentsCubit>().startReply(comment);
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.reply,
              size: 16,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 4),
            AppText(
              text: 'رد',
              fontSize: 12,
              color: Colors.grey[600]!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRepliesSection(BuildContext context) {
    final repliesCount = comment.replyCount ?? 0;
    final cubit = context.read<CommentsCubit>();
    final hasReplies = cubit.state.repliesMap.containsKey(comment.id);
    final isLoading = cubit.state.loadingRepliesMap[comment.id] ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),

        // Toggle button
        InkWell(
          onTap: () {
            cubit.toggleReplies(comment.id!);
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.grey[400],
                    ),
                  )
                else
                  Icon(
                    hasReplies
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 16,
                    color: const Color(0xFF0077FF),
                  ),
                const SizedBox(width: 4),
                AppText(
                  text: hasReplies
                      ? 'إخفاء الردود'
                      : 'عرض $repliesCount ${repliesCount == 1 ? 'رد' : 'ردود'}',
                  fontSize: 12,
                  color: const Color(0xFF0077FF),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),

        // Replies list
        if (hasReplies && !isLoading)
          ReplyList(
            commentId: comment.id!,
            postId: postId,
            userId:userId
          ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف التعليق'),
        content: const Text('هل أنت متأكد من حذف هذا التعليق؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<CommentsCubit>().deleteComment(
                    postId: postId,
                    commentId: comment.id!,
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFE4A49),
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return 'منذ${difference.inDays} ${difference.inDays == 1 ? 'ي' : 'أي'}';
    } else if (difference.inHours > 0) {
      return 'منذ ${difference.inHours}  ${difference.inHours == 1 ? 'س' : 'س'}';
    } else if (difference.inMinutes > 0) {
      return 'منذ${difference.inMinutes} ${difference.inMinutes == 1 ? 'د' : 'د'}';
    } else {
      return 'الان';
    }
  }
}
