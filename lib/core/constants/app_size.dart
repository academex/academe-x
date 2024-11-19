// import 'package:academe_x/core/core.dart';
// import 'package:flutter/material.dart';
//
// class SizeConfig {
//   static late MediaQueryData _mediaQueryData;
//   static late double screenWidth;
//   static late double screenHeight;
//   static late double defaultSize;
//   static late Orientation orientation;
//   static late double blockSizeHorizontal;
//   static late double blockSizeVertical;
//
//   static void init(BuildContext context) {
//     _mediaQueryData = MediaQuery.of(context);
//     screenWidth = _mediaQueryData.size.width;
//     screenHeight = _mediaQueryData.size.height;
//     orientation = _mediaQueryData.orientation;
//     // Block size approach
//     blockSizeHorizontal = screenWidth / 100;
//     blockSizeVertical = screenHeight / 100;
//
//
//
//     // Default size for relative scaling
//     defaultSize = orientation == Orientation.landscape
//         ? screenHeight * 0.024
//         : screenWidth * 0.024;
//
//   }
//
//   // Get the proportionate height according to screen size
//   static double getProportionateScreenHeight(double inputHeight) {
//     AppLogger.success(screenHeight.toString());
//     // 812 is the layout height that designer use
//     return (inputHeight / 812.0) * screenHeight;
//   }
//
//   // Get the proportionate width according to screen size
//   static double getProportionateScreenWidth(double inputWidth) {
//     // 375 is the layout width that designer use
//     return (inputWidth / 375.0) * screenWidth;
//   }
// }

import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  // Device breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;

  // Base dimensions (design dimensions)
  static const double baseWidth = 375;
  static const double baseHeight = 812;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;

    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;
  }

  static double getProportionateScreenHeight(double inputHeight) {
    return (inputHeight / baseHeight) * screenHeight;
  }

  static double getProportionateScreenWidth(double inputWidth) {
    return (inputWidth / baseWidth) * screenWidth;
  }

  static double get gridItemHeight =>
      orientation == Orientation.landscape ? 45.0 : 52.0;

  static double get gridAspectRatio =>
      orientation == Orientation.landscape ? 3.0 : 2.5;

  static int get gridCrossAxisCount =>
      orientation == Orientation.landscape ? 6 : 4;

  static EdgeInsets get defaultPadding => EdgeInsets.symmetric(
    horizontal: getProportionateScreenWidth(20),
    vertical: getProportionateScreenHeight(20),
  );


  int getCrossAxisCount(BuildContext context,{int? lengthOfList}) {
    if (context.isDesktop) return 8;
    if (context.isTablet) return 6;
    // if(lengthOfList !=null && lengthOfList <4){
    //   return context.isLandscape ? 6 : 2;
    // }
    return context.isLandscape ? 6 : 4;
  }

  double getItemHeight(BuildContext context) {
    if (context.isDesktop) return 60.0;
    if (context.isTablet) return 52.0;
    return context.isLandscape ? 45.0 : 44.0;
  }
}