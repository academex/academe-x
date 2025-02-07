import 'dart:async';
import 'package:academe_x/features/home/presentation/controllers/states/post/reaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';


class ReactionCubit extends Cubit<ReactionState> {
  Timer? _holdTimer;
  final Duration _durationLongPress = const Duration(milliseconds: 250);
  final AnimationController animControlBox;
  final AnimationController animControlBtnLongPress;
  final AnimationController animControlEmojiWhenDrag;
  final AnimationController animControlEmojiWhenRelease;
  final Function(String) onReact;

  ReactionCubit({
    required this.animControlBox,
    required this.animControlBtnLongPress,
    required this.animControlEmojiWhenDrag,
    required this.animControlEmojiWhenRelease,
    required this.onReact,
  }) : super(const ReactionState());

  void initializeReaction(bool isReacted, String? reactionType) {
    if (isReacted) {
      final currentEmoji = _getReactionEmojiFromString(reactionType ?? '');
      emit(state.copyWith(
        currentEmojiChoose: currentEmoji,
        currentEmojiFocus: currentEmoji,
        isLiked: currentEmoji != ReactionEmoji.nothing,
      ));
    }
  }

  void onTapDown(TapDownDetails details) {
    _holdTimer = Timer(_durationLongPress, showBox);
  }

  void showBox() {
    emit(state.copyWith(isLongPress: true));
    animControlBtnLongPress.forward();
    _setForwardValue();
    animControlBox.forward();
  }

  void onTapUp(TapUpDetails? details) {
    if (state.isLongPress && state.currentEmojiFocus != ReactionEmoji.nothing) {
      handleReaction(state.currentEmojiFocus);
    }

    Timer(const Duration(milliseconds: 500), () {
      emit(state.copyWith(isLongPress: false));
    });

    _holdTimer?.cancel();
    hideBox();
  }

  void hideBox() {
    emit(state.copyWith(
      isLongPress: false,
      isDragging: false,
      isDraggingOutside: false,
      isJustDragInside: true,
      currentEmojiFocus: ReactionEmoji.nothing,
      previousEmojiFocus: ReactionEmoji.nothing,
      emojiUserChoose: state.currentEmojiChoose,
    ));

    animControlBtnLongPress.reverse();
    animControlBox.reverse();
    animControlEmojiWhenRelease.reset();
    animControlEmojiWhenRelease.forward();
  }

  void onTap() {
    if (!state.isLongPress) {
      if (state.currentEmojiChoose == ReactionEmoji.nothing) {
        handleReaction(ReactionEmoji.heart);
      } else {
        handleReaction(state.currentEmojiChoose);
      }
    }
  }

  void handleReaction(ReactionEmoji reaction) {
    if (reaction == state.currentEmojiChoose) {
      onReact(reaction.name);
      emit(state.copyWith(
        currentEmojiChoose: ReactionEmoji.nothing,
        currentEmojiFocus: ReactionEmoji.nothing,
        isLiked: false,
      ));
    } else {
      onReact(reaction.name);
      emit(state.copyWith(
        currentEmojiChoose: reaction,
        emojiUserChoose: reaction,
        currentEmojiFocus: reaction,
        isLiked: true,
      ));
    }
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    if (state.currentEmojiFocus != ReactionEmoji.nothing) {
      if (state.currentEmojiFocus == state.currentEmojiChoose) {
        handleReaction(state.emojiUserChoose); // Remove reaction
      } else {
        handleReaction(state.currentEmojiFocus); // Change to new reaction
      }
    }

    emit(state.copyWith(
      isDragging: false,
      isDraggingOutside: false,
      isJustDragInside: true,
      previousEmojiFocus: ReactionEmoji.nothing,
      currentEmojiFocus: ReactionEmoji.nothing,
    ));

    hideBox();
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    if (!state.isLongPress) return;

    final boxStartY = 100;
    final boxEndY = 500;
    final boxWidth = 206.0;

    if (details.globalPosition.dy >= boxStartY && details.globalPosition.dy <= boxEndY) {
      final relativeX = details.localPosition.dx + 140;
      final emojiWidth = boxWidth / 5;
      final emojiIndex = (relativeX / emojiWidth).floor();

      ReactionEmoji targetEmoji = _getTargetEmoji(emojiIndex);

      if (targetEmoji != ReactionEmoji.nothing && state.currentEmojiFocus != targetEmoji) {
        handleDragBetweenEmoji(targetEmoji);
      }
    } else {
      emit(state.copyWith(
        emojiUserChoose: ReactionEmoji.nothing,
        previousEmojiFocus: ReactionEmoji.nothing,
        currentEmojiFocus: ReactionEmoji.nothing,
        isJustDragInside: true,
      ));
    }
  }

  ReactionEmoji _getTargetEmoji(int index) {
    switch (index) {
      case 0:
        return ReactionEmoji.heart;
      case 1:
        return ReactionEmoji.funny;
      case 2:
        return ReactionEmoji.question;
      case 3:
        return ReactionEmoji.insightful;
      case 4:
        return ReactionEmoji.celebrate;
      default:
        return ReactionEmoji.nothing;
    }
  }

  void handleDragBetweenEmoji(ReactionEmoji currentEmoji) {
    emit(state.copyWith(
      emojiUserChoose: currentEmoji,
      previousEmojiFocus: state.currentEmojiFocus,
      currentEmojiFocus: currentEmoji,
    ));
    animControlEmojiWhenDrag.reset();
    animControlEmojiWhenDrag.forward();
  }

  ReactionEmoji _getReactionEmojiFromString(String type) {
    switch (type.toUpperCase()) {
      case 'HEART':
        return ReactionEmoji.heart;
      case 'FUNNY':
        return ReactionEmoji.funny;
      case 'CELEBRATE':
        return ReactionEmoji.celebrate;
      case 'QUESTION':
        return ReactionEmoji.question;
      case 'INSIGHTFUL':
        return ReactionEmoji.insightful;
      default:
        return ReactionEmoji.nothing;
    }
  }

  void _setForwardValue() {
    // Animation setup for emojis...
    // Implement your animation tweens here
  }

  @override
  Future<void> close() {
    _holdTimer?.cancel();
    return super.close();
  }
}
