import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
// import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_size.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/utils/extensions/responsive_layout.dart';
import '../../../../core/utils/logger.dart';
import '../../../college_major/controller/cubit/college_majors_state.dart';
import '../../../college_major/data/models/major_model.dart';
import '../../data/models/response/auth_token_model.dart';
import '../../domain/entities/request/signup_request_entity.dart';
import '../../domain/entities/request/update_profile_request_entity.dart';
import '../controllers/cubits/signup_cubit.dart';
import '../controllers/states/auth_state.dart';
import '../controllers/states/college_state.dart';
import '../widgets/create_account_header.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/progress_bar_with_close_button.dart';
import '../widgets/signup/college_selection_widget.dart';
import '../widgets/signup/show_grid_view_item.dart';

class SignUpScreen extends StatelessWidget {
  final bool isEdit;
  late UpdateProfileRequestEntity user;

   SignUpScreen({super.key,required this.isEdit});

  @override
  Widget build(BuildContext context) {

    SizeConfig.init(context);

    return FutureBuilder<List<dynamic>?>(
      future: Future.wait([
        context.cachedUser,
        context.cachedMajor,
      ]),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        else{
          if(isEdit&&snapshot.hasData){
            final userData  = snapshot.data?[0] as AuthTokenModel?;
            final majorsData = snapshot.data?[1] as List<MajorModel>;

            return MultiBlocProvider(
              providers: [
                BlocProvider(
                create: (context) {
              final signupCubit = getIt<SignupCubit>();

              signupCubit.state.firstNameController!.text = userData ?.user.firstName ?? '';
              signupCubit.state.lastNameController!.text = userData ?.user.lastName ?? '';
              signupCubit.state.userNameController!.text = userData ?.user.username ?? '';
              signupCubit.state.photoUrl= userData ?.user.photoUrl ?? '';
              signupCubit.state.emailController!.text = userData ?.user.email ?? '';
              signupCubit.state.bioController!.text = userData ?.user.bio ?? '';
              signupCubit.state.selectedSemesterIndex = (userData !.user.currentYear!-1);
              signupCubit.state.selectedTagId =userData.user.tagId;
             user = UpdateProfileRequestEntity(
                firstName: userData.user.firstName ?? '',
                lastName:  userData.user.lastName ?? '',
                username:  userData.user.username ?? '',
               email:  userData.user.email ?? '',
               bio:  userData.user.bio ?? '',
               currentYear:  userData.user.currentYear ?? 0,
                tagId: userData.user.tagId ?? 0,
              );
              return signupCubit;
            },),
                BlocProvider(
                  create: (context) {
                    final collegeMajorCubit = getIt<CollegeMajorsCubit>()..getColleges();
                    // Find and set the user's major
                    final userMajor = majorsData.firstWhere(
                          (major) => major.id == userData?.user.tagId,
                      orElse: () => majorsData.first,
                    );



                    // AppLogger.success(
                    //
                    // );



                  collegeMajorCubit.selectCollege(userMajor.collegeEn!);
                  collegeMajorCubit.state.selectedCollege =userMajor.collegeEn!;
                  collegeMajorCubit.state.collegeAndMajor ="${userMajor.collegeEn!} (${userMajor.name}) ";
                  collegeMajorCubit.state.selectedMajorIndex = majorsData.indexOf(userMajor);


                    return collegeMajorCubit;
                  },
                )
              ],
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
          else{
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
        }


      },
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
              CreateAccountHeader(step: state.showEducationInfo! ? 2 : 1,isEdit:isEdit),
              SizedBox(height: context.hp(4)),
              if (!state.showEducationInfo!) ...[
                _buildPersonalInfoFields(ctx, state,isEdit: isEdit),
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
                  onPressed: () => _handleEducationInfoSubmit(ctx,state,collegeMajorState: ctx.read<CollegeMajorsCubit>().state),
                  text: context.localizations.createAccountButton,
                ),
              ],
              SizedBox(height: context.hp(state.showEducationInfo! ? 6 : 2)),
              isEdit? 0.ph(): _buildLoginOption(context),
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
                CreateAccountHeader(step: state.showEducationInfo! ? 2 : 1,isEdit: isEdit,),
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
                    _buildPersonalInfoFields(context, state,isEdit: isEdit),
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
                      onPressed: () => _handleEducationInfoSubmit(ctx,state,collegeMajorState: ctx.read<CollegeMajorsCubit>().state),
                      text: context.localizations.createAccountButton,
                    ),
                  ],
                  SizedBox(height: context.hp(4)),
                  isEdit? 0.ph():_buildLoginOption(context),
                ],
              ),
            )
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoFields(BuildContext context, AuthState state,{required bool isEdit}) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: 'الاسم الأول',
                hintText: 'أدخل اسمك الأول',
                controller: state.firstNameController!,
                validator: isEdit? null: FormValidators.validateName,
              ),
            ),
            17.pw(), // Horizontal spacing between fields
            Expanded(
              child: CustomTextField(
                label: 'الاسم الأخير',
                hintText: 'أدخل اسمك الأخير',
                controller:state.lastNameController!,
                validator:isEdit? null: FormValidators.validateName,
              ),
            ),
          ],
        ),
         CustomTextField(
          label: 'اسم المستخدم',
          hintText: 'اكتب اسم المستخدم',
          controller: state.userNameController!,

          validator: FormValidators.validateUsername,
        ),
        CustomTextField(
          label: context.localizations.emailLabel,
          hintText: context.localizations.emailHint,
          controller: state.emailController!,
          validator: isEdit? null:FormValidators.validateEmail,
        ),
        isEdit? 0.ph(): CustomTextField(
          label: 'رقم الهاتف',
          hintText: '000000000',
          controller: state.phoneController!,
          isPhone: true,
          validator: FormValidators.validatePhone,
        ),
        isEdit? 0.ph():   Column(
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
                      ].length ).ceil();
                double gridHeight = rowCount * itemHeight;

                return SizedBox(
                  height: gridHeight,
                  child: ShowGridViewItem<String>(
                    crossAxisCount: 2,
                    data:const [
                            'ذكر',
                            'أنثى',
                          ],
                    onTap: (index,string) {
                      context.read<SignupCubit>().selectGenderIndex(index: index);
                      },
                    selectedIndex:state.selectedGenderIndex,
                    displayTextBuilder: (p0) => p0,
                  ),
                );
              },
            )

          ],
        ),
        16.ph(),
        isEdit? 0.ph():  _buildPasswordFields(state,context),
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
      validator:isEdit? null: FormValidators.validatePassword,
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
          validator:isEdit? null: (p0) =>FormValidators.validateConfirmPassword(p0,  state.passwordController!.text)
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
                    child: ShowGridViewItem<String>(
                      crossAxisCount: crossAxisCount,
                      data:const [
                        'أولى',
                        'ثانية',
                        'ثالتة',
                        'رابعة',
                      ],
                      onTap: (index,string) {

                        context.read<SignupCubit>().selectIndex(
                            index: index,
                            selectionType: SelectionType.semester
                        );
                      },
                      selectedIndex:state.selectedSemesterIndex,
                      displayTextBuilder: (p0) => p0,
                    ),
                  );
                },
              )

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
    return BlocConsumer<SignupCubit, AuthState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          context.showSnackBar(message: state.errorMessage![0], error: true,);
        }else if(state.isAuthenticated){
          context.go('/account_creation');
        }else if(state.isUpdated){
          context.showSnackBar(
            message: 'تم تحديث البيانات بنجاح',
          );
          context.go('/home_screen');
        }
      },
      // listenWhen: (previous, current) => current.errorMessage !=previous.errorMessage,
      builder: (context, state) {
        Widget buttonChild;
        if (state.isLoading) {
          buttonChild = const CircularProgressIndicator(color: Colors.white);
        } else {
          buttonChild = AppText(
            text:isEdit? 'تحديث': text,
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
          onTap: () => context.pushNamed('/login'),
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

  void _handleEducationInfoSubmit(BuildContext context,AuthState state,{CollegeMajorsState? collegeMajorState}) async{
    if (collegeMajorState?.selectedCollege == null) {
      context.showSnackBar(
        message: 'الرجاء اختيار الكلية',
        error: true,
      );
      return;
    }

    if (collegeMajorState?.selectedMajorIndex == null) {
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
    SignupRequestEntity newUser = SignupRequestEntity(
      firstName: state.firstNameController!.text.trim(),
      lastName: state.lastNameController!.text.trim(),
      username: state.userNameController!.text.trim(),
      email: state.emailController!.text.trim(),
      phoneNum: '+972${state.phoneController!.text.trim()}',
      gender: state.selectedGenderIndex == 0 ? "MALE" : "FEMALE",
      password: state.passwordController!.text,
      currentYear: state.selectedSemesterIndex! + 1,
      tagId: state.selectedTagId!,
    );

    if(isEdit){

      if(user.toChangedFieldsMap(state).isEmpty){
        context.showSnackBar(
          message: 'لا يوجد تغييرات',
          error: true,
        );
        return;
      }
     await context.read<SignupCubit>().updateProfile(user.toChangedFieldsMap(state),context);

    }else{
     await context.read<SignupCubit>().signup(newUser);
    }

  }
}

