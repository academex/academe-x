import 'package:academe_x/core/const/app_robot.dart';
import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/features/auth/presentation/widgets/divider_with_text.dart';
import 'package:academe_x/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import '../cubit/auth_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
// import '../widgets/google_sign_in_button.dart';
// import '../widgets/clickable_text.dart'; // Import clickable text
// import '../extensions/sized_box_extension.dart'; // Import the extension for SizedBox
// import '../widgets/app_text.dart'; // Import AppText widget

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 24.w,right:  24.w,top: 80.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: 'تسجيل الدخول',
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            8.ph(),
            AppText(
              text: 'أدخل بياناتك للدخول إلى عالم المعرفة والتعليم',
              fontSize: 14.sp,
              color: Colors.grey,
              textAlign: TextAlign.center,
            ),
            23.ph(),
            CustomTextField(
              label: 'البريد الإلكتروني',
              hintText: 'أدخل عنوان البريد الإلكتروني',
              controller: emailController,
            ),
            16.ph(),
            CustomTextField(
              label: 'كلمة المرور',

              hintText: 'أدخل كلمة المرور',
              controller: passwordController,
              isPassword: true,
              togglePasswordVisibility: () {
                // context.read<AuthCubit>().togglePasswordVisibility();
              },
              isPasswordVisible:true,
            ),
            12.ph(),
          Row(
            children: [
              Checkbox(

                value: false,

                side: const BorderSide(
                  color: Color(0xffECECEC)
                ),
                activeColor: const Color(0xFF474CA8), // Customize the active color
                onChanged: (bool? value) {
                  // setState(() {
                  //   _isChecked = value ?? false; // Update the checkbox state
                  // });
                },
              ),
              GestureDetector(
                onTap: () {
                  // Allow tapping on the text to toggle the checkbox
                  // setState(() {
                  //   _isChecked = !_isChecked;
                  // });
                },
                child: AppText(
                  text: 'تذكرني',
                  fontSize: 14.sp,
                  color: Color(0xff232323),
                ),
              ),
              const Spacer(), // To align the "هل نسيت كلمة المرور؟" to the right
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/forgot_Password');
                },
                child: AppText(
                  text: 'هل نسيت كلمة المرور؟',
                  fontSize: 14.sp,
                  isUnderline: true,
                  color: Color(0xff232323), // Customize color for "Forgot password"
                  // decoration: TextDecoration.underline, // Optional underline

                ),
              ),
            ],
          ),
            24.ph(),
            CustomButton(
              color: Colors.blueAccent,
              widget: Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                // context.read<AuthCubit>().login(email, password);
              },
            ),
            // BlocConsumer<AuthCubit, AuthState>(
            //   listener: (context, state) {
            //     if (state is AuthSuccess) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text('Login Successful')),
            //       );
            //     } else if (state is AuthFailure) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text(state.errorMessage)),
            //       );
            //     }
            //   },
            //   builder: (context, state) {
            //     if (state is AuthLoading) {
            //       return CircularProgressIndicator();
            //     }
            //
            //     return CustomButton(
            //       text: 'تسجيل الدخول',
            //       onPressed: () {
            //         final email = emailController.text;
            //         final password = passwordController.text;
            //         context.read<AuthCubit>().login(email, password);
            //       },
            //     );
            //   },
            // ),
            20.ph(),
            DividerWithText(text: 'أو تسجيل الدخول باستخدام'),
            20.ph(),

            // Google Sign-In Button
            // GoogleSignInButton(onPressed: (){}),

            CustomButton(
              color: Color(0xffF9F9F9),
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.string(
                      googleSVG
                  ),
                  10.pw(),
                  AppText(
                    text:
                    'حساب جوجل',
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                // context.read<AuthCubit>().login(email, password);
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: 'ليس لدي حساب؟',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                AppText(
                  text: 'إنشاء حساب',
                  fontSize: 14.sp,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  // isUnderline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/robot_intro');
                    // Navigate to registration screen
                  },
                ),
              ],
            ),
            20.ph()
          ],
        ),
      )
    );
  }
}
