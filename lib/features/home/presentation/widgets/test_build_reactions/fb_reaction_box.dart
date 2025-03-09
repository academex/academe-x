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

class FbReactionBoxState extends State<FbReactionBox> with TickerProviderStateMixin {

  final int _durationAnimationBox = 500;
  final int _durationAnimationBtnLongPress = 150;
  final int _durationAnimationBtnShortPress = 500;
  final int _durationAnimationEmojiWhenDrag = 150;
  final int _durationAnimationEmojiWhenRelease = 1000;
  final _durationLongPress = Duration(milliseconds: 250);

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

  // Emoji animations
  late Animation _pushEmojiHeartUp;
  late Animation _pushEmojiCelebrateUp;
  late Animation _pushEmojiHahaUp;
  late Animation _pushEmojiQuestionUp;
  late Animation _pushEmojiIghtfulUp;

  late Animation _zoomEmojiCelebrate;
  late Animation _zoomEmojiHeart;
  late Animation _zoomEmojiHaha;
  late Animation _zoomEmojiQuestion;
  late Animation _zoomEmojiIghtful;

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
  late Timer _holdTimer;



  @override
  void initState() {
    super.initState();

    _initializeUserReaction();
    _initializeAnimations();

  }

  void _initializeUserReaction() async{
    if(widget.post.isReacted!){
      final currentUserReaction = widget.post.reactionType;
      if (currentUserReaction != null) {
        setState(() {
          _currentEmojiChoose = _getReactionEmojiFromString(currentUserReaction);
          _currentEmojiFocus = _currentEmojiChoose;
          _isLiked = _currentEmojiChoose != ReactionEmoji.nothing;
        });
      } else {
        setState(() {
          _currentEmojiChoose = ReactionEmoji.nothing;
          _currentEmojiFocus = ReactionEmoji.nothing;
          _isLiked = false;
        });
      }


    }

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

  void _hideBox() {
    setState(() {
      _isLongPress = false;
      _isDragging = false;
      _isDraggingOutside = false;
      _isJustDragInside = true;
      // _currentEmojiFocus = ReactionEmoji.nothing;
      // _previousEmojiFocus = ReactionEmoji.nothing;
    });

    // Reverse all animations
    _animControlBtnLongPress.reverse();
    _animControlBox.reverse();
    _animControlEmojiWhenRelease.reset();
    _animControlEmojiWhenRelease.forward();
  }
  void _handleReaction(ReactionEmoji reaction) async {
    // If clicking the same reaction that's already selected, remove it

    if (reaction == _currentEmojiChoose) {
      widget.onReact(reaction.name);

      setState(() {
        _currentEmojiChoose = ReactionEmoji.nothing;
        // _emojiUserChoose = ReactionEmoji.nothing;
        _currentEmojiFocus = ReactionEmoji.nothing;
        _isLiked = false;
      });
    }
    else {
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
    _animControlBtnLongPress =
        AnimationController(vsync: this, duration: Duration(milliseconds: _durationAnimationBtnLongPress));
    _zoomEmojiLikeInBtn = Tween(begin: 1.0, end: 0.85).animate(_animControlBtnLongPress);
    _tiltEmojiLikeInBtn = Tween(begin: 0.0, end: 0.2).animate(_animControlBtnLongPress);
    _zoomTextLikeInBtn = Tween(begin: 1.0, end: 0.85).animate(_animControlBtnLongPress);

    _zoomEmojiLikeInBtn.addListener(() {
      setState(() {});
    });
    _tiltEmojiLikeInBtn.addListener(() {
      setState(() {});
    });
    _zoomTextLikeInBtn.addListener(() {
      setState(() {});
    });

    // short press
    _animControlBtnShortPress =
        AnimationController(vsync: this, duration: Duration(milliseconds: _durationAnimationBtnShortPress));
    _zoomEmojiLikeInBtn = Tween(begin: 1.0, end: 0.2).animate(_animControlBtnShortPress);
    _tiltEmojiLikeInBtn = Tween(begin: 0.0, end: 0.8).animate(_animControlBtnShortPress);
    _zoomEmojiLikeInBtn.addListener(() {
      setState(() {});
    });
    _tiltEmojiLikeInBtn.addListener(() {
      setState(() {});
    });
  }
  void _initAnimationBoxAndEmojis() {
    _animControlBox = AnimationController(vsync: this, duration: Duration(milliseconds: _durationAnimationBox));

    // General
    _moveRightGroupEmoji = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.0, 1.0)),
    );
    _moveRightGroupEmoji.addListener(() {
      setState(() {});
    });

