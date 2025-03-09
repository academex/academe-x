// Fixed ReactionsBox widget
import 'package:academe_x/features/home/presentation/widgets/lib/src/enums/box.dart';
import 'package:academe_x/features/home/presentation/widgets/lib/src/models/reaction.dart';
import 'package:academe_x/features/home/presentation/widgets/lib/src/widgets/reactions_box_item.dart';
import 'package:flutter/material.dart';

import '../common/position.dart';
import '../common/position_notifier.dart';

class ReactionsBox<T> extends StatefulWidget {
  const ReactionsBox({
    super.key,
    required this.offset,
    required this.itemSize,
    required this.reactions,
    required this.color,
    required this.elevation,
    required this.radius,
    required this.boxDuration,
    required this.boxPadding,
    required this.itemSpace,
    required this.itemScale,
    required this.itemScaleDuration,
    required this.onReactionSelected,
    required this.onClose,
    required this.animateBox,
    this.direction = ReactionsBoxAlignment.ltr,
  }) : assert(itemScale > 0.0 && itemScale < 1);

  final Offset offset;
  final Size itemSize;
  final List<Reaction<T>?> reactions;
  final Color color;
  final double elevation;
  final double radius;
  final Duration boxDuration;
  final EdgeInsetsGeometry boxPadding;
  final double itemSpace;
  final double itemScale;
  final Duration itemScaleDuration;
  final ValueChanged<Reaction<T>?> onReactionSelected;
  final VoidCallback onClose;
  final bool animateBox;
  final ReactionsBoxAlignment direction;

  @override
  State<ReactionsBox<T>> createState() => _ReactionsBoxState<T>();
}

class _ReactionsBoxState<T> extends State<ReactionsBox<T>>
    with SingleTickerProviderStateMixin {
  final PositionNotifier _positionNotifier = PositionNotifier();
  late final AnimationController _boxAnimationController;
  late final Animation _animation;

  double get _boxHeight => widget.itemSize.height + widget.boxPadding.vertical;
  double get _boxWidth =>
      (widget.itemSize.width * widget.reactions.length) +
          (widget.itemSpace * (widget.reactions.length - 1)) +
          widget.boxPadding.horizontal;

  // Modified positioning logic
  bool get _isWidthOverflow => widget.offset.dx + _boxWidth / 2 > MediaQuery.of(context).size.width;

  // Always show box above the button
  bool get _shouldShowAbove => true;

  void _checkIsOffsetOutsideBox(Offset offset) {
    final Rect boxRect = Rect.fromLTWH(0, 0, _boxWidth, _boxHeight);
    if (!boxRect.contains(offset)) {
      widget.onClose();
    }
  }

  @override
  void initState() {
    super.initState();
    _boxAnimationController = AnimationController(
      vsync: this,
      duration: widget.animateBox ? widget.boxDuration : Duration.zero,
    );

    final tween = IntTween(begin: 0, end: widget.reactions.length);
    _animation = tween.animate(_boxAnimationController);
    _boxAnimationController.forward();
  }

  @override
  void dispose() {
    _positionNotifier.dispose();
    _boxAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PositionData?>(
      valueListenable: _positionNotifier,
      builder: (context, fingerPosition, child) {
        final bool isBoxHovered = fingerPosition?.isBoxHovered ?? false;
        final double boxScale = 1 - (widget.itemScale / widget.reactions.length);

        // Center the box above the button
        final double start = widget.offset.dx - (_boxWidth) + (widget.itemSize.width);

        // Position box above the button
        final double top = widget.offset.dy - _boxHeight - 25;

        return Stack(
          children: [
            Positioned.fill(
              child: Listener(
                onPointerDown: (_) => widget.onClose(),
                child: Container(
                  key: const ValueKey('outside'),
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned(
              left: start,
              top: top,
              child: Listener(
                onPointerDown: (point) {
                  _positionNotifier.value = PositionData(
                    offset: point.localPosition,
                    isBoxHovered: true,
                  );
                },
                onPointerMove: (point) {
                  _positionNotifier.value = _positionNotifier.value.copyWith(
                    offset: point.localPosition,
                    isBoxHovered: true,
                  );
                },
                onPointerUp: (point) {
                  _positionNotifier.value = _positionNotifier.value.copyWith(
                    isBoxHovered: false,
                  );
                  _checkIsOffsetOutsideBox(point.localPosition);
                },
                child: Transform.scale(
                  scale: isBoxHovered ? boxScale : 1,
                  child: child!,
                ),
              ),
            ),
          ],
        );
      },
      child: Material(
        color: widget.color,
        elevation: widget.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        child: Container(
          width: _boxWidth,
          height: _boxHeight,
          padding: widget.boxPadding,
          child: Row(
            children: [
              for (int index = 0; index < widget.reactions.length; index++) ...[
                if (index > 0) SizedBox(width: widget.itemSpace),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return AnimatedScale(
                      duration: widget.boxDuration,
                      scale: _animation.value > index ? 1 : 0,
                      child: child,
                    );
                  },
                  child: ReactionsBoxItem<T>(
                    index: index,
                    fingerPositionNotifier: _positionNotifier,
                    reaction: widget.reactions[index]!,
                    size: widget.itemSize,
                    scale: widget.itemScale,
                    space: widget.itemSpace,
                    animationDuration: widget.itemScaleDuration,
                    onReactionSelected: (reaction) {
                      // Fix reaction selection logic
                      widget.onReactionSelected(widget.reactions[index]);
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

