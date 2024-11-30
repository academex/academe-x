
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:academe_x/lib.dart';

extension contextExtenssion on BuildContext {
  void showSnackBar({required String message, bool error = false,int time = 2}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: error ? Colors.red.shade800 : Colors.green.shade800,
        duration:  Duration(seconds: time),
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,
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
