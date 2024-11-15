// import 'package:academe_x/lib.dart';
// import 'package:flutter/material.dart';
//
// class CustomTextField extends StatelessWidget {
//   final String label;
//   final String hintText;
//   final TextEditingController controller;
//   final bool isPassword;
//   final VoidCallback? togglePasswordVisibility;
//   final bool isPasswordVisible;
//   final String? Function(String?)? validator;
//
//
//
//   const CustomTextField({
//     super.key,
//     required this.label,
//     required this.hintText,
//     required this.controller,
//     this.isPassword = false,
//     this.togglePasswordVisibility,
//     this.isPasswordVisible = false,
//     this.validator
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 94, // Adjust as needed
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           AppText(
//             text:label,
//             color: AppColors.black,
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//           ),
//           12.ph(),
//           TextFormField(
//             controller: controller,
//             obscureText: isPassword && !isPasswordVisible,
//             validator: validator,
//             // textAlign: TextAlign.right,
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: const TextStyle(
//                 color: Color(0xFF949494),
//                 fontSize: 14,
//                 fontFamily: 'Cairo',
//                 fontWeight: FontWeight.w400,
//                 height: 0.11,
//               ),
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 // borderSide: BorderSide.none,
//                 borderSide: const BorderSide(
//                   strokeAlign: BorderSide.strokeAlignCenter,
//                   color: Color(0x38D9D9D9),
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               filled: true,
//               fillColor: const Color(0xFFF9F9F9),
//               suffixIcon: isPassword
//                   ? IconButton(
//                 icon: Image.asset(AppAssets.visibilePassword,height: 24,width: 24,),
//                 onPressed: togglePasswordVisibility,
//               )
//                   : null,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool isPhone;
  final bool isGender;
  final VoidCallback? togglePasswordVisibility;
  final bool isPasswordVisible;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.isPhone = false,
    this.isGender = false,
    this.togglePasswordVisibility,
    this.isPasswordVisible = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: label,
            color: AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          12.ph(),
         isGender? _buildGenderField() :_buildTextFormField(),
        ],
      ),
    );
  }

  Widget _buildGenderField (){
    return  Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(

          width: 154,
          height: 56,
          decoration: ShapeDecoration(
            color: const Color(0xFFF9F9F9),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFF3253FF)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        28.pw(),
        Container(
          width: 154,
          height: 56,
          decoration: ShapeDecoration(
            color:const Color(0xFFF9F9F9),
            shape: RoundedRectangleBorder(
              side:const BorderSide(width: 1, color: Color(0xFF3253FF)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

      ],
    );
  }

  TextFormField _buildTextFormField() {
    return TextFormField(
          controller: controller,
          obscureText: isPassword && !isPasswordVisible,
          validator: validator,
          keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
          textDirection: isPhone ? TextDirection.ltr : TextDirection.rtl,
          inputFormatters: isPhone ? [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(9),
          ] : null,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF949494),
              fontSize: 14,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
              height: 0.11,
            ),
            prefixIcon: isPhone ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsets.only(left: 12),
              child:  Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    text: '+972', color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  8.pw(),
                  Container(
                    height: 35,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ) : null,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
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
              icon: Image.asset(AppAssets.visibilePassword, height: 24, width: 24),
              onPressed: togglePasswordVisibility,
            )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        );
  }
}

// // Usage example:
// // For normal text field:
// CustomTextField(
// label: "الاسم",
// hintText: "أدخل اسمك",
// controller: nameController,
// );
//
// // For password field:
// CustomTextField(
// label: "كلمة المرور",
// hintText: "أدخل كلمة المرور",
// controller: passwordController,
// isPassword: true,
// isPasswordVisible: isPasswordVisible,
// togglePasswordVisibility: () {
// // Your toggle logic here
// },
// );
//
// // For phone field:
// CustomTextField(
// label: "رقم الهاتف",
// hintText: "أدخل رقم الهاتف",
// controller: phoneController,
// isPhone: true,
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'الرجاء إدخال رقم الهاتف';
// }
// if (value.length != 9) {
// return 'رقم الهاتف يجب أن يتكون من 9 أرقام';
// }
// return null;
// },
// );