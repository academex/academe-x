import 'package:academe_x/core/core.dart';
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
      height: 115, // Adjust as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text:label,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          12.ph(),
          TextFormField(
            controller: controller,
            obscureText: isPassword && !isPasswordVisible,
            validator: validator,
            // textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: hintText,

              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                // borderSide: BorderSide.none,
                borderSide: const BorderSide(
                  color: Color(0xff3253FF)
                ),
                borderRadius: BorderRadius.circular(10),
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
