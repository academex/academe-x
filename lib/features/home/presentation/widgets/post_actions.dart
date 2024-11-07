import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/home/post_entity.dart';
import '../../domain/entities/home/reaction_type.dart';
import '../controllers/cubits/home/action_post_cubit.dart';
import '../controllers/states/action_post_states.dart';
import '../screens/community_page.dart';
import 'action_button.dart';
import 'comments_list.dart';

class PostActions extends StatelessWidget {
  final PostEntity post;

  const PostActions({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActionPostCubit(),
      child: Column(
        children: [
          _buildReactionsBar(),
          SizedBox(
            width: 326.w,
            height: 50.h,
            child: Row(
              children: [
                _buildReactionsButton(),
                10.pw(),
                _buildCommentButton(context),
                10.pw(),
                _buildShareButton(context),
                const Spacer(),
                _buildSaveButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionsBar() {
    return BlocBuilder<ActionPostCubit, ActionPostState>(
      builder: (context, state) {
        // AppLogger.success(state.selectedReaction!.assetPath);
        if (post.likesCount == 0 && post.commentsCount == 0) return const SizedBox();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              // Reactions count
              Row(
                children: [
                  if (state.selectedReaction != null)
                    Image.asset(
                      state.selectedReaction!.assetPath,
                      width: 18.w,
                      height: 18.h,
                    ),
                  if (post.likesCount > 0)
                    Text(
                      post.likesCount.toString(),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.sp,
                      ),
                    ),
                ],
              ),
              const Spacer(),
              // Comments count
              // if (post.commentsCount > 0)
              //   Text(
              //     '${post.commentsCount} تعليق',
              //     style: TextStyle(
              //       color: Colors.grey[600],
              //       fontSize: 14.sp,
              //     ),
              //   ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReactionsButton() {
    return BlocBuilder<ActionPostCubit, ActionPostState>(
      builder: (context, state) {
        return GestureDetector(
          onTapDown: (details) => _showReactionPicker(context, details),
          child: ActionButton(
            iconPath: state.selectedReaction?.assetPath ??
                'assets/icons/favourite.png',
            count: post.likesCount.toString(),
            onTap: () {
              context.read<ActionPostCubit>().toggleDefaultReaction();
            },
          ),
        );
      },
    );
  }

  void _showReactionPicker(BuildContext context, TapDownDetails details) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset position = button.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy - 60.h,
        position.dx + button.size.width,
        position.dy,
      ),
      items: [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: _ReactionPickerWidget(
            onReactionSelected: (reaction) {
              context.read<ActionPostCubit>().selectReaction(reaction);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCommentButton(BuildContext context) {
    return ActionButton(
      iconPath: 'assets/icons/comment.png',
      count: post.commentsCount.toString(),
      onTap: () => CommentsList(postId: post.userId, context: context),
    );
  }
//
//
  Widget _buildShareButton(BuildContext context) {
    return ActionButton(
      iconPath: 'assets/icons/share.png',
      count: post.sharesCount.toString(),
      onTap: () => showShareOptions(context),
    );
  }

  Widget _buildSaveButton() {
    return BlocBuilder<ActionPostCubit, ActionPostState>(
      builder: (context, state) {
        return IconButton(
          icon: Image.asset(
            state.isSaved
                ? 'assets/icons/bookMark_selected.png'
                : 'assets/icons/Bookmark.png',
            height: 17.h,
            width: 19.w,
          ),
          padding: EdgeInsets.zero,
          onPressed: () {
            context.read<ActionPostCubit>().performSaveAction(!state.isSaved);
          },
        );
      },
    );
  }
}


class _ReactionPickerWidget extends StatelessWidget {
  final Function(ReactionType) onReactionSelected;

  const _ReactionPickerWidget({
    required this.onReactionSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: ReactionType.values.map((type) {
          return InkWell(
            onTap: () => onReactionSelected(type),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Image.asset(
                type.assetPath,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}


class SelectedReactionButton extends StatelessWidget {
  final ReactionType reaction;
  final VoidCallback onTap;

  const SelectedReactionButton({
    required this.reaction,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: _getReactionColor(reaction),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              reaction.assetPath,
              width: 16.w,
              height: 16.h,
            ),
            4.pw(),
            Text(
              _getReactionText(reaction),
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getReactionColor(ReactionType type) {
    switch (type) {
      case ReactionType.heart:
        return const Color(0xFFFF597B); // Pink
      case ReactionType.celebrate:
        return const Color(0xFF37B4AA); // Teal
      case ReactionType.question:
        return const Color(0xFF6C5CE7); // Purple
      case ReactionType.insightful:
        return const Color(0xFFFF8F3C); // Orange
      case ReactionType.like:
        return const Color(0xFF2196F3); // Blue
    }
  }

  String _getReactionText(ReactionType type) {
    switch (type) {
      case ReactionType.heart:
        return 'قلب';
      case ReactionType.celebrate:
        return 'ابتسامة';
      case ReactionType.question:
        return 'سؤال';
      case ReactionType.insightful:
        return 'قهوة';
      case ReactionType.like:
        return 'إعجاب';
    }
  }
}