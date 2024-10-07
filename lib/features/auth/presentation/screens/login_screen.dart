import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            100.ph(),
            // Title
            AppText(
              text: 'تسجيل الدخول',
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            8.ph(),

            // Subtitle
            AppText(
              text: 'أدخل بياناتك للدخول إلى عالم المعرفة والتعليم',
              fontSize: 14.sp,
              color: Colors.grey,
              textAlign: TextAlign.center,
            ),
            23.ph(),

            // Email TextField
            SizedBox(
              height: 94.h,
              width: 327.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'البريد الإلكتروني',
                    fontSize: 14.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  12.ph(),
                  CustomTextField(
                    label: 'البريد الإلكتروني',
                    hintText: 'أدخل عنوان البريد الإلكتروني',
                    icon: SizedBox(),
                    controller: emailController,
                  )
                ],
              ),

            ),

            16.ph(),

            // Password TextField

            SizedBox(
              height: 94.h,
              width: 327.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'كلمة المرور',
                    fontSize: 14.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  12.ph(),
                  CustomTextField(
                    label: 'كلمة المرور',
                    hintText: 'أدخل كلمة المرور',
                    icon: Icon(Icons.lock),
                    controller: passwordController,
                    isPassword: true,
                    togglePasswordVisibility: () {
                      // context.read<AuthCubit>().togglePasswordVisibility();
                    },
                    isPasswordVisible:true,
                  )
                ],
              ),

            ),

            // CustomTextField(
            //   label: 'كلمة المرور',
            //   hintText: 'أدخل كلمة المرور',
            //   icon: Icons.lock,
            //   controller: passwordController,
            //   isPassword: true,
            //   togglePasswordVisibility: () {
            //     // context.read<AuthCubit>().togglePasswordVisibility();
            //   },
            //   isPasswordVisible:true,
            // ),
            // BlocBuilder<AuthCubit, AuthState>(
            //   builder: (context, state) {
            //     return CustomTextField(
            //       label: 'كلمة المرور',
            //       hintText: 'أدخل كلمة المرور',
            //       icon: Icons.lock,
            //       controller: passwordController,
            //       isPassword: true,
            //       togglePasswordVisibility: () {
            //         context.read<AuthCubit>().togglePasswordVisibility();
            //       },
            //       isPasswordVisible: context.read<AuthCubit>().isPasswordVisible,
            //     );
            //   },
            // ),
            12.ph(),

            // Forgot Password
            Row(
              children: [

                Align(
                  alignment: Alignment.centerRight,
                  child: AppText(
                    text: 'هل نسيت كلمة المرور؟',
                    fontSize: 14.sp,
                    color: Colors.grey,
                    onPressed: () {
                      // Handle forgot password
                    },
                  ),
                ),
              ],
            ),
            24.ph(),

            // Login Button



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

            // Or Login with Google
           Column(
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   AppText(
                     text: 'أو سجل الدخول باستخدام',
                     fontSize: 14.sp,
                     color: const Color(0xff0F172A),
                   ),
                 ],
               ),
               20.ph(),

               // Google Sign-In Button
               // GoogleSignInButton(onPressed: (){}),

               CustomButton(
                 color: Color(0xffF9F9F9),
                 widget: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.g_mobiledata, // Placeholder for Google icon
                        size: 24.sp,
                        color: Colors.black54,
                      ),
                      10.pw(),
                      Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                 ),
                 onPressed: () {
                   final email = emailController.text;
                   final password = passwordController.text;
                   // context.read<AuthCubit>().login(email, password);
                 },
               ),
             ],
           ),

            // 30.ph(),
            Spacer(),

            // Create Account Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: 'ليس لدي حساب؟',
                  fontSize: 14.sp,
                  color: Colors.black54,
                ),
                AppText(
                  text: 'إنشاء حساب',
                  fontSize: 14.sp,
                  color: Colors.blueAccent,
                  isUnderline: true,
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
