import 'dart:async';

import 'package:academe_x/core/constants/app_assets.dart';
import 'package:academe_x/core/constants/cache_keys.dart';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/auth/auth.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../controllers/states/post/reaction_state.dart';

/// Professional Emoji Configuration Class
class EmojiConfig {
  final ReactionEmoji type;
  final String icon;
  final String label;
  final Color color;

  const EmojiConfig({
    required this.type,
    required this.icon,
    required this.label,
    required this.color,
  });
}

/// Emoji Registry - Single source of truth for emoji order and properties
class EmojiRegistry {
  // Define emoji order from LEFT to RIGHT (visual order)
  static const List<EmojiConfig> emojis = [
    EmojiConfig(
      type: ReactionEmoji.celebrate,
      icon: AppAssets.celebrate,
      label: 'تصفيق',
      color: Color(0xffFFDCD4),
    ),
    EmojiConfig(
      type: ReactionEmoji.insightful,
      icon: AppAssets.insightful,
      label: 'مذهل',
      color: Color(0xffFF7D99),
    ),
    EmojiConfig(
      type: ReactionEmoji.question,
      icon: AppAssets.question,
      label: 'سؤال',
      color: Color(0xff0EC2B4),
    ),
    EmojiConfig(
      type: ReactionEmoji.funny,
      icon: AppAssets.funny,
      label: 'اضحكني',
      color: Color(0xff0EC2B4),
    ),
    EmojiConfig(
      type: ReactionEmoji.heart,
      icon: AppAssets.heart,
      label: 'قلب',
      color: Color(0xffFF5D5D),
    ),
  ];

  /// Get emoji config by type
  static EmojiConfig? getByType(ReactionEmoji type) {
    try {
      return emojis.firstWhere((e) => e.type == type);
    } catch (e) {
      return null;
    }
  }

  /// Get emoji at specific visual index (accounting for RTL)
  static ReactionEmoji getEmojiAtIndex(int index, {required bool isRTL}) {
    if (index < 0 || index >= emojis.length) {
      return ReactionEmoji.nothing;
    }

    // In RTL, reverse the index
    final actualIndex = isRTL ? (emojis.length - 1 - index) : index;
    return emojis[actualIndex].type;
  }

  /// Get visual index of emoji (accounting for RTL)
  static int getIndexOfEmoji(ReactionEmoji type, {required bool isRTL}) {
    final index = emojis.indexWhere((e) => e.type == type);
    if (index == -1) return -1;

    // In RTL, reverse the index
    return isRTL ? (emojis.length - 1 - index) : index;
  }
}

class FbReactionBox extends StatefulWidget {
  final PostEntity post;
  final Function(String reactType) onReact;
  const FbReactionBox({
    Key? key,
    required this.post,
    required this.onReact,
  }) : super(key: key);

  @override
  createState() => FbReactionBoxState();
}

