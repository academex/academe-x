import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  GlobalKey<FormState>? formKey= GlobalKey();
   final TextEditingController emailController=TextEditingController();
   final TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: ResponsiveLayout(
          mobile: _buildMobileLayout(context),
          tablet: _buildTabletLayout(context),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.wp(6),
          vertical: context.hp(4),
        ),
        child: Form(
          key:formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: context.hp(2.5)),
              _buildLoginForm(context,),
              SizedBox(height: context.hp(3)),
              _buildSocialLogin(context),
              SizedBox(height: context.hp(3)),
              _buildSignUpOption(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              padding: EdgeInsets.all(context.wp(4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add your logo or illustration here
                  Image.asset(AppAssets.appLogo, height: context.hp(20)),
                  SizedBox(height: context.hp(4)),
                  _buildHeader(context),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(context.wp(4)),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: context.hp(8)),
                    _buildLoginForm(context,),
                    SizedBox(height: context.hp(4)),
                    _buildSocialLogin(context),
                    SizedBox(height: context.hp(4)),
                    _buildSignUpOption(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: context.localizations.loginTitle,
          color: AppColors.textPrimary,
          fontSize: context.isTablet ? 26 : 22,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: context.hp(1)),
        AppText(
          text: context.localizations.loginSubTitle,
          color: const Color(0xFF94A3B8),
          fontSize: context.isTablet ? 16 : 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: context.localizations.emailLabel,
          hintText: context.localizations.emailHint,
          controller:emailController,
          validator: (value) => value?.isEmpty ?? true ? 'البريد الإلكتروني مطلوب' : null,
        ),
        SizedBox(height: context.hp(2)),
        BlocBuilder<LoginCubit,AuthState>(
          builder: (context, state) => CustomTextField(
            label: context.localizations.passwordLabel,
            hintText: context.localizations.passwordHint,
            controller:passwordController,
            isPassword: true,
            togglePasswordVisibility: () {

              context.read<LoginCubit>().togglePasswordVisibility();
            },
            isPasswordVisible: state.isPasswordVisible,
            validator: (value) => value?.isEmpty ?? true ? 'كلمة المرور مطلوبة' : null,
          ),
        ),
        _buildRememberMeRow(context),
        SizedBox(height: context.hp(3)),
        _buildLoginButton(context),
      ],
    );
  }

  Widget _buildRememberMeRow(BuildContext context) {
    return BlocBuilder<LoginCubit,AuthState>(
      builder: (context, state) => Padding(
        padding: EdgeInsets.symmetric(vertical: context.hp(2)),
        child: Row(
          children: [
            SizedBox(
              height: context.isTablet ? 24 : 20,
              width: context.isTablet ? 24 : 20,
              child: Checkbox(
                value: state.isRememberMe,
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFFECEBEB),
                ),
                activeColor: const Color(0xFF474CA8),
                onChanged: (bool? value) {
                  context.read<LoginCubit>().checkRememberMe();
                },
              ),
            ),
            SizedBox(width: context.wp(2)),
            AppText(
              text: context.localizations.rememberMe,
              fontSize: context.isTablet ? 16 : 14,
              color: const Color(0xFF232323),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => context.pushNamed( '/forgot_password'),
              child: AppText(
                text: context.localizations.forgotPassword,
                fontSize: context.isTablet ? 16 : 14,
                isUnderline: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return BlocConsumer<LoginCubit, AuthState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          context.showSnackBar(message: state.errorMessage![0], error: true);
        }else if(state.isAuthenticated){
          context.go('/home_screen');
        }
      },
      builder: (context, state) {
        Widget buttonChild;
        if (state.isLoading) {
          buttonChild = const CircularProgressIndicator(color: Colors.white);
        } else {
          buttonChild = AppText(
            text: context.localizations.loginButton,
            fontSize: context.isTablet ? 18 : 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          );
        }

        return CustomButton(
          backgraoundColor: Colors.blueAccent,
          widget: buttonChild,
          onPressed: () => _handleLogin(context, state),
        );
      },
    );
  }

  Future<void> _handleLogin(BuildContext context,AuthState state) async {
    if (formKey!.currentState?.validate() ?? false) {
      final email = emailController.text;
      final password =passwordController.text;
      await context.read<LoginCubit>().login(
        LoginRequsetModel(username: email, password: password),
      );
    } else {
      context.showSnackBar(message: 'يرجى ملء جميع الحقول المطلوبة', error: true);
    }
  }

  Widget _buildSocialLogin(BuildContext context) {
    return Column(
      children: [
        DividerWithText(text: context.localizations.orLoginWith),
        SizedBox(height: context.hp(3)),
        CustomButton(
          backgraoundColor: Colors.white,
          wihtBorder: true,
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.string(googleSVG),
              SizedBox(width: context.wp(2)),
              AppText(
                text: context.localizations.googleAccount,
                fontSize: context.isTablet ? 18 : 16,
                color: const Color(0xFF0F172A),
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSignUpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: context.localizations.noAccount,
          fontSize: context.isTablet ? 16 : 14,
          color: const Color(0xFF0F172A),
        ),
        AppText(
          text: context.localizations.createAccount,
          color: const Color(0xFF3253FF),
          fontSize: context.isTablet ? 18 : 16,
          fontWeight: FontWeight.w600,
          onPressed: () => context.pushNamed('/robot_intro'),
        ),
      ],
    );
  }
}