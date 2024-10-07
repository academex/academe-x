import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final Widget icon;
  final TextEditingController controller;
  final bool isPassword;
  final VoidCallback? togglePasswordVisibility;
  final bool isPasswordVisible;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.togglePasswordVisibility,
    this.isPasswordVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.r),
        ),
        prefixIcon: icon,
        filled: true,
        fillColor:  Colors.grey[100],
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: togglePasswordVisibility,
        )
            : null,
      ),
    );
  }
}
