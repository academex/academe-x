import 'package:academe_x/core/const/app_robot.dart';
import 'package:academe_x/core/extensions/context_extenssion.dart';
import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/features/auth/data/models/requset/login_requset_model.dart';
import 'package:academe_x/features/auth/presentation/controllers/cubits/authentication_cubit.dart';
import 'package:academe_x/features/auth/presentation/controllers/states/authentication_states.dart';
import 'package:academe_x/features/auth/presentation/widgets/divider_with_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import '../../../../core/widgets/app_custom_appBar_widget.dart';
import '../../../../core/widgets/app_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';





class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    // Global key for form validation
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: const AppCustomAppBar(
        leading: SizedBox(), // No leading widget
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: Form(
          key: formKey, // Assign the form key
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
                      fontSize: 14.sp,
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
                      fontSize: 14.sp,
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
                    Logger().d(state.message);
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
                        fontSize: 16.sp,
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
                      fontSize: 16.sp,
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
                      fontSize: 16.sp,
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
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  AppText(
                    text: context.localizations.createAccount,
                    fontSize: 14.sp,
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
    );
  }
}
