import 'package:academe_x/features/home/presentation/controllers/cubits/comment/comments_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/comment/comments_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'comment_item.dart';

class ReplyList extends StatelessWidget {
  final int commentId;
  final int postId;
  final int userId;

  const ReplyList({
    required this.commentId,
    required this.postId,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        final replies = state.repliesMap[commentId] ?? [];

        if (replies.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.only(top: 8),
          child: Column(
            children: replies.map((reply) {
              return CommentItem(
                comment: reply,
                postId: postId,
                isReply: true,
                userId: userId,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}