// import 'package:flutter/material.dart';
// import '../constants/app_size.dart';

// extension SizeExtension on num {
//   double get h => SizeConfig.getProportionateScreenHeight(this.toDouble());
//   double get w => SizeConfig.getProportionateScreenWidth(this.toDouble());

//   // For non-pixel units
//   double get sp => this.toDouble() * SizeConfig.defaultSize;
//   double get vw => this.toDouble() * SizeConfig.blockSizeHorizontal;
//   double get vh => this.toDouble() * SizeConfig.blockSizeVertical;
// }

// extension ContextSizeExtension on BuildContext {
//   double get width => MediaQuery.of(this).size.width;
//   double get height => MediaQuery.of(this).size.height;

//   Size get size => MediaQuery.of(this).size;
//   double get aspectRatio => size.width / size.height;

//   bool get isPhone => size.width < 600;
//   bool get isTablet => size.width >= 600 && size.width < 900;
//   bool get isDesktop => size.width >= 900;
// }