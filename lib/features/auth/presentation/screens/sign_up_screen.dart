import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/signup/college_selection_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  void _handlePersonalInfoSubmit(SignupState state, BuildContext context) {
    // if (true) {
    //   if (state.passwordController!.text != state.confirmPasswordController!.text) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('كلمات المرور غير متطابقة')),
    //     );
    //     return;
    //   }
    //
    //
    // }
    context.read<SignupCubit>().showEduInfo(state.showEducationInfo!);
  }

  void _handleEducationInfoSubmit() {
    Navigator.pushNamed(context, '/account_creation');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit()..initData(),
      child: BlocBuilder<SignupCubit, SignupState>(
        builder: (ctx, state) => PopScope(
            canPop: state.showEducationInfo! ? false : true,
            onPopInvokedWithResult: (didPop, result) {
              if(state.showEducationInfo!){
                AppLogger.success('in Pop');
                AppLogger.success(state.showEducationInfo!.toString());
                ctx
                    .read<SignupCubit>()
                    .showEduInfo(state.showEducationInfo!);
              }
            },
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Form(
                    key: state.formKey,
                    child: Column(
                      children: [
                        ProgressBarWithCloseButton(
                          onTap: () {
                            AppLogger.success('message');
                            if (state.showEducationInfo!) {
                              ctx
                                  .read<SignupCubit>()
                                  .showEduInfo(state.showEducationInfo!);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          isBack: state.showEducationInfo! ? true : false,
                          progressValue: state.showEducationInfo! ? 1.0 : 0.5,
                        ),
                        26.ph(),
                        CreateAccountHeader(
                          step: state.showEducationInfo! ? 2 : 1,
                        ),
                        30.ph(),
                        if (!state.showEducationInfo!) ...[
                          _buildPersonalInfoFields(context, state),
                          16.ph(),
                          _buildSubmitButton(
                            context,
                            onPressed: () {
                              _handlePersonalInfoSubmit(state, ctx);
                            },
                            text: context.localizations.collegeLabel,
                          ),
                          16.ph(),
                        ] else ...[
                          _buildEducationInfoFields(),
                          20.ph(),
                          _buildSubmitButton(
                            context,
                            onPressed: _handleEducationInfoSubmit,
                            text: context.localizations.createAccountButton,
                          ),
                        ],
                        if (state.showEducationInfo!) ...[
                          50.ph(),
                          _buildLoginOption(context)
                        ] else ...[
                          _buildLoginOption(context)
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget _buildPersonalInfoFields(BuildContext context, SignupState state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: 'الاسم الأول',
                hintText: 'أدخل اسمك الأول',
                controller: state.nameController!,
              ),
            ),
            17.pw(), // Horizontal spacing between fields
            Expanded(
              child: CustomTextField(
                label: 'الاسم الأخير',
                hintText: 'أدخل اسمك الأخير',
                controller:
                    TextEditingController(), // Create new controller for last name
              ),
            ),
          ],
        ),
        CustomTextField(
          label: 'اسم المستخدم',
          hintText: 'اكتب اسم المستخدم',
          controller: state.emailController!,
        ),
        CustomTextField(
          label: context.localizations.emailLabel,
          hintText: context.localizations.emailHint,
          controller: state.emailController!,
        ),
        CustomTextField(
          label: 'رقم الهاتف',
          hintText: '000000000',
          controller: state.phoneController!,
          isPhone: true,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: 'الجنس', fontSize: 14),
            16.ph(),
            SizedBox(
                height: 60,
                child: ShowGridViewItem(
                  data: const [
                    'ذكر',
                    'أنثى',
                  ],
                  onTap: (index) {
                    // context.read<CollegeCubit>().selectIndex(index,SelectionType.semester);
                  },
                ))
          ],
        ),
        // SelectionDropDown(
        //   title: 'الجنس',
        //   options: ['ذكر', 'انثى'],
        //   selectedOption: 'ذكر',
        //   onSelected: (value) => setState(() => selectedGender = value),
        //   isTerm: true,
        // ),
        16.ph(),
        _buildPasswordFields(state),
      ],
    );
  }

  Widget _buildPasswordFields(SignupState state) {
    return Column(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: ValueNotifier<bool>(false),
          builder: (context, isPasswordVisible, _) {
            return CustomTextField(
              label: context.localizations.passwordLabel,
              hintText: context.localizations.passwordHint,
              controller: state.passwordController!,
              isPassword: true,
              isPasswordVisible: isPasswordVisible,
              togglePasswordVisibility: () {
                (isPasswordVisible as ValueNotifier<bool>).value =
                    !isPasswordVisible;
              },
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: ValueNotifier<bool>(false),
          builder: (context, isConfirmPasswordVisible, _) {
            return CustomTextField(
              label: context.localizations.confirmPasswordLabel,
              hintText: context.localizations.passwordHint,
              controller: state.confirmPasswordController!,
              isPassword: true,
              isPasswordVisible: isConfirmPasswordVisible,
              togglePasswordVisibility: () {
                (isConfirmPasswordVisible as ValueNotifier<bool>).value =
                    !isConfirmPasswordVisible;
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildEducationInfoFields() {
    return BlocProvider<CollegeCubit>(
        create: (context) => CollegeCubit(),
        child: BlocBuilder<CollegeCubit, CollegeState>(
          builder: (context, state) => Column(
            children: [
              CollegeSelectionWidget(
                ctx: context,
              ),
              16.ph(),
              SizedBox(
                height: 98,
                // width: 326,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: 'سنة الدراسة الحالية ', fontSize: 14),
                    16.ph(),
                    SizedBox(
                        height: 60,
                        child: ShowGridViewItem(
                          data: const [
                            'أولى',
                            'ثانية',
                            'ثالتة',
                            'رابعة',
                          ],
                          onTap: (index) {
                            context
                                .read<CollegeCubit>()
                                .selectIndex(index, SelectionType.semester);
                          },
                          selectedIndex: state.selectedSemesterIndex,
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildSubmitButton(
    BuildContext context, {
    required VoidCallback onPressed,
    required String text,
  }) {
    return CustomButton(
      onPressed: onPressed,
      widget: AppText(
        text: text,
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
