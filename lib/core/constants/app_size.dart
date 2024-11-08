import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    // Block size approach
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;



    // Default size for relative scaling
    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;

    AppLogger.wtf(screenWidth.toString());
    AppLogger.wtf(screenHeight.toString());
  }

  // Get the proportionate height according to screen size
  static double getProportionateScreenHeight(double inputHeight) {
    // 812 is the layout height that designer use
    return (inputHeight / 812.0) * screenHeight;
  }

  // Get the proportionate width according to screen size
  static double getProportionateScreenWidth(double inputWidth) {
    // 375 is the layout width that designer use
    return (inputWidth / 375.0) * screenWidth;
  }
}