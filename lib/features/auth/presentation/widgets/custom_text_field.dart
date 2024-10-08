import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final VoidCallback? togglePasswordVisibility;
  final bool isPasswordVisible;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.togglePasswordVisibility,
    this.isPasswordVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94.h, // Adjust as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text:label,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          12.ph(),
          TextField(
            controller: controller,
            obscureText: isPassword && !isPasswordVisible,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedBorder: OutlineInputBorder(
                // borderSide: BorderSide.none,
                borderSide: const BorderSide(
                  color: Color(0xff3253FF)
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),

              filled: true,
              fillColor: Colors.grey[100],
              suffixIcon: isPassword
                  ? IconButton(
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: togglePasswordVisibility,
              )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
