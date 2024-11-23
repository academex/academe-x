import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocProvider(
      create: (context) => getIt<SignupCubit>(),
      child: BlocBuilder<SignupCubit, AuthState>(
        builder: (ctx, state) {
          return PopScope(
            canPop: state.showEducationInfo! ? false : true,
            onPopInvokedWithResult: (didPop, result) {
              if (state.showEducationInfo!) {
                ctx.read<SignupCubit>().showEduInfo(state.showEducationInfo!);
              }
            },
            child: Scaffold(
              body: ResponsiveLayout(
                mobile: _buildMobileLayout(context, state, ctx),
                tablet: _buildTabletLayout(context, state, ctx),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildMobileLayout(
      BuildContext context, AuthState state, BuildContext ctx) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.wp(6), // 6% of screen width
        vertical: context.hp(2), // 2% of screen height
      ),
      child: Form(
          key: state.formKey,
          child: Column(
            children: [
              ProgressBarWithCloseButton(
                onTap: () {
                  if (state.showEducationInfo!) {
                    ctx
                        .read<SignupCubit>()
                        .showEduInfo(state.showEducationInfo!);
                  } else {
                    Navigator.pop(context);
                  }
                },
                isBack: state.showEducationInfo!,
                progressValue: state.showEducationInfo! ? 1.0 : 0.5,
              ),
              SizedBox(height: context.hp(3)),
              CreateAccountHeader(step: state.showEducationInfo! ? 2 : 1),
              SizedBox(height: context.hp(4)),
              if (!state.showEducationInfo!) ...[
                _buildPersonalInfoFields(ctx, state),
                SizedBox(height: context.hp(2)),
                _buildSubmitButton(
                  context,
                  onPressed: () => _handlePersonalInfoSubmit(state, ctx),
                  text: context.localizations.collegeLabel,
                ),
              ]
              else ...[
                _buildEducationInfoFields(ctx,state),
                SizedBox(height: context.hp(2.5)),
                _buildSubmitButton(
                  context,
                  onPressed: () => _handleEducationInfoSubmit(ctx,state),
                  text: context.localizations.createAccountButton,
                ),
              ],
              SizedBox(height: context.hp(state.showEducationInfo! ? 6 : 2)),
              _buildLoginOption(context),
            ],
          )),
    ));
  }

  Widget _buildTabletLayout(
      BuildContext context, AuthState state, BuildContext ctx) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: SafeArea(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wp(4),    vertical: context.hp(4), ),
            child: Column(
              children: [
                ProgressBarWithCloseButton(
                  onTap: () {
                    if (state.showEducationInfo!) {
                      ctx
                          .read<SignupCubit>()
                          .showEduInfo(state.showEducationInfo!);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  isBack: state.showEducationInfo!,
                  progressValue: state.showEducationInfo! ? 1.0 : 0.5,
                ),
                SizedBox(height: context.hp(4)),
                CreateAccountHeader(step: state.showEducationInfo! ? 2 : 1),
              ],
            ),
          ),)
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wp(4),    vertical: context.hp(4), ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (!state.showEducationInfo!) ...[
                    _buildPersonalInfoFields(context, state),
                    SizedBox(height: context.hp(3)),
                    _buildSubmitButton(
                      context,
                      onPressed: () => _handlePersonalInfoSubmit(state, ctx),
                      text: context.localizations.collegeLabel,
                    ),
                  ] else ...[
                    _buildEducationInfoFields(context,state),
                    SizedBox(height: context.hp(3)),
                    _buildSubmitButton(
                      context,
                      onPressed: () => _handleEducationInfoSubmit(ctx,state),
                      text: context.localizations.createAccountButton,
                    ),
                  ],
                  SizedBox(height: context.hp(4)),
                  _buildLoginOption(context),
                ],
              ),
            )
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoFields(BuildContext context, AuthState state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: 'الاسم الأول',
                hintText: 'أدخل اسمك الأول',
                controller: state.firstNameController!,
                // validator: FormValidators.validateName,
              ),
            ),
            17.pw(), // Horizontal spacing between fields
            Expanded(
              child: CustomTextField(
                label: 'الاسم الأخير',
                hintText: 'أدخل اسمك الأخير',
                controller:state.lastNameController!,
                // validator: FormValidators.validateName,
              ),
            ),
          ],
        ),
        CustomTextField(
          label: 'اسم المستخدم',
          hintText: 'اكتب اسم المستخدم',
          controller: state.userNameController!,
          // validator: FormValidators.validateUsername,
        ),
        CustomTextField(
          label: context.localizations.emailLabel,
          hintText: context.localizations.emailHint,
          controller: state.emailController!,
          // validator: FormValidators.validateEmail,
        ),
        CustomTextField(
          label: 'رقم الهاتف',
          hintText: '000000000',
          controller: state.phoneController!,
          isPhone: true,
          // validator: FormValidators.validatePhone,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: 'الجنس', fontSize: 14),
            16.ph(),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = SizeConfig().getCrossAxisCount(context,lengthOfList: 2);
                double itemHeight = SizeConfig().getItemHeight(context);
                int rowCount = ( [
                        'ذكر',
                        'أنثى',
                      ].length / crossAxisCount).ceil();
                double gridHeight = rowCount * itemHeight;

                return SizedBox(
                  height: gridHeight,
                  child: ShowGridViewItem(
                    crossAxisCount: 2,
                    data:const [
                            'ذكر',
                            'أنثى',
                          ],
                    onTap: (index) {
                      AppLogger.success(index.toString());
                      context.read<SignupCubit>().selectGenderIndex(index: index);
                      },
                    selectedIndex:state.selectedGenderIndex,
                  ),
                );
              },
            )

          ],
        ),
        16.ph(),
        _buildPasswordFields(state,context),
      ],
    );
  }

  Widget _buildPasswordFields(AuthState state,BuildContext context) {
    return Column(
      children: [
    CustomTextField(
    label: context.localizations.passwordLabel,
      hintText: context.localizations.passwordHint,
      controller:state.passwordController!,
      isPassword: true,
      isPasswordVisible: state.isPasswordVisible,
      togglePasswordVisibility: () {
      context.read<SignupCubit>().togglePasswordVisibility();
      },
      // validator: FormValidators.validatePassword,
    ),
        CustomTextField(
          label: context.localizations.confirmPasswordLabel,
          hintText: context.localizations.passwordHint,
          controller:state.confirmPasswordController!,
          isPassword: true,
          isPasswordVisible: state.isPasswordVisible,
          togglePasswordVisibility: () {
            context.read<SignupCubit>().togglePasswordVisibility();
          },
          // validator: (p0) =>FormValidators.validateConfirmPassword(p0,  state.passwordController!.text)
          // ,
        ),
      ],
    );
  }

  Widget _buildEducationInfoFields(BuildContext context,AuthState state) {
    return  Column(
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
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = SizeConfig().getCrossAxisCount(context);
                  double itemHeight = SizeConfig().getItemHeight(context);
                  int rowCount = ([
                    'أولى',
                    'ثانية',
                    'ثالتة',
                    'رابعة',
                  ].length / crossAxisCount).ceil();
                  double gridHeight = rowCount * itemHeight;
                  return SizedBox(
                    height: gridHeight,
                    child: ShowGridViewItem(
                      crossAxisCount: crossAxisCount,
                      data:const [
                        'أولى',
                        'ثانية',
                        'ثالتة',
                        'رابعة',
                      ],
                      onTap: (index) {
                        AppLogger.success(index.toString());

                        context.read<SignupCubit>().selectIndex(
                            index: index,
                            selectionType: SelectionType.semester
                        );
                      },
                      selectedIndex:state.selectedSemesterIndex,
                    ),
                  );
                },
              )
              // SizedBox(
              //     height: 60,
              //     child: ShowGridViewItem(
              //       data: const [
              //         'أولى',
              //         'ثانية',
              //         'ثالتة',
              //         'رابعة',
              //       ],
              //       onTap: (index) {
              //         context
              //             .read<CollegeCubit>()
              //             .selectIndex(index: index,selectionType: SelectionType.semester);
              //       },
              //       selectedIndex: state.selectedSemesterIndex,
              //     ))
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSubmitButton(
    BuildContext context, {
    required VoidCallback onPressed,
    required String text,
  }) {

    // CustomButton(
    //   onPressed: onPressed,
    //   widget: AppText(
    //     text: text,
    //     fontSize: 14,
    //     color: Colors.white,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   backgraoundColor: Theme.of(context).primaryColor,
    // );

    return BlocConsumer<SignupCubit, AuthState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          context.showSnackBar(message: state.errorMessage![0], error: true,);
        }else if(state.isAuthenticated){
          Navigator.pushReplacementNamed(context, '/account_creation');
        }
      },
      // listenWhen: (previous, current) => current.errorMessage !=previous.errorMessage,
      builder: (context, state) {
        Widget buttonChild;
        if (state.isLoading) {
          buttonChild = const CircularProgressIndicator(color: Colors.white);
        } else {
          buttonChild = AppText(
            text: text,
            fontSize: context.isTablet ? 18 : 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          );
        }

        return CustomButton(
          onPressed: onPressed,
          widget: buttonChild,
          backgraoundColor: Theme.of(context).primaryColor,
        );

        // return CustomButton(
        //   backgraoundColor: Colors.blueAccent,
        //   widget: buttonChild,
        //   onPressed: () => _handleLogin(context, state),
        // );
      },
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

  void _handlePersonalInfoSubmit(AuthState state, BuildContext context) {
    if (state.formKey!.currentState!.validate()) {
      if (state.selectedGenderIndex == null) {
        context.showSnackBar(
          message: 'الرجاء اختيار الجنس',
          error: true,
        );
        return;
      }
    context.read<SignupCubit>().showEduInfo(state.showEducationInfo!);
    }
  }

  void _handleEducationInfoSubmit(BuildContext context,AuthState state) async{
    if (state.selectedCollege == null) {
      context.showSnackBar(
        message: 'الرجاء اختيار الكلية',
        error: true,
      );
      return;
    }

    if (state.selectedMajorIndex == null) {
      context.showSnackBar(
        message: 'الرجاء اختيار التخصص',
        error: true,
      );
      return;
    }

    if (state.selectedSemesterIndex == null) {
      context.showSnackBar(
        message: 'الرجاء اختيار السنة الدراسية',
        error: true,
      );
      return;
    }
    SignupRequestEntity user = SignupRequestEntity(
      firstName: state.firstNameController!.text.trim(),
      lastName: state.lastNameController!.text.trim(),
      username: state.userNameController!.text.trim(),
      email: state.emailController!.text.trim(),
      phoneNum: '+972${state.phoneController!.text.trim()}',
      gender: state.selectedGenderIndex == 0 ? "MALE" : "FEMALE",
      password: state.passwordController!.text,
      currentYear: state.selectedSemesterIndex! + 1,
      tagId: 1,
    );

    await context.read<SignupCubit>().signup(user);
    // Navigator.pushNamed(context, '/account_creation');
  }
}

