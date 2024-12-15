
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:academe_x/lib.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

extension contextExtenssion on BuildContext {
  void showSnackBar({required String message,
    bool error = false,
    int time = 2,
    SnackBarBehavior? behavior,
    void Function()? onTap,bool loading = false,}) {
    ScaffoldMessenger.of(this).showSnackBar(
      snackBarAnimationStyle: AnimationStyle(duration: const Duration(seconds: 1)),

      SnackBar(
        content: GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText(
                fontSize: 12.sp,
                text: message,
                color: Colors.white,
              ),
              if(loading)
                2.ph(),
              if(loading)
              const LinearProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ],
          ),
        ),
        backgroundColor: error ? Colors.red.shade800 : Colors.green.shade800,
        duration:  Duration(seconds: time),
        dismissDirection: DismissDirection.horizontal,
        behavior: behavior??SnackBarBehavior.floating,
        padding: loading?EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w):null,


      ),
    );
  }

  bool get isMobile => MediaQuery.of(this).size.width < SizeConfig.mobileBreakpoint;
  bool get isTablet => MediaQuery.of(this).size.width >= SizeConfig.mobileBreakpoint
      && MediaQuery.of(this).size.width < SizeConfig.tabletBreakpoint;
  bool get isDesktop => MediaQuery.of(this).size.width >= SizeConfig.tabletBreakpoint;

  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;
  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;
  bool get isPortrait => MediaQuery.of(this).orientation == Orientation.portrait;
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  double hp(double percent) => screenHeight * (percent / 100);
  double wp(double percent) => screenWidth * (percent / 100);

  // AppLocalizations

  AppLocalizations get localizations => AppLocalizations.of(this)!;



}
