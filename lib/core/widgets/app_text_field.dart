import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_text.dart';

class AppTextField extends StatelessWidget {
   AppTextField({
    Key? key,
    required this.hintText,

    // required this.text,
    // required this.labeltext,
    required this.keyboardType,
    required this.obscureText,
    required this.controller,
    this.focusNode,
    this.onSubmitted,
    this.onChanged,
    // this.isOTP=false,
    this.suffixIcon,
  }) : super(key: key);
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool obscureText;
  // final bool isOTP;
   FocusNode? focusNode = FocusNode();

  final Function(String)? onSubmitted;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          // inputFormatters:isOTP? [
          //   LengthLimitingTextInputFormatter(1),
          //   FilteringTextInputFormatter.digitsOnly
          // ] : null,
          onChanged: onChanged,
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
