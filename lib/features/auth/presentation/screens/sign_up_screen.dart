import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/features/auth/presentation/widgets/robot_with_speech_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/app_robot.dart';
import '../../../../core/widgets/app_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/progress_bar_with_close_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            40.ph(),
            ProgressBarWithCloseButton(onClose: () {

            },
              progressValue: 0.5,),            19.ph(),
            const RobotWithSpeechBubble(svgString: mySignInRobotSVG, speechText: 'البيانات الشخصية'),

            // _buildRobotWithSpeechBubble(),
            20.ph(),
            _buildGoogleSignInButton(),
            30.ph(),
            _buildDividerWithText('أو إنشاء حسابي'),
            _buildFormFields(),
            30.ph(),
            _buildSubmitButton(context),
            20.ph(),
            _buildLoginOption(context),
            20.ph(),
          ],
        ),
      ),
    );
  }

  // Extracted ProgressBar and Close Button to avoid rebuilds
  // Widget _buildProgressBarWithCloseButton(BuildContext context) {
  //   return const _ProgressBarWithCloseButton();
  // }

  // Extracted Robot with SpeechBubble
  // Widget _buildRobotWithSpeechBubble() {
  //   return const _RobotWithSpeechBubble();
  // }

  // Extracted Google Sign-In Button
  Widget _buildGoogleSignInButton() {
    return CustomButton(
      color: const Color(0xffF9F9F9),
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.string(
              googleSVG

          ),
          10.pw(),
          AppText(
            text: 'الاستمرار بواسطة حساب جوجل',
            fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
      onPressed: () {
        final email = emailController.text;
        final password = passwordController.text;
        // Handle sign in logic here
      },
    );
  }

  // Extracted Divider with Text
  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: AppText(
            text: text,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ),
      ],
    );
  }

  // Extracted Form Fields
  Widget _buildFormFields() {
    return Column(
      children: [
        CustomTextField(
          hintText: 'أدخل اسمك هنا',
          label: 'الاسم',
          controller: nameController,
        ),
        16.ph(),
        CustomTextField(
          hintText: 'أدخل عنوان البريد الإلكتروني',
          label: 'البريد الإلكتروني',
          controller: emailController,
        ),
        16.ph(),
        CustomTextField(
          hintText: 'أدخل كلمة المرور',
          label: 'كلمة المرور',
          controller: passwordController,
          isPassword: true,
        ),
        16.ph(),
        CustomTextField(
          hintText: 'تأكيد كلمة المرور',
          label: 'تأكيد كلمة المرور',
          controller: confirmPasswordController,
          isPassword: true,
        ),
      ],
    );
  }

  // Extracted Submit Button
  Widget _buildSubmitButton(BuildContext context) {
    return CustomButton(
      onPressed: () {
        // Handle submit logic here
      },
      widget: AppText(
        text: 'تحديد الكلية',
        fontSize: 14.sp,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        onPressed: () {
          Navigator.pushNamed(context, '/edu_info');


        },
      ),
      color: Colors.blueAccent,
    );
  }

  // Extracted Login Option Row
  Widget _buildLoginOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: 'لدي حساب بالفعل ؟',
          fontSize: 14.sp,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          child: AppText(
            text: ' تسجيل الدخول',
            fontSize: 14.sp,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

// Separate ProgressBar and CloseButton into a StatelessWidget for better performance
// class _ProgressBarWithCloseButton extends StatelessWidget {
//   const _ProgressBarWithCloseButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50.h,
//       child: Stack(
//         children: [
//           Positioned.fill(
//             right: 40,
//             child: Align(
//               alignment: Alignment.center,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: SizedBox(
//                   height: 10.h,
//                   width: 284.w,
//                   child: LinearProgressIndicator(
//                     value: 0.5,
//                     minHeight: 16.h,
//                     backgroundColor: Colors.grey[200],
//                     color: const Color(0xff5DCA14),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             right: 0,
//             child: IconButton(
//               icon: Icon(Icons.close, size: 24.w, color: Colors.black),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