    // Box
    _fadeInBox = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.7, 1.0)),
    );
    _fadeInBox.addListener(() {
      setState(() {});
    });

    // Emoji
    _pushEmojiHeartUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.0, 0.5)),
    );
    _zoomEmojiHeart = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.0, 0.5)),
    );

    _pushEmojiCelebrateUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.1, 0.6)),
    );
    _zoomEmojiCelebrate = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.1, 0.6)),
    );

    _pushEmojiHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.2, 0.7)),
    );
    _zoomEmojiHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.2, 0.7)),
    );

    _pushEmojiQuestionUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.3, 0.8)),
    );
    _zoomEmojiQuestion= Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.3, 0.8)),
    );

    _pushEmojiIghtfulUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.4, 0.9)),
    );
    _zoomEmojiIghtful = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.4, 0.9)),
    );
    //
    // _pushEmojiAngryUp = Tween(begin: 30.0, end: 60.0).animate(
    //   CurvedAnimation(parent: _animControlBox, curve: Interval(0.5, 1.0)),
    // );
    // _zoomEmojiAngry = Tween(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(parent: _animControlBox, curve: Interval(0.5, 1.0)),
    // );

    _pushEmojiHeartUp.addListener(() {
      setState(() {});
    });
    _zoomEmojiHeart.addListener(() {
      setState(() {});
    });
    _pushEmojiIghtfulUp.addListener(() {
      setState(() {});
    });
    _zoomEmojiIghtful.addListener(() {
      setState(() {});
    });
    _pushEmojiHahaUp.addListener(() {
      setState(() {});
    });
    _zoomEmojiHaha.addListener(() {
      setState(() {});
    });
    _pushEmojiCelebrateUp.addListener(() {
      setState(() {});
    });
    _zoomEmojiCelebrate.addListener(() {
      setState(() {});
    });
    _pushEmojiQuestionUp.addListener(() {
      setState(() {});
    });
    _zoomEmojiQuestion.addListener(() {
      setState(() {});
    });
    // _pushEmojiAngryUp.addListener(() {
    //   setState(() {});
    // });
    // _zoomEmojiAngry.addListener(() {
    //   setState(() {});
    // });
  }
  void _initAnimationEmojiWhenDrag() {
    _animControlEmojiWhenDrag =
        AnimationController(vsync: this, duration: Duration(milliseconds: _durationAnimationEmojiWhenDrag));

    _zoomEmojiChosen = Tween(begin: 1.0, end: 1.8).animate(_animControlEmojiWhenDrag);
    _zoomEmojiNotChosen = Tween(begin: 1.0, end: 0.8).animate(_animControlEmojiWhenDrag);
    _zoomBoxEmoji = Tween(begin: 50.0, end: 40.0).animate(_animControlEmojiWhenDrag);

    _zoomEmojiChosen.addListener(() {
      setState(() {});
    });
    _zoomEmojiNotChosen.addListener(() {
      setState(() {});
    });
    _zoomBoxEmoji.addListener(() {
      setState(() {});
    });
  }
  void _initAnimationEmojiWhenDragOutside() {
    _animControlEmojiWhenDragOutside =
        AnimationController(vsync: this, duration: Duration(milliseconds: _durationAnimationEmojiWhenDrag));
    _zoomEmojiWhenDragOutside = Tween(begin: 0.8, end: 1.0).animate(_animControlEmojiWhenDragOutside);
    _zoomEmojiWhenDragOutside.addListener(() {
      setState(() {});
    });
  }
  void _initAnimationBoxWhenDragOutside() {
    _animControlBoxWhenDragOutside =
        AnimationController(vsync: this, duration: Duration(milliseconds: _durationAnimationEmojiWhenDrag));
    _zoomBoxWhenDragOutside = Tween(begin: 40.0, end: 50.0).animate(_animControlBoxWhenDragOutside);
    _zoomBoxWhenDragOutside.addListener(() {
      setState(() {});
    });
  }
  void _initAnimationEmojiWhenDragInside() {
    _animControlEmojiWhenDragInside =
        AnimationController(vsync: this, duration: Duration(milliseconds: _durationAnimationEmojiWhenDrag));
    _zoomEmojiWhenDragInside = Tween(begin: 1.0, end: 0.8).animate(_animControlEmojiWhenDragInside);
    _zoomEmojiWhenDragInside.addListener(() {
      setState(() {});
    });
    _animControlEmojiWhenDragInside.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isJustDragInside = false;
      }
    });
  }
  void _initAnimationEmojiWhenRelease() {
    _animControlEmojiWhenRelease =
        AnimationController(vsync: this, duration: Duration(milliseconds: _durationAnimationEmojiWhenRelease));

    _zoomEmojiWhenRelease = Tween(begin: 1.8, end: 0.0)
        .animate(CurvedAnimation(parent: _animControlEmojiWhenRelease, curve: Curves.decelerate));

    _moveUpEmojiWhenRelease = Tween(begin: 180.0, end: 0.0)
        .animate(CurvedAnimation(parent: _animControlEmojiWhenRelease, curve: Curves.decelerate));

    // _moveLeftEmojiLikeWhenRelease = Tween(begin: 20.0, end: 10.0)
    //     .animate(CurvedAnimation(parent: _animControlEmojiWhenRelease, curve: Curves.decelerate));
    // _moveLeftEmojiLoveWhenRelease = Tween(begin: 68.0, end: 10.0)
    //     .animate(CurvedAnimation(parent: _animControlEmojiWhenRelease, curve: Curves.decelerate));
    // _moveLeftEmojiHahaWhenRelease = Tween(begin: 116.0, end: 10.0)
    //     .animate(CurvedAnimation(parent: _animControlEmojiWhenRelease, curve: Curves.decelerate));
    // _moveLeftEmojiWowWhenRelease = Tween(begin: 164.0, end: 10.0)
    //     .animate(CurvedAnimation(parent: _animControlEmojiWhenRelease, curve: Curves.decelerate));
    // _moveLeftEmojiSadWhenRelease = Tween(begin: 212.0, end: 10.0)
    //     .animate(CurvedAnimation(parent: _animControlEmojiWhenRelease, curve: Curves.decelerate));
    // _moveLeftEmojiAngryWhenRelease = Tween(begin: 260.0, end: 10.0)
    //     .animate(CurvedAnimation(parent: _animControlEmojiWhenRelease, curve: Curves.decelerate));

    _zoomEmojiWhenRelease.addListener(() {
      setState(() {});
    });
    _moveUpEmojiWhenRelease.addListener(() {
      setState(() {});
    });
    //
    // _moveLeftEmojiLikeWhenRelease.addListener(() {
    //   setState(() {});
    // });
    // _moveLeftEmojiLoveWhenRelease.addListener(() {
    //   setState(() {});
    // });
    // _moveLeftEmojiHahaWhenRelease.addListener(() {
    //   setState(() {});
    // });
    // _moveLeftEmojiWowWhenRelease.addListener(() {
    //   setState(() {});
    // });
    // _moveLeftEmojiSadWhenRelease.addListener(() {
    //   setState(() {});
    // });
    // _moveLeftEmojiAngryWhenRelease.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
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
    return  GestureDetector(

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



  Widget _buildEmojiItem(ReactionEmoji emoji, double pushUp, double height, double scale) {
    return Transform.scale(
      scale: scale,
      child: SizedBox(
        height: height,
        width: 40,
        // margin: EdgeInsets.only(bottom: pushUp),
        child: Column(
          children: [
            if (_currentEmojiFocus == emoji)
              Container(
                width: 38.90,
                height: 22.54,
                padding: const EdgeInsets.symmetric(horizontal: 5.45, vertical: 3.27),
                decoration: ShapeDecoration(
                  color: Color(0xFFFF7D99),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.78),
                  ),),
                // padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                // margin: EdgeInsets.only(bottom: 8),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),
                //   color: Colors.black.withOpacity(0.3),
                // ),
                child: Text(
                  _getEmojiText(emoji),
                  style: TextStyle(fontSize: 8, color: Colors.white),
                ),
              ),

            SvgPicture.asset(_getEmojiIcon(emoji)),  // Replace with appropriate emoji asset
          ],
        ),
      ),
    );
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
  Widget _buildReactionBox() {
    return Positioned(
      bottom: 55,
      left: -140,
      child: Opacity(
        opacity: _fadeInBox.value,
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
                ))),

      ),
    );
  }

  // Widget _buildEmojiRow() {
  //   return Positioned(
  //     bottom: 55,
  //     left: -140,
  //     child: SizedBox(
  //       width: 206,
  //       // height: 250,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           _buildEmojiItem(
  //             ReactionEmoji.heart,
  //             _pushEmojiHeartUp.value,
  //             _currentEmojiFocus == ReactionEmoji.heart ? 70.0 : 40.0,
  //             _getEmojiScale(ReactionEmoji.heart),
  //           ),
  //           _buildEmojiItem(
  //             ReactionEmoji.haha,
  //             _pushEmojiHahaUp.value,
  //             _currentEmojiFocus == ReactionEmoji.haha ? 70.0 : 40.0,
  //             _getEmojiScale(ReactionEmoji.haha),
  //           ),
  //           _buildEmojiItem(
  //             ReactionEmoji.question,
  //             _pushEmojiQuestionUp.value,
  //             _currentEmojiFocus == ReactionEmoji.question ? 70.0 : 40.0,
  //             _getEmojiScale(ReactionEmoji.question),
  //           ),
  //           _buildEmojiItem(
  //             ReactionEmoji.insightful,
  //             _pushEmojiIghtfulUp.value,
  //             _currentEmojiFocus == ReactionEmoji.insightful ? 70.0 : 40.0,
  //             _getEmojiScale(ReactionEmoji.insightful),
  //           ),
  //           _buildEmojiItem(
  //             ReactionEmoji.celebrate,
  //             _pushEmojiCelebrateUp.value,
  //             _currentEmojiFocus == ReactionEmoji.celebrate ? 70.0 : 40.0,
  //             _getEmojiScale(ReactionEmoji.celebrate),
  //           ),
  //
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _buildEmojiRow() {
    return Positioned(
      bottom: 55,
      left: -140,
      child: SizedBox(
        width: 206,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildEmojiItem(
              ReactionEmoji.celebrate,
              _pushEmojiCelebrateUp.value,
              _currentEmojiFocus == ReactionEmoji.celebrate ? 70.0 : 40.0,
              _getEmojiScale(ReactionEmoji.celebrate),
            ),
            _buildEmojiItem(
              ReactionEmoji.insightful,
              _pushEmojiIghtfulUp.value,
              _currentEmojiFocus == ReactionEmoji.insightful ? 70.0 : 40.0,
              _getEmojiScale(ReactionEmoji.insightful),
            ),
            _buildEmojiItem(
              ReactionEmoji.question,
              _pushEmojiQuestionUp.value,
              _currentEmojiFocus == ReactionEmoji.question ? 70.0 : 40.0,
              _getEmojiScale(ReactionEmoji.question),
            ),
            _buildEmojiItem(
              ReactionEmoji.funny,
              _pushEmojiHahaUp.value,
              _currentEmojiFocus == ReactionEmoji.funny ? 70.0 : 40.0,
              _getEmojiScale(ReactionEmoji.funny),
            ),
            _buildEmojiItem(
              ReactionEmoji.heart,
              _pushEmojiHeartUp.value,
              _currentEmojiFocus == ReactionEmoji.heart ? 70.0 : 40.0,
              _getEmojiScale(ReactionEmoji.heart),
            ),
          ],
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
      switch (emoji) {
        case ReactionEmoji.celebrate:
          return _zoomEmojiCelebrate.value;
        case ReactionEmoji.insightful:
          return _zoomEmojiIghtful.value;
        case ReactionEmoji.funny:
          return _zoomEmojiHaha.value;
        case ReactionEmoji.question:
          return _zoomEmojiQuestion.value;
        case ReactionEmoji.heart:
          return _zoomEmojiHeart.value;
        default:
          return 1.0;
      }
    }
  }

  Widget _buildLikeButton() {
    return GestureDetector(
      onHorizontalDragEnd: _onHorizontalDragEndBoxEmoji,
      onHorizontalDragUpdate: _onHorizontalDragUpdateBoxEmoji,
      onTapDown: _onTapDownBtn,
      onTapUp: _onTapUpBtn,
      onTap: _onTapBtn,
      child: Container(
        width: 80,
        height: 42,
        // constraints: BoxConstraints(maxWidth: 120),
        decoration: ShapeDecoration(
          color: _getColorBtn(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: SvgPicture.asset(
              _getImageEmojiBtn(),
              width: 22,
              height: 22,
            ),),
            Expanded(child:
            AppText(text:  _getTextBtn(),
              fontSize: 10,
              color: Color(0xFF707281),
              fontWeight: FontWeight.w600,
            ))
          ],
        ),
      ),
    );
  }

  String _getTextBtn() {
    if (_isDragging) {
      return widget.post.reactions!.count.toString();
    }
    switch (_currentEmojiChoose) {
      case ReactionEmoji.nothing:
        return widget.post.reactions!.count.toString();
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


  String _getImageEmojiBtn() {
    // if (!_isLongPress && _isLiked) {
    //   return AppAssets.defaultIcon;
    // } else
    if (!_isDragging) {
      switch (_currentEmojiChoose) {
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
    } else {
      return AppAssets.defaultIcon;
    }
  }

  Color _getColorBtn() {

    if (!_isDragging) {
      switch (_currentEmojiChoose) {
        case ReactionEmoji.celebrate:
          return Color(0xffFFDCD4);
        case ReactionEmoji.heart:
          return Color(0xffFF5D5D);
        case ReactionEmoji.question:
          return Color(0xff0EC2B4);
        case ReactionEmoji.insightful:
          return Color(0xffFF7D99);
        case ReactionEmoji.nothing:
          return Color(0xFFF7F7F8);

        case ReactionEmoji.funny:
          return Color(0xff0EC2B4);
      // TODO: Handle this case.
      }
    } else {
      return Colors.grey;
    }
  }

  void _onHorizontalDragEndBoxEmoji(DragEndDetails dragEndDetail) {
    if (_currentEmojiFocus != ReactionEmoji.nothing) {
      // If dragging to the same emoji that's already selected, remove it
      if (_currentEmojiFocus == _currentEmojiChoose) {
        _handleReaction(_emojiUserChoose); // Will remove the reaction
      } else {
        _handleReaction(_currentEmojiFocus); // Will change to new reaction
      }
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

    // Adjust these values based on your actual box position
    final double boxStartY = 100;
    final double boxEndY = 500;

    // These values should match your actual layout
    final double boxWidth = 206.0; // Width of your reaction box
    // final double boxLeft = -140.0; // Left position of your box

    if (dragUpdateDetail.globalPosition.dy >= boxStartY &&
        dragUpdateDetail.globalPosition.dy <= boxEndY) {
      _isDragging = true;
      _isDraggingOutside = false;

      if (_isJustDragInside && !_animControlEmojiWhenDragInside.isAnimating) {
        _animControlEmojiWhenDragInside.reset();
        _animControlEmojiWhenDragInside.forward();
      }

      // Calculate relative position within the box
      final double relativeX = dragUpdateDetail.localPosition.dx + 140; // Adjust for box offset

      // Define emoji zones (adjust these values based on your layout)
      final double emojiWidth = boxWidth / 5; // Divide box width by number of emojis
      final int emojiIndex = (relativeX / emojiWidth).floor();

      // Map index to emoji based on the order in _buildEmojiRow
      ReactionEmoji targetEmoji = ReactionEmoji.nothing;
      if (relativeX >= 0 && relativeX <= boxWidth) {
        switch (emojiIndex) {
          case 0:
            targetEmoji = ReactionEmoji.heart;

            break;
          case 1:
            targetEmoji = ReactionEmoji.funny;

            break;
          case 2:
            targetEmoji = ReactionEmoji.question;
            break;
          case 3:
            targetEmoji = ReactionEmoji.insightful;
            break;
          case 4:
            targetEmoji = ReactionEmoji.celebrate;

            break;
        }

        if (targetEmoji != ReactionEmoji.nothing &&
            _currentEmojiFocus != targetEmoji) {
          _handleWhenDragBetweenEmoji(targetEmoji);
        }
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

    Timer(Duration(milliseconds: _durationAnimationBox), () {
      setState(() {
        _isLongPress = false;
      });
    });

    _holdTimer.cancel();
    _hideBox();

    _animControlBtnLongPress.reverse();
    setReverseValue();
    _animControlBox.reverse();
    _animControlEmojiWhenRelease.reset();
    _animControlEmojiWhenRelease.forward();
  }



  // when user short press the button

  void _onTapBtn() {
    if (!_isLongPress) {
      if (_currentEmojiChoose == ReactionEmoji.nothing) {
        _handleReaction(ReactionEmoji.heart); // Default reaction
      } else  {
        _handleReaction(_currentEmojiChoose); // Will remove the current reaction
      }
    }
  }





  void _showBox() {
    // _playSound(AssetSounds.boxUp);
    _isLongPress = true;

    _animControlBtnLongPress.forward();

    _setForwardValue();
    _animControlBox.forward();
  }

  // We need to set the value for reverse because if not
  // the angry-emoji will be pulled down first, not the like-emoji
  void setReverseValue() {
    // Emojis
    _pushEmojiHeartUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.5, 1.0)),
    );
    _zoomEmojiHeart = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.5, 1.0)),
    );

    _pushEmojiCelebrateUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.4, 0.9)),
    );
    _zoomEmojiCelebrate = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.4, 0.9)),
    );

    _pushEmojiHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.3, 0.8)),
    );
    _zoomEmojiHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.3, 0.8)),
    );

    _pushEmojiQuestionUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.2, 0.7)),
    );
    _zoomEmojiQuestion= Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.2, 0.7)),
    );

    _pushEmojiIghtfulUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.1, 0.6)),
    );
    _zoomEmojiIghtful = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.1, 0.6)),
    );

    // _pushEmojiAngryUp = Tween(begin: 30.0, end: 60.0).animate(
    //   CurvedAnimation(parent: _animControlBox, curve: Interval(0.0, 0.5)),
    // );
    // _zoomEmojiAngry = Tween(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(parent: _animControlBox, curve: Interval(0.0, 0.5)),
    // );
  }

  // When set the reverse value, we need set value to normal for the forward
  void _setForwardValue() {
    // Emojis
    _pushEmojiHeartUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.0, 0.5)),
    );
    _zoomEmojiHeart = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.0, 0.5)),
    );

    _pushEmojiIghtfulUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.1, 0.6)),
    );
    _zoomEmojiIghtful= Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.1, 0.6)),
    );

    _pushEmojiHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.2, 0.7)),
    );
    _zoomEmojiHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.2, 0.7)),
    );

    _pushEmojiQuestionUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.3, 0.8)),
    );
    _zoomEmojiQuestion = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.3, 0.8)),
    );

    _pushEmojiCelebrateUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.4, 0.9)),
    );
    _zoomEmojiCelebrate= Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animControlBox, curve: Interval(0.4, 0.9)),
    );

    // _pushEmojiAngryUp = Tween(begin: 30.0, end: 60.0).animate(
    //   CurvedAnimation(parent: _animControlBox, curve: Interval(0.5, 1.0)),
    // );
    // _zoomEmojiAngry = Tween(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(parent: _animControlBox, curve: Interval(0.5, 1.0)),
    // );
  }

}