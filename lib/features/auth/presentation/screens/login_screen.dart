<<<<<<< HEAD
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
=======
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
>>>>>>> 536135a (Description of changes)

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

<<<<<<< HEAD
    // Global key for form validation
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: const AppCustomAppBar(
        leading: SizedBox(), // No leading widget
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24 , right: 24 ),
        child: Form(
          key: formKey, // Assign the form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: context.localizations.loginTitle,
                fontSize: 24  ,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              8.ph(),
              AppText(
                text: context.localizations.loginSubTitle,
                fontSize: 14  ,
                color: Colors.grey,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 23,),
              CustomTextField(
                label: context.localizations.emailLabel,
                hintText: context.localizations.emailHint,
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'البريد الإلكتروني مطلوب'; // Error message for empty email
                  }
                  return null;
                },
              ),
              16.ph(),
              BlocBuilder<AuthActionCubit,bool>(
                builder: (context, isVisible) {
                  return CustomTextField(
                    label: context.localizations.passwordLabel,
                    hintText: context.localizations.passwordHint,
                    controller: passwordController,
                    isPassword: true,
                    togglePasswordVisibility: () {
                      // Logger().e('hi');
                      context.read<AuthActionCubit>().togglePasswordVisibility(isVisible: isVisible);
                    },
                    isPasswordVisible: isVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'كلمة المرور مطلوبة'; // Error message for empty password
                      }
                      return null;
                    },
                  );
                },
              ),
              12.ph(),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    side: const BorderSide(color: Color(0xffECECEC)),
                    activeColor: const Color(0xFF474CA8), // Customize the active color
                    onChanged: (bool? value) {},
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: AppText(
                      text: context.localizations.rememberMe,
                      fontSize: 14  ,
                      color: const Color(0xff232323),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/forgot_password');
                    },
                    child: AppText(
                      text: context.localizations.forgotPassword,
                      fontSize: 14  ,
                      isUnderline: true,
                      color: const Color(0xff232323),
                    ),
                  ),
                ],
              ),
              24.ph(),
              BlocConsumer<AuthenticationCubit, AuthenticationStates>(
                listener: (context, state) {
                  if (state is AuthenticationSuccessState) {
                    Navigator.pushReplacementNamed(context, '/home_screen');
                  }else if(state is AuthenticationErrorState){
                    AppLogger.d(state.message);
                    context.showSnackBar(message: state.message,error: true);
                  }

                },
                builder: (context, state) {
                  if (state is AuthenticationLoadingState) {
                    return CustomButton(
                      color: Colors.blueAccent,
                      widget: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    );
                  } else if (state is AuthenticationErrorState) {
                    return CustomButton(
                      color: Colors.blueAccent,
                      widget: AppText(
                        text: context.localizations.loginButton,
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () async {
                        // Validate the form fields before submitting
                        if (formKey.currentState!.validate()) {
                          final email = emailController.text;
                          final password = passwordController.text;
                          Navigator.pushReplacementNamed(context, '/home_screen');

                          // await context.read<AuthenticationCubit>().login(
                          //   LoginRequsetModel(username: email, password: password),
                          // );
                        } else {
                          // Show error if fields are invalid
                          context.showSnackBar(message: 'يرجى ملء جميع الحقول المطلوبة',error: true);
                        }
                      },
                    );
                  }
                  return CustomButton(
                    color: Colors.blueAccent,
                    widget: AppText(
                      text: context.localizations.loginButton,
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    onPressed: () async {
                      // Validate the form fields before submitting
                      if (formKey.currentState!.validate()) {
                        final email = emailController.text;
                        final password = passwordController.text;
                          Navigator.pushReplacementNamed(context, '/home_screen');

                        // await context.read<AuthenticationCubit>().login(
                        //   LoginRequsetModel(username: email, password: password),
                        // );
                      } else {
                        // Show error if fields are invalid
                        context.showSnackBar(message: 'يرجى ملء جميع الحقول المطلوبة',error: true);
                      }
                    },
                  );
                },
              ),
              20.ph(),
              DividerWithText(text: context.localizations.orLoginWith),
              20.ph(),
              CustomButton(
                color: const Color(0xffF9F9F9),
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.string(googleSVG),
                    10.pw(),
                    AppText(
                      text: context.localizations.googleAccount,
                      fontSize: 16 ,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                onPressed: () {},
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: context.localizations.noAccount,
                    fontSize: 14 ,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  AppText(
                    text: context.localizations.createAccount,
                    fontSize: 14 ,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    onPressed: () {
                      Navigator.pushNamed(context, '/robot_intro');
                    },
                  ),
                ],
              ),
              20.ph(),
            ],
          ),
        ),
      ),
=======
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
>>>>>>> 536135a (Description of changes)
    );
  }
}
