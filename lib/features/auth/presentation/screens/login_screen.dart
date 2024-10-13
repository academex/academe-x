import 'package:academe_x/core/const/app_robot.dart';
import 'package:academe_x/core/extensions/context_extenssion.dart';
import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/features/auth/presentation/widgets/divider_with_text.dart';
import 'package:academe_x/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import '../cubit/auth_cubit.dart';
import '../../../../core/widgets/app_custom_appBar_widget.dart';
import '../../../../core/widgets/app_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppCustomAppBar(
        leading: const SizedBox(), // No leading widget
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24.w,right:  24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: context.localizations.loginTitle,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            8.ph(),
            AppText(
              text: context.localizations.loginSubTitle,
              fontSize: 14.sp,
              color: Colors.grey,
              textAlign: TextAlign.center,
            ),
            23.ph(),
            CustomTextField(
              label:context.localizations.emailLabel,
              hintText: context.localizations.emailHint,
              controller: emailController,
            ),
            16.ph(),
            CustomTextField(
              label:context.localizations.passwordLabel,

              hintText: context.localizations.passwordHint,
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
                  text: context.localizations.rememberMe,
                  fontSize: 14.sp,
                  color: Color(0xff232323),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/forgot_password');
                },
                child: AppText(
                  text:context.localizations.forgotPassword,
                  fontSize: 14.sp,
                  isUnderline: true,
                  color: const Color(0xff232323),
                ),
              ),
            ],
          ),
            24.ph(),
            CustomButton(
              color: Colors.blueAccent,
              widget: AppText(
                text: context.localizations.loginButton,
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              onPressed: () {
                // final email = emailController.text;
                // final password = passwordController.text;
                Navigator.pushNamed(context, '/community_screen');
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
            DividerWithText(text: context.localizations.orLoginWith),
            20.ph(),

            // Google Sign-In Button
            // GoogleSignInButton(onPressed: (){}),

            CustomButton(
              color: const Color(0xffF9F9F9),
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.string(
                      googleSVG
                  ),
                  10.pw(),
                  AppText(
                    text:
                    context.localizations.googleAccount,
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              onPressed: () {
                // final email = emailController.text;
                // final password = passwordController.text;



                // context.read<AuthCubit>().login(email, password);
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: context.localizations.noAccount,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                AppText(
                  text: context.localizations.createAccount,
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
