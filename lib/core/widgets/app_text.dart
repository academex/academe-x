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


<<<<<<< HEAD
import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';
=======
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
>>>>>>> 536135a (Description of changes)

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  FontWeight fontWeight;
  TextAlign? textAlign;
  bool isUnderline;
  final VoidCallback? onPressed; // Added onPressed for click functionality

  AppText({
<<<<<<< HEAD
    super.key,
=======
    Key? key,
>>>>>>> 536135a (Description of changes)
    required this.text,
    required this.fontSize,
    this.color = Colors.black,
    this.textAlign,
    this.isUnderline = false,
    this.fontWeight = FontWeight.normal,
    this.onPressed, // Accept onPressed as a parameter
<<<<<<< HEAD
  });
=======
  }) : super(key: key);
>>>>>>> 536135a (Description of changes)

  @override
  Widget build(BuildContext context) {
    // If onPressed is provided, wrap the text in a GestureDetector
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
<<<<<<< HEAD
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
=======
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize.sp,
>>>>>>> 536135a (Description of changes)
          color: color,
          decoration: isUnderline ? TextDecoration.underline : null,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
