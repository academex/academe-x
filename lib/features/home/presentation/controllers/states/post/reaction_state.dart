import 'package:equatable/equatable.dart';

enum ReactionEmoji {
  nothing,
  heart,
  funny,
  question,
  insightful,
  celebrate,
}

class ReactionState extends Equatable {
  final bool isLongPress;
  final bool isDragging;
  final bool isDraggingOutside;
  final bool isJustDragInside;
  final bool isLiked;
  final ReactionEmoji currentEmojiChoose;
  final ReactionEmoji currentEmojiFocus;
  final ReactionEmoji previousEmojiFocus;
  final ReactionEmoji emojiUserChoose;
  final double fadeInBoxValue;
  final double zoomEmojiValue;
  final Map<ReactionEmoji, double> emojiScales;

  const ReactionState({
    this.isLongPress = false,
    this.isDragging = false,
    this.isDraggingOutside = false,
    this.isJustDragInside = true,
    this.isLiked = false,
    this.currentEmojiChoose = ReactionEmoji.nothing,
    this.currentEmojiFocus = ReactionEmoji.nothing,
    this.previousEmojiFocus = ReactionEmoji.nothing,
    this.emojiUserChoose = ReactionEmoji.nothing,
    this.fadeInBoxValue = 0.0,
    this.zoomEmojiValue = 1.0,
    this.emojiScales = const {},
  });

  ReactionState copyWith({
    bool? isLongPress,
    bool? isDragging,
    bool? isDraggingOutside,
    bool? isJustDragInside,
    bool? isLiked,
    ReactionEmoji? currentEmojiChoose,
    ReactionEmoji? currentEmojiFocus,
    ReactionEmoji? previousEmojiFocus,
    ReactionEmoji? emojiUserChoose,
    double? fadeInBoxValue,
    double? zoomEmojiValue,
    Map<ReactionEmoji, double>? emojiScales,
  }) {
    return ReactionState(
      isLongPress: isLongPress ?? this.isLongPress,
      isDragging: isDragging ?? this.isDragging,
      isDraggingOutside: isDraggingOutside ?? this.isDraggingOutside,
      isJustDragInside: isJustDragInside ?? this.isJustDragInside,
      isLiked: isLiked ?? this.isLiked,
      currentEmojiChoose: currentEmojiChoose ?? this.currentEmojiChoose,
      currentEmojiFocus: currentEmojiFocus ?? this.currentEmojiFocus,
      previousEmojiFocus: previousEmojiFocus ?? this.previousEmojiFocus,
      emojiUserChoose: emojiUserChoose ?? this.emojiUserChoose,
      fadeInBoxValue: fadeInBoxValue ?? this.fadeInBoxValue,
      zoomEmojiValue: zoomEmojiValue ?? this.zoomEmojiValue,
      emojiScales: emojiScales ?? this.emojiScales,
    );
  }

  @override
  List<Object?> get props => [
    isLongPress,
    isDragging,
    isDraggingOutside,
    isJustDragInside,
    isLiked,
    currentEmojiChoose,
    currentEmojiFocus,
    previousEmojiFocus,
    emojiUserChoose,
    fadeInBoxValue,
    zoomEmojiValue,
    emojiScales,
  ];
}
