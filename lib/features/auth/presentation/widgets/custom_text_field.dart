<<<<<<< HEAD
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
=======
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
>>>>>>> 536135a (Description of changes)

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
<<<<<<< HEAD
=======
  final Widget icon;
>>>>>>> 536135a (Description of changes)
  final TextEditingController controller;
  final bool isPassword;
  final VoidCallback? togglePasswordVisibility;
  final bool isPasswordVisible;
<<<<<<< HEAD
  final String? Function(String?)? validator;


=======
>>>>>>> 536135a (Description of changes)

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
<<<<<<< HEAD
=======
    required this.icon,
>>>>>>> 536135a (Description of changes)
    required this.controller,
    this.isPassword = false,
    this.togglePasswordVisibility,
    this.isPasswordVisible = false,
<<<<<<< HEAD
    this.validator
=======
>>>>>>> 536135a (Description of changes)
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
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
>>>>>>> 536135a (Description of changes)
      ),
    );
  }
}