class FbReactionBoxState extends State<FbReactionBox>
    with TickerProviderStateMixin {
  // Configuration constants
  static const double _boxWidth = 206.0;
  static const double _boxHeightNormal = 50.0;
  static const double _boxHeightExpanded =
      90.0; // Increased for proper containment
  static const double _emojiSize = 40.0;
  static const double _emojiSizeExpanded = 70.0;
  static const double _boxBottomOffset = 55.0;
  static const double _boxLeftOffset = -140.0;

  // Animation durations
  final int _durationAnimationBox = 500;
  final int _durationAnimationBtnLongPress = 150;
  final int _durationAnimationBtnShortPress = 500;
  final int _durationAnimationEmojiWhenDrag = 150;
  final int _durationAnimationEmojiWhenRelease = 1000;
  final _durationLongPress = Duration(milliseconds: 250);

  // Animation Controllers
  late AnimationController _animControlBtnLongPress;
  late AnimationController _animControlBox;
  late AnimationController _animControlBtnShortPress;
  late AnimationController _animControlEmojiWhenDrag;
  late AnimationController _animControlEmojiWhenDragInside;
  late AnimationController _animControlEmojiWhenDragOutside;
  late AnimationController _animControlBoxWhenDragOutside;
  late AnimationController _animControlEmojiWhenRelease;

  // Animations
  late Animation _zoomEmojiLikeInBtn;
  late Animation _tiltEmojiLikeInBtn;
  late Animation _zoomTextLikeInBtn;
  late Animation _fadeInBox;
  late Animation _moveRightGroupEmoji;

  // Per-emoji animations (stored in maps for cleaner code)
  final Map<ReactionEmoji, Animation<double>> _pushUpAnimations = {};
  final Map<ReactionEmoji, Animation<double>> _zoomAnimations = {};

  // Drag animations
  late Animation _zoomEmojiChosen;
  late Animation _zoomEmojiNotChosen;
  late Animation _zoomEmojiWhenDragOutside;
  late Animation _zoomEmojiWhenDragInside;
  late Animation _zoomBoxWhenDragOutside;
  late Animation _zoomBoxEmoji;

  // Release animations
  late Animation _zoomEmojiWhenRelease;
  late Animation _moveUpEmojiWhenRelease;

  // State variables
  ReactionEmoji _emojiUserChoose = ReactionEmoji.nothing;
  ReactionEmoji _currentEmojiChoose = ReactionEmoji.nothing;
  ReactionEmoji _currentEmojiFocus = ReactionEmoji.nothing;
  ReactionEmoji _previousEmojiFocus = ReactionEmoji.nothing;

  bool _isLongPress = false;
  bool _isLiked = false;
  bool _isDragging = false;
  bool _isDraggingOutside = false;
  bool _isJustDragInside = true;
  Timer? _holdTimer;

  // RTL Detection
  bool get _isRTL => Directionality.of(context) == TextDirection.rtl;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeUserReaction();
  }

  @override
  void didUpdateWidget(FbReactionBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.post.reactionType != widget.post.reactionType ||
        oldWidget.post.isReacted != widget.post.isReacted) {
      _initializeUserReaction();
    }
  }

  void _initializeUserReaction() {
    if (widget.post.isReacted == true) {
      final currentUserReaction = widget.post.reactionType;
      if (currentUserReaction != null && currentUserReaction.isNotEmpty) {
        setState(() {
          _currentEmojiChoose =
              _getReactionEmojiFromString(currentUserReaction);
          _emojiUserChoose = _currentEmojiChoose;
          _isLiked = true;
        });
      } else {
        _resetReaction();
      }
    } else {
      _resetReaction();
    }
  }

  void _resetReaction() {
    setState(() {
      _currentEmojiChoose = ReactionEmoji.nothing;
      _emojiUserChoose = ReactionEmoji.nothing;
      _isLiked = false;
    });
  }

  ReactionEmoji _getReactionEmojiFromString(String type) {
    final upperType = type.toUpperCase();
    return EmojiRegistry.emojis
        .firstWhere(
          (e) => e.type.name.toUpperCase() == upperType,
          orElse: () => EmojiRegistry.emojis[0],
        )
        .type;
  }

  void _hideBox() {
    if (!mounted) return;

    setState(() {
      _isLongPress = false;
      _isDragging = false;
      _isDraggingOutside = false;
      _isJustDragInside = true;
      _currentEmojiFocus = ReactionEmoji.nothing;
      _previousEmojiFocus = ReactionEmoji.nothing;
    });

    _animControlBtnLongPress.reverse();
    _animControlBox.reverse();
    _animControlEmojiWhenRelease.reset();
    _animControlEmojiWhenRelease.forward();
  }

  void _handleReaction(ReactionEmoji reaction) async {
    if (reaction == _currentEmojiChoose) {
      widget.onReact(reaction.name);
      _resetReaction();
    } else {
      widget.onReact(reaction.name);

      setState(() {
        _currentEmojiChoose = reaction;
        _emojiUserChoose = reaction;
        _currentEmojiFocus = reaction;
        _isLiked = true;
      });

      _hideBox();
    }
  }

  void _initAnimationBtnLike() {
    _animControlBtnLongPress = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _durationAnimationBtnLongPress),
    );
    _zoomEmojiLikeInBtn =
        Tween(begin: 1.0, end: 0.85).animate(_animControlBtnLongPress);
    _tiltEmojiLikeInBtn =
        Tween(begin: 0.0, end: 0.2).animate(_animControlBtnLongPress);
    _zoomTextLikeInBtn =
        Tween(begin: 1.0, end: 0.85).animate(_animControlBtnLongPress);

    _zoomEmojiLikeInBtn.addListener(() {
      if (mounted) setState(() {});
    });
    _tiltEmojiLikeInBtn.addListener(() {
      if (mounted) setState(() {});
    });
    _zoomTextLikeInBtn.addListener(() {
      if (mounted) setState(() {});
    });

    _animControlBtnShortPress = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _durationAnimationBtnShortPress),
    );
  }

  void _initAnimationBoxAndEmojis() {
    _animControlBox = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _durationAnimationBox),
    );

    _moveRightGroupEmoji = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.0, 1.0)),
    );
    _moveRightGroupEmoji.addListener(() {
      if (mounted) setState(() {});
    });

    _fadeInBox = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.7, 1.0)),
    );
    _fadeInBox.addListener(() {
      if (mounted) setState(() {});
    });

    // Create animations for each emoji dynamically
    final intervals = [
      [0.0, 0.5],
      [0.1, 0.6],
      [0.2, 0.7],
      [0.3, 0.8],
      [0.4, 0.9],
    ];

    for (int i = 0; i < EmojiRegistry.emojis.length; i++) {
      final emoji = EmojiRegistry.emojis[i];
      final interval = intervals[i];

      _pushUpAnimations[emoji.type] = Tween(begin: 30.0, end: 35.0).animate(
        CurvedAnimation(
          parent: _animControlBox,
          curve: Interval(interval[0], interval[1]),
        ),
      );

      _zoomAnimations[emoji.type] = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animControlBox,
          curve: Interval(interval[0], interval[1]),
        ),
      );

      _pushUpAnimations[emoji.type]!.addListener(() {
        if (mounted) setState(() {});
      });
      _zoomAnimations[emoji.type]!.addListener(() {
        if (mounted) setState(() {});
      });
    }
  }

  void _initAnimationEmojiWhenDrag() {
    _animControlEmojiWhenDrag = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _durationAnimationEmojiWhenDrag),
    );

    _zoomEmojiChosen =
        Tween(begin: 1.0, end: 1.8).animate(_animControlEmojiWhenDrag);
    _zoomEmojiNotChosen =
        Tween(begin: 1.0, end: 0.8).animate(_animControlEmojiWhenDrag);
    _zoomBoxEmoji =
        Tween(begin: 50.0, end: 40.0).animate(_animControlEmojiWhenDrag);

    _zoomEmojiChosen.addListener(() {
      if (mounted) setState(() {});
    });
    _zoomEmojiNotChosen.addListener(() {
      if (mounted) setState(() {});
    });
    _zoomBoxEmoji.addListener(() {
      if (mounted) setState(() {});
    });
  }

  void _initAnimationEmojiWhenDragOutside() {
    _animControlEmojiWhenDragOutside = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _durationAnimationEmojiWhenDrag),
    );
    _zoomEmojiWhenDragOutside =
        Tween(begin: 0.8, end: 1.0).animate(_animControlEmojiWhenDragOutside);
    _zoomEmojiWhenDragOutside.addListener(() {
      if (mounted) setState(() {});
    });
  }

  void _initAnimationBoxWhenDragOutside() {
    _animControlBoxWhenDragOutside = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _durationAnimationEmojiWhenDrag),
    );
    _zoomBoxWhenDragOutside =
        Tween(begin: 40.0, end: 50.0).animate(_animControlBoxWhenDragOutside);
    _zoomBoxWhenDragOutside.addListener(() {
      if (mounted) setState(() {});
    });
  }

  void _initAnimationEmojiWhenDragInside() {
    _animControlEmojiWhenDragInside = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _durationAnimationEmojiWhenDrag),
    );
    _zoomEmojiWhenDragInside =
        Tween(begin: 1.0, end: 0.8).animate(_animControlEmojiWhenDragInside);
    _zoomEmojiWhenDragInside.addListener(() {
      if (mounted) setState(() {});
    });
    _animControlEmojiWhenDragInside.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isJustDragInside = false;
      }
    });
  }

  void _initAnimationEmojiWhenRelease() {
    _animControlEmojiWhenRelease = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _durationAnimationEmojiWhenRelease),
    );

    _zoomEmojiWhenRelease = Tween(begin: 1.8, end: 0.0).animate(
      CurvedAnimation(
          parent: _animControlEmojiWhenRelease, curve: Curves.decelerate),
    );

    _moveUpEmojiWhenRelease = Tween(begin: 180.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _animControlEmojiWhenRelease, curve: Curves.decelerate),
    );

    _zoomEmojiWhenRelease.addListener(() {
      if (mounted) setState(() {});
    });
    _moveUpEmojiWhenRelease.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    _animControlBtnLongPress.dispose();
    _animControlBox.dispose();
    _animControlBtnShortPress.dispose();
    _animControlEmojiWhenDrag.dispose();
    _animControlEmojiWhenDragInside.dispose();
    _animControlEmojiWhenDragOutside.dispose();
    _animControlBoxWhenDragOutside.dispose();
    _animControlEmojiWhenRelease.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _initAnimationBtnLike();
    _initAnimationBoxAndEmojis();
    _initAnimationEmojiWhenDrag();
    _initAnimationEmojiWhenDragOutside();
    _initAnimationBoxWhenDragOutside();
    _initAnimationEmojiWhenDragInside();
    _initAnimationEmojiWhenRelease();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildReactionBox(),
          _buildEmojiRow(),
          _buildLikeButton(),
        ],
      ),
    );
  }

  Widget _buildEmojiItem(
      EmojiConfig config, double pushUp, double height, double scale) {
    final bool isSelected = _currentEmojiFocus == config.type;

    return Container(
      width: _emojiSize,
      height: _isDragging ? _emojiSizeExpanded : _emojiSize,
      alignment: Alignment.center,
      child: Transform.scale(
        scale: scale,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected)
              Container(
                constraints: BoxConstraints(maxWidth: 50),
                padding: const EdgeInsets.symmetric(
                    horizontal: 5.45, vertical: 3.27),
                margin: const EdgeInsets.only(bottom: 4),
                decoration: ShapeDecoration(
                  color: Color(0xFFFF7D99),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.78),
                  ),
                ),
                child: Text(
                  config.label,
                  style: const TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            SizedBox(
              width: 28,
              height: 28,
              child: SvgPicture.asset(
                config.icon,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReactionBox() {
    return Positioned(
      bottom: _boxBottomOffset,
      left: _boxLeftOffset,
      child: Opacity(
        opacity: _fadeInBox.value,
        child: Container(
          width: _boxWidth,
          height: _isDragging ? _boxHeightExpanded : _boxHeightNormal,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(9.12),
              topLeft: Radius.circular(9.12),
              topRight: Radius.circular(9.12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmojiRow() {
    return Positioned(
      bottom: _boxBottomOffset,
      left: _boxLeftOffset,
      child: Container(
        width: _boxWidth,
        height: _isDragging ? _boxHeightExpanded : _boxHeightNormal,
        alignment: Alignment.center,
        // padding: EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: EmojiRegistry.emojis.map((config) {
            return _buildEmojiItem(
              config,
              _pushUpAnimations[config.type]?.value ?? 30.0,
              _currentEmojiFocus == config.type
                  ? _emojiSizeExpanded
                  : _emojiSize,
              _getEmojiScale(config.type),
            );
          }).toList(),
        ),
      ),
    );
  }

  double _getEmojiScale(ReactionEmoji emoji) {
    if (_isDragging) {
      if (_currentEmojiFocus == emoji) {
        return _zoomEmojiChosen.value;
      } else if (_previousEmojiFocus == emoji) {
        return _zoomEmojiNotChosen.value;
      } else {
        return _isJustDragInside ? _zoomEmojiWhenDragInside.value : 0.8;
      }
    } else if (_isDraggingOutside) {
      return _zoomEmojiWhenDragOutside.value;
    } else {
      return _zoomAnimations[emoji]?.value ?? 1.0;
    }
  }

  Widget _buildLikeButton() {
    final config = _currentEmojiChoose != ReactionEmoji.nothing
        ? EmojiRegistry.getByType(_currentEmojiChoose)
        : null;

    return GestureDetector(
      onHorizontalDragEnd: _onHorizontalDragEndBoxEmoji,
      onHorizontalDragUpdate: _onHorizontalDragUpdateBoxEmoji,
      onTapDown: _onTapDownBtn,
      onTapUp: _onTapUpBtn,
      onTap: _onTapBtn,
      child: Container(
        width: 80,
        height: 42,
        decoration: ShapeDecoration(
          color:
              _isDragging ? Colors.grey : (config?.color ?? Color(0xFFF7F7F8)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              _isDragging
                  ? AppAssets.defaultIcon
                  : (config?.icon ?? AppAssets.defaultIcon),
              width: 22,
              height: 22,
            ),
            AppText(
              text: _isDragging
                  ? (widget.post.reactions?.count.toString() ?? '0')
                  : (config?.label ??
                      widget.post.reactions?.count.toString() ??
                      '0'),
              fontSize: 10,
              color: Color(0xFF707281),
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }

  void _onHorizontalDragEndBoxEmoji(DragEndDetails dragEndDetail) {
    if (_currentEmojiFocus != ReactionEmoji.nothing) {
      _handleReaction(_currentEmojiFocus);
    }

    setState(() {
      _isDragging = false;
      _isDraggingOutside = false;
      _isJustDragInside = true;
      _previousEmojiFocus = ReactionEmoji.nothing;
      _currentEmojiFocus = ReactionEmoji.nothing;
    });

    _hideBox();
  }

  void _onHorizontalDragUpdateBoxEmoji(DragUpdateDetails dragUpdateDetail) {
    if (!_isLongPress) return;

    // Use LOCAL position instead of global - this works regardless of scroll position
    final double localY = dragUpdateDetail.localPosition.dy;
    final double localX = dragUpdateDetail.localPosition.dx;

    // Check if drag is within the reaction box area
    // Box expands when dragging, so use expanded height for detection
    final double detectionHeight =
        _isDragging ? _boxHeightExpanded : _boxHeightNormal;
    final bool isDraggingInBox = localY < 0 &&
        localY > -(detectionHeight + _boxBottomOffset + 20) &&
        localX > _boxLeftOffset &&
        localX < (_boxLeftOffset + _boxWidth);

    if (isDraggingInBox) {
      _isDragging = true;
      _isDraggingOutside = false;

      if (_isJustDragInside && !_animControlEmojiWhenDragInside.isAnimating) {
        _animControlEmojiWhenDragInside.reset();
        _animControlEmojiWhenDragInside.forward();
      }

      // Calculate relative position within the box
      final double relativeX = localX - _boxLeftOffset;

      // Calculate which emoji is being touched
      final double emojiWidth = _boxWidth / EmojiRegistry.emojis.length;
      final int dragIndex = (relativeX / emojiWidth)
          .floor()
          .clamp(0, EmojiRegistry.emojis.length - 1);

      // Get the emoji at this index, accounting for RTL
      final ReactionEmoji targetEmoji =
          EmojiRegistry.getEmojiAtIndex(dragIndex, isRTL: _isRTL);

      if (targetEmoji != ReactionEmoji.nothing &&
          _currentEmojiFocus != targetEmoji) {
        _handleWhenDragBetweenEmoji(targetEmoji);
      }
    } else {
      _emojiUserChoose = ReactionEmoji.nothing;
      _previousEmojiFocus = ReactionEmoji.nothing;
      _currentEmojiFocus = ReactionEmoji.nothing;
      _isJustDragInside = true;

      if (_isDragging && !_isDraggingOutside) {
        _isDragging = false;
        _isDraggingOutside = true;
        _animControlEmojiWhenDragOutside.reset();
        _animControlEmojiWhenDragOutside.forward();
        _animControlBoxWhenDragOutside.reset();
        _animControlBoxWhenDragOutside.forward();
      }
    }
  }

  void _handleWhenDragBetweenEmoji(ReactionEmoji currentEmoji) {
    _emojiUserChoose = currentEmoji;
    _previousEmojiFocus = _currentEmojiFocus;
    _currentEmojiFocus = currentEmoji;
    _animControlEmojiWhenDrag.reset();
    _animControlEmojiWhenDrag.forward();
  }

  void _onTapDownBtn(TapDownDetails tapDownDetail) {
    _holdTimer = Timer(_durationLongPress, _showBox);
  }

  void _onTapUpBtn(TapUpDetails? tapUpDetail) {
    if (_isLongPress && _currentEmojiFocus != ReactionEmoji.nothing) {
      _handleReaction(_currentEmojiFocus);
    }

    _holdTimer?.cancel();

    Timer(Duration(milliseconds: _durationAnimationBox), () {
      if (mounted) {
        setState(() {
          _isLongPress = false;
        });
      }
    });

    _hideBox();
    _animControlBtnLongPress.reverse();
  }

  void _onTapBtn() {
    if (!_isLongPress) {
      if (_currentEmojiChoose == ReactionEmoji.nothing) {
        _handleReaction(ReactionEmoji.heart);
      } else {
        _handleReaction(_currentEmojiChoose);
      }
    }
  }

  void _showBox() {
    if (!mounted) return;

    setState(() {
      _isLongPress = true;
    });

    _animControlBtnLongPress.forward();
    _animControlBox.forward();
  }
}
