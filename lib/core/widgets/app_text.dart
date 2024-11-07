// // ignore_for_file: must_be_immutable
//
// import 'package:flutter/material.dart';
//
// class AppText extends StatelessWidget {
//   final String text;
//   final double fontSize;
//   final Color color;
//   FontWeight fontWeight;
//   TextAlign? textAlign;
//   bool isUnderline;
//
//   AppText({
//     Key? key,
//     required this.text,
//     required this.fontSize,
//      this.color=Colors.black,
//     this.textAlign,
//     this.isUnderline = false,
//     this.fontWeight = FontWeight.normal,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       textAlign: textAlign,
//       style: TextStyle(
//         fontSize: fontSize,
//         color: color,
//         decoration: isUnderline ? TextDecoration.underline : null,
//         fontWeight: fontWeight,
//       ),
//     );
//     // );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  FontWeight fontWeight;
  TextAlign? textAlign;
  bool isUnderline;
  final VoidCallback? onPressed; // Added onPressed for click functionality

  AppText({
    super.key,
    required this.text,
    required this.fontSize,
    this.color = Colors.black,
    this.textAlign,
    this.isUnderline = false,
    this.fontWeight = FontWeight.normal,
    this.onPressed, // Accept onPressed as a parameter
  });

  @override
  Widget build(BuildContext context) {
    // If onPressed is provided, wrap the text in a GestureDetector
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize.sp,
          color: color,
          decoration: isUnderline ? TextDecoration.underline : null,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
