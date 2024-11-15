import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {


    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 24,left: 24,top: 68,bottom: 20),
        child: Form(
          key: formKey, // Assign the form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: context.localizations.loginTitle,
                color:AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              8.ph(),
              AppText(
                text: context.localizations.loginSubTitle,
                textAlign: TextAlign.center,
                color: Color(0xFF94A3B8),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              20.ph(),
              CustomTextField(
                label: context.localizations.emailLabel,
                hintText: context.localizations.emailHint,
                controller: context.read<AuthenticationCubit>().emailController,
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
                    controller:context.read<AuthenticationCubit>().passwordController
                    ,
                    isPassword: true,
                    togglePasswordVisibility: () {
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
              Row(
                children: [
                  Checkbox(
                    value: false,
                    side: const BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFFECEBEB),
                    ),
                    activeColor: const Color(0xFF474CA8), // Customize the active color
                    onChanged: (bool? value) {},
                  ),AppText(
                    text: context.localizations.rememberMe,
                    fontSize: 14  ,
                    color: Color(0xFF232323),
                    fontWeight: FontWeight.w500,
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
                      fontWeight: FontWeight.w500,
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
                      backgraoundColor: Colors.blueAccent,
                      widget: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    );
                  } else if (state is AuthenticationErrorState) {
                    return CustomButton(
                      backgraoundColor: Colors.blueAccent,
                      widget: AppText(
                        text: context.localizations.loginButton,
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () async {
                        // Validate the form fields before submitting
                        if (formKey.currentState!.validate()) {
                          final email = context.read<AuthenticationCubit>().emailController.text;
                          final password = context.read<AuthenticationCubit>().passwordController.text;

                          await context.read<AuthenticationCubit>().login(
                            LoginRequsetModel(username: email, password: password),
                          );
                        } else {
                          // Show error if fields are invalid
                          context.showSnackBar(message: 'يرجى ملء جميع الحقول المطلوبة',error: true);
                        }
                      },
                    );
                  }
                  return CustomButton(
                    backgraoundColor: Colors.blueAccent,
                    widget: AppText(
                      text: context.localizations.loginButton,
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    onPressed: () async {
                      // Validate the form fields before submitting
                      if (formKey.currentState!.validate()) {
                        final email = context.read<AuthenticationCubit>().emailController.text;
                        final password = context.read<AuthenticationCubit>().passwordController.text;

                        // Navigator.pushReplacementNamed(context, '/home_screen');

                        await context.read<AuthenticationCubit>().login(
                          LoginRequsetModel(username: email, password: password),
                        );
                      } else {
                        // Show error if fields are invalid
                        context.showSnackBar(message: 'يرجى ملء جميع الحقول المطلوبة',error: true);
                      }
                    },
                  );
                },
              ),
              24.ph(),
              DividerWithText(text: context.localizations.orLoginWith),
              24.ph(),
              CustomButton(
                backgraoundColor: Colors.white,
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.string(googleSVG),
                    10.pw(),
                    AppText(
                      text: context.localizations.googleAccount,
                      fontSize: 16 ,
                      color: Color(0xFF0F172A),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                onPressed: () {},
                wihtBorder: true,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: context.localizations.noAccount,
                    fontSize: 14 ,
                    color: Color(0xFF0F172A),
                    fontWeight: FontWeight.w500,
                  ),
                  AppText(
                    text: context.localizations.createAccount,
                    color: Color(0xFF3253FF),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    onPressed: () {
                      Navigator.pushNamed(context, '/robot_intro');
                    },
                  ),
                ],
              ),
              // 20.ph(),
            ],
          ),
        ),
      ),
    );
  }
}
