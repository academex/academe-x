import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    super.key,
    required this.hintText,

    // required this.text,
    // required this.labeltext,
    required this.keyboardType,
    this.obscureText = false,
    required this.controller,
    this.focusNode,
    this.onSubmitted,
    this.onChanged,
    this.suffix,
    this.prefixText,
    this.maxLine = 1,
    this.withBoarder = false,
    // this.isOTP=false,
    this.suffixIcon,
  });
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool obscureText;
  final Widget? suffix;
  final String? prefixText;
  int? maxLine;
  bool withBoarder;

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
          maxLines: maxLine,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          // inputFormatters:isOTP? [
          //   LengthLimitingTextInputFormatter(1),
          //   FilteringTextInputFormatter.digitsOnly
          // ] : null,
          onChanged: onChanged,
          decoration: InputDecoration(
            suffix: suffix,
            prefixText: prefixText,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black26),
            hintMaxLines: 1,
            suffixIcon: suffixIcon,
            enabledBorder:withBoarder? OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xffD9D9D9)),
            ):null,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: withBoarder?const Color(0xff3253FF):Colors.transparent),
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
