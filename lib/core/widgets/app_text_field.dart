<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'app_text.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    super.key,
=======
import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_text.dart';

class AppTextField extends StatelessWidget {
   AppTextField({
    Key? key,
>>>>>>> 536135a (Description of changes)
    required this.hintText,

    // required this.text,
    // required this.labeltext,
    required this.keyboardType,
<<<<<<< HEAD
    this.obscureText = false,
=======
    required this.obscureText,
>>>>>>> 536135a (Description of changes)
    required this.controller,
    this.focusNode,
    this.onSubmitted,
    this.onChanged,
<<<<<<< HEAD
    this.suffix,
    this.prefixText,
    this.maxLine = 1,
    this.minLine = 1,
    this.withBoarder = false,
    this.autofocus = false,
    this.enableBoarderColor,
    this.fucusBoarderColor,
    // this.isOTP=false,
    this.suffixIcon,
    this.isDense,
    this.enabled,
    this.contentPadding,
    this.hintStyle,
    this.fillColor,
    this.onFieldSubmitted,
    this.textInputAction,
  });
=======
    // this.isOTP=false,
    this.suffixIcon,
  }) : super(key: key);
>>>>>>> 536135a (Description of changes)
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool obscureText;
<<<<<<< HEAD
  final Widget? suffix;
  final String? prefixText;
  int? maxLine;
  int? minLine;
  bool withBoarder;
  bool autofocus;
  Color? enableBoarderColor;
  Color? fucusBoarderColor;
  Color? fillColor;
  bool? isDense;
  bool? enabled;
  EdgeInsetsGeometry? contentPadding;
  TextStyle? hintStyle;
  ValueChanged<String>? onFieldSubmitted;
  TextInputAction? textInputAction;

  // final bool isOTP;
  FocusNode? focusNode = FocusNode();
=======
  // final bool isOTP;
   FocusNode? focusNode = FocusNode();
>>>>>>> 536135a (Description of changes)

  final Function(String)? onSubmitted;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
<<<<<<< HEAD
          enabled: enabled,
          autofocus: autofocus,
          maxLines: maxLine,
          minLines: minLine,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,

=======
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
>>>>>>> 536135a (Description of changes)
          // inputFormatters:isOTP? [
          //   LengthLimitingTextInputFormatter(1),
          //   FilteringTextInputFormatter.digitsOnly
          // ] : null,
          onChanged: onChanged,
<<<<<<< HEAD
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            fillColor: fillColor,
            isDense: isDense,
            contentPadding: contentPadding,
            suffix: suffix,
            prefixText: prefixText,
            hintText: hintText,
            hintStyle: hintStyle?? TextStyle(color: Colors.black26),
            hintMaxLines: 1,
            suffixIcon: suffixIcon,
            enabledBorder:withBoarder? OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: enableBoarderColor?? Color(0xffD9D9D9)),
            ):null,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: withBoarder?Color(0xff3253FF):Colors.transparent),
            ),
            disabledBorder:withBoarder? OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: enableBoarderColor?? Color(0xffD9D9D9)),
            ):null,
=======
          decoration: InputDecoration(
            hintText: hintText,
            hintMaxLines: 1,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xffD9D9D9)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xff3253FF)),
            ),
>>>>>>> 536135a (Description of changes)
            // enabledBorder: buildOutlineInputBorder(color:focusedBorderColor),
            // focusedBorder: buildOutlineInputBorder(color:focusedBorderColor),
          ),
        ),
      ],
    );
  }
}







// TextField(
// // keyboardType: TextInputType.number,
// decoration: InputDecoration(
// // labelText: 'Phone',
// // hintText: 'Enter Your Phone Number',
// floatingLabelBehavior: FloatingLabelBehavior.always,
// enabledBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(28),
// borderSide: BorderSide(color: Color(0xff8b8b8b)),
// gapPadding: 10
// ),
// focusedBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(28),
// borderSide: BorderSide(color: Color(0xff8b8b8b)),
// gapPadding: 10
// ),
// suffixIcon: Icon(Icons.phone),
//
//
// ),
// ),
//
//
