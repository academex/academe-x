import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final VoidCallback? togglePasswordVisibility;
  final bool isPasswordVisible;
  final String? Function(String?)? validator;



  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.togglePasswordVisibility,
    this.isPasswordVisible = false,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94, // Adjust as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text:label,
            color: AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          12.ph(),
          TextFormField(
            controller: controller,
            obscureText: isPassword && !isPasswordVisible,
            validator: validator,
            // textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF949494),
                fontSize: 14,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w400,
                height: 0.11,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                // borderSide: BorderSide.none,
                borderSide: const BorderSide(
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0x38D9D9D9),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: const Color(0xFFF9F9F9),
              suffixIcon: isPassword
                  ? IconButton(
                icon: Image.asset(AppAssets.visibilePassword,height: 24,width: 24,),
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
