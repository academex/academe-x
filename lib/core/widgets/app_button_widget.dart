// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_text.dart';


class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width = double.infinity,
    this.height = 60,
    this.borderRadius = 10,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w500,
    this.color = const Color.fromARGB(255, 22, 134, 199),
  });
  double width;
  double height;
  double borderRadius;
  double fontSize;

  late String text;
  late VoidCallback onPressed;
  Color color;
  FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.r)),
          backgroundColor: color,
          minimumSize: Size(width.w, height.h)),
      child: AppText(
          text: text,
          fontSize: fontSize.sp,
          color: Colors.white,
          fontWeight: fontWeight),
    );
  }
}
