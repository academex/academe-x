import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  void _handleSubmit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('كلمات المرور غير متطابقة')),
        );
        return;
      }
      Navigator.pushNamed(context, '/edu_info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                ProgressBarWithCloseButton(
                  onClose: () => Navigator.pop(context),
                  progressValue: 0.5,
                ),
                26.ph(),
                _buildHeader(),
                30.ph(),

                _buildFormFields(context),
                30.ph(),
                _buildSubmitButton(context),
                20.ph(),
                _buildLoginOption(context),
                20.ph(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Align(
      alignment: Alignment.centerRight,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'انشاء حسابي',
              style: TextStyle(
                color: Color(0xFF001A27),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(text: ' '),
            TextSpan(
              text: '(1- البيانات الشخصية)',
              style: TextStyle(
                color: Color(0xFF001A27),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: context.localizations.nameLabel,
          hintText: context.localizations.nameHint,
          controller: nameController,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'الرجاء إدخال الاسم';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: context.localizations.emailLabel,
          hintText: context.localizations.emailHint,
          controller: emailController,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'الرجاء إدخال البريد الإلكتروني';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'البريد الإلكتروني غير صالح';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'رقم الهاتف',
          hintText: '000000000',
          controller: phoneController,
          isPhone: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء إدخال رقم الهاتف';
            }
            if (value.length != 9) {
              return 'رقم الهاتف يجب أن يتكون من 9 أرقام';
            }
            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
              return 'رقم الهاتف يجب أن يحتوي على أرقام فقط';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'الجنس',
          hintText: 'اختر الجنس',
          controller: genderController,
          isGender: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء اختيار الجنس';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<bool>(
          valueListenable: ValueNotifier<bool>(false),
          builder: (context, isPasswordVisible, _) {
            return CustomTextField(
              label: context.localizations.passwordLabel,
              hintText: context.localizations.passwordHint,
              controller: passwordController,
              isPassword: true,
              isPasswordVisible: isPasswordVisible,
              togglePasswordVisibility: () {
                (isPasswordVisible as ValueNotifier<bool>).value = !isPasswordVisible;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال كلمة المرور';
                }
                if (value.length < 8) {
                  return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
                }
                return null;
              },
            );
          },
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<bool>(
          valueListenable: ValueNotifier<bool>(false),
          builder: (context, isConfirmPasswordVisible, _) {
            return CustomTextField(
              label: context.localizations.confirmPasswordLabel,
              hintText: context.localizations.passwordHint,
              controller: confirmPasswordController,
              isPassword: true,
              isPasswordVisible: isConfirmPasswordVisible,
              togglePasswordVisibility: () {
                (isConfirmPasswordVisible as ValueNotifier<bool>).value = !isConfirmPasswordVisible;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء تأكيد كلمة المرور';
                }
                if (value != passwordController.text) {
                  return 'كلمات المرور غير متطابقة';
                }
                return null;
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return CustomButton(
      onPressed: () => _handleSubmit(context),
      widget: AppText(
        text: context.localizations.collegeLabel,
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      backgraoundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildLoginOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: context.localizations.already_have_account,
          fontSize: 14,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/login'),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppText(
              text: context.localizations.loginTitle,
              fontSize: 14,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}