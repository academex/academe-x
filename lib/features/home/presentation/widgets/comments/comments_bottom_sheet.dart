import 'package:academe_x/features/home/presentation/controllers/cubits/comment/comments_cubit.dart';
import 'package:academe_x/features/home/presentation/widgets/comments/comments_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/core.dart';
import 'comment_input.dart';

class CommentsBottomSheet extends StatelessWidget {
  final int postId;
  final int userId;

  const CommentsBottomSheet({
    required this.postId,
    required this.userId,
    Key? key,
  }) : super(key: key);

  static Future<void> show(BuildContext context, int postId,int userId) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (_) => CommentsCubit(postUseCase: getIt())
          ..loadComments(postId: postId, refresh: true),
        child: CommentsBottomSheet(postId: postId,userId:userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          _buildHeader(),
          const Divider(height: 1),

          // Comments list
          Expanded(
            child: CommentList(postId: postId, userId: userId),
          ),

          // Input field
          CommentInput(postId: postId),
          20.ph(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),

          // Title
          AppText(
            text: 'التعليقات',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
