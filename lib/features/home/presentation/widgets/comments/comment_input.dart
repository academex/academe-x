import 'package:academe_x/features/home/presentation/controllers/cubits/comment/comments_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/comment/comments_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/core.dart';

class CommentInput extends StatefulWidget {
  final int postId;

  const CommentInput({
    required this.postId,
    Key? key,
  }) : super(key: key);

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsCubit, CommentsState>(
      listener: (context, state) {
        // Handle action status
        if (state.actionStatus == CommentActionStatus.success) {
          _controller.clear();
          _focusNode.unfocus();
        }

        // Update text when entering edit mode
        if (state.isEditMode && state.editingComment != null) {
          _controller.text = state.editingComment!.content ?? '';
          _focusNode.requestFocus();
        }

        // Update text when entering reply mode
        if (state.isReplyMode && state.replyingTo != null) {
          _controller.text = '@${state.replyingTo!.user?.username} ';
          _focusNode.requestFocus();
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.grey[200]!,
                width: 1,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Mode indicator
              if (state.isReplyMode || state.isEditMode)
                _buildModeIndicator(context, state),
              
              // Input field
              _buildInputField(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModeIndicator(BuildContext context, CommentsState state) {
    final isReply = state.isReplyMode;
    final targetUser = isReply
        ? state.replyingTo?.user
        : state.editingComment?.user;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            isReply ? Icons.reply : Icons.edit_outlined,
            size: 16,
            color: const Color(0xFF0077FF),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: AppText(
              text: isReply
                  ? 'الرد على @${targetUser?.username}'
                  : 'تعديل التعليق',
              fontSize: 12,
              color: const Color(0xFF0077FF),
            ),
          ),
          IconButton(
            onPressed: () {
              if (isReply) {
                context.read<CommentsCubit>().cancelReply();
              } else {
                context.read<CommentsCubit>().cancelEdit();
              }
              _controller.clear();
            },
            icon: const Icon(Icons.close, size: 18),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(BuildContext context, CommentsState state) {
    final cubit = context.read<CommentsCubit>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Text field
        Expanded(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 100),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F8),
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              maxLines: null,
              textInputAction: TextInputAction.newline,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: state.isReplyMode
                    ? 'اكتب ردك...'
                    : state.isEditMode
                        ? 'تعديل التعليق...'
                        : 'اكتب تعليقك...',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Send button
        Material(
          color: const Color(0xFF0077FF),
          borderRadius: BorderRadius.circular(24),
          child: InkWell(
            onTap: () => _handleSend(context, state),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              child: state.actionStatus == CommentActionStatus.loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleSend(BuildContext context, CommentsState state) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final cubit = context.read<CommentsCubit>();

    if (state.isReplyMode && state.replyingTo != null) {
      // Send reply
      final cleanContent = text.replaceFirst(
        '@${state.replyingTo!.user?.username}',
        '',
      ).trim();
      
      cubit.createReply(
        commentId: state.replyingTo!.id!,
        content: cleanContent,
        context: context,
      );
    } else if (state.isEditMode && state.editingComment != null) {
      // Update comment
      cubit.updateComment(
        postId: widget.postId,
        commentId: state.editingComment!.id!,
        content: text,
      );
    } else {
      // Create new comment
      cubit.createComment(
        postId: widget.postId,
        content: text,
        context: context,
      );
    }
  }
}