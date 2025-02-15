import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../domain/entities/post/post_entity.dart';
import '../../controllers/cubits/post/reaction_cubit.dart';
import '../../controllers/states/post/reaction_state.dart';

class FbReactionBox extends StatelessWidget {
  final PostEntity post;
  final Function(String reactType) onReact;

  const FbReactionBox({
    Key? key,
    required this.post,
    required this.onReact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReactionCubit(
        animControlBox: AnimationController(
          vsync: Navigator.of(context),
          duration: const Duration(milliseconds: 500),
        ),
        animControlBtnLongPress: AnimationController(
          vsync: Navigator.of(context),
          duration: const Duration(milliseconds: 150),
        ),
        animControlEmojiWhenDrag: AnimationController(
          vsync: Navigator.of(context),
          duration: const Duration(milliseconds: 150),
        ),
        animControlEmojiWhenRelease: AnimationController(
          vsync: Navigator.of(context),
          duration: const Duration(milliseconds: 1000),
        ),
        onReact: onReact,
      )..initializeReaction(post.isReacted ?? false, post.reactionType),
      child: _ReactionBoxContent(post: post),
    );
  }
}

class _ReactionBoxContent extends StatelessWidget {
  final PostEntity post;

  const _ReactionBoxContent({required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReactionCubit, ReactionState>(
      builder: (context, state) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            if (state.isLongPress) ...[
              _buildReactionBox(context, state),
              _buildEmojiRow(context, state),
            ],
            GestureDetector(
              onHorizontalDragEnd: (details) => context.read<ReactionCubit>().onHorizontalDragEnd(details),
              onHorizontalDragUpdate: (details) => context.read<ReactionCubit>().onHorizontalDragUpdate(details),
              onTapDown: (details) => context.read<ReactionCubit>().onTapDown(details),
              onTapUp: (details) => context.read<ReactionCubit>().onTapUp(details),
              onTap: () => context.read<ReactionCubit>().onTap(),
              child: _buildLikeButton(context, state),
            ),
          ],
        );
      },
    );
  }
  Widget _buildReactionBox(BuildContext context, ReactionState state) {
    return Positioned(
      bottom: 45,
      left: -120,
      child: Opacity(
        opacity: state.fadeInBoxValue,
        child: Container(
          width: 206,
          height: 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, strokeAlign: 0.74),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(9.12),
                topLeft: Radius.circular(9.12),
                topRight: Radius.circular(9.12),
              )
          ),
        ),
      ),
    );
  }

  Widget _buildEmojiRow(BuildContext context, ReactionState state) {
    return AnimatedOpacity(
        opacity: state.isLongPress ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
    child: Positioned(
    bottom: 45,
    left: -120,
    child: SizedBox(
    width: 206,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    _buildEmojiItem(context, ReactionEmoji.celebrate, state),
    _buildEmojiItem(context, ReactionEmoji.insightful, state),
    _buildEmojiItem(context, ReactionEmoji.question, state),
    _buildEmojiItem(context, ReactionEmoji.funny, state),
    _buildEmojiItem(context, ReactionEmoji.heart, state),
    ],
    ),
    ),
    ));
  }


  Widget _buildEmojiItem(BuildContext context, ReactionEmoji emoji, ReactionState state) {
    return Transform.scale(
      scale: _getEmojiScale(emoji, state),
      child: SizedBox(
        height: state.currentEmojiFocus == emoji ? 70.0 : 40.0,
        width: 40,
        child: Column(
          children: [
            if (state.currentEmojiFocus == emoji)
              Container(
                width: 38.90,
                height: 22.54,
                padding: const EdgeInsets.symmetric(horizontal: 5.45, vertical: 3.27),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFF7D99),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.78),
                  ),
                ),
                child: Text(
                  _getEmojiText(emoji),
                  style: const TextStyle(fontSize: 8, color: Colors.white),
                ),
              ),
            SvgPicture.asset(_getEmojiIcon(emoji)),
          ],
        ),
      ),
    );
  }

  Widget _buildLikeButton(BuildContext context, ReactionState state) {
    return Container(
      width: 80,
      height: 42,
      decoration: ShapeDecoration(
        color: _getColorBtn(state),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SvgPicture.asset(
              _getImageEmojiBtn(state),
              width: 22,
              height: 22,
            ),
          ),
          Expanded(
            child: AppText(
              text: _getTextBtn(state),
              fontSize: 10,
              color: const Color(0xFF707281),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  double _getEmojiScale(ReactionEmoji emoji, ReactionState state) {
    if (state.isDragging) {
      if (state.currentEmojiFocus == emoji) {
        return state.emojiScales[emoji] ?? 1.8;
      } else if (state.previousEmojiFocus == emoji) {
        return state.emojiScales[emoji] ?? 0.8;
      } else {
        return state.isJustDragInside ? state.emojiScales[emoji] ?? 1.0 : 0.8;
      }
    } else if (state.isDraggingOutside) {
      return state.emojiScales[emoji] ?? 1.0;
    } else {
      return state.emojiScales[emoji] ?? 1.0;
    }
  }

  String _getEmojiText(ReactionEmoji emoji) {
    switch (emoji) {
      case ReactionEmoji.insightful:
        return 'مذهل';
      case ReactionEmoji.question:
        return 'سؤال';
      case ReactionEmoji.funny:
        return 'اضحكني';
      case ReactionEmoji.heart:
        return 'قلب';
      case ReactionEmoji.celebrate:
        return 'تصفيق';
      default:
        return '';
    }
  }

  String _getEmojiIcon(ReactionEmoji emoji) {
    switch (emoji) {
      case ReactionEmoji.insightful:
        return AppAssets.insightful;
      case ReactionEmoji.question:
        return AppAssets.question;
      case ReactionEmoji.funny:
        return AppAssets.funny;
      case ReactionEmoji.heart:
        return AppAssets.heart;
      case ReactionEmoji.celebrate:
        return AppAssets.celebrate;
      default:
        return '';
    }
  }

  Color _getColorBtn(ReactionState state) {
    if (!state.isDragging) {
      switch (state.currentEmojiChoose) {
        case ReactionEmoji.celebrate:
          return const Color(0xffFFDCD4);
        case ReactionEmoji.heart:
          return const Color(0xffFF5D5D);
        case ReactionEmoji.question:
          return const Color(0xff0EC2B4);
        case ReactionEmoji.insightful:
          return const Color(0xffFF7D99);
        case ReactionEmoji.funny:
          return const Color(0xff0EC2B4);
        case ReactionEmoji.nothing:
          return const Color(0xFFF7F7F8);
      }
    }
    return Colors.grey;
  }

  String _getImageEmojiBtn(ReactionState state) {
    if (!state.isDragging) {
      switch (state.currentEmojiChoose) {
        case ReactionEmoji.nothing:
          return AppAssets.defaultIcon;
        case ReactionEmoji.insightful:
          return AppAssets.insightful;
        case ReactionEmoji.question:
          return AppAssets.question;
        case ReactionEmoji.funny:
          return AppAssets.funny;
        case ReactionEmoji.heart:
          return AppAssets.heart;
        case ReactionEmoji.celebrate:
          return AppAssets.celebrate;
      }
    }
    return AppAssets.defaultIcon;
  }

  String _getTextBtn(ReactionState state) {
    if (state.isDragging) {
      return post.reactions!.count.toString();
    }
    switch (state.currentEmojiChoose) {
      case ReactionEmoji.nothing:
        return post.reactions!.count.toString();
      case ReactionEmoji.heart:
        return 'قلب';
      case ReactionEmoji.question:
        return 'سؤال';
      case ReactionEmoji.funny:
        return 'اضحكني';
      case ReactionEmoji.insightful:
        return 'مذهل';
      case ReactionEmoji.celebrate:
        return 'تصفيق';
    }
  }
}
