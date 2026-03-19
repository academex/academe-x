import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

class SignUpScreen extends StatefulWidget {
  final bool isEdit;

  const SignUpScreen({super.key, required this.isEdit});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final Future<List<dynamic>?> _cachedDataFuture;
  UpdateProfileRequestEntity? _originalUser;

  @override
  void initState() {
    super.initState();
    _cachedDataFuture = Future.wait([
      context.cachedUser,
      context.cachedMajor,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isEdit) {
      return _buildWithProviders(
        signupCubit: getIt<SignupCubit>(),
      );
    }

    return FutureBuilder<List<dynamic>?>(
      future: _cachedDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return _buildWithProviders(
            signupCubit: getIt<SignupCubit>(),
          );
        }

        final userData = snapshot.data?[0] as AuthTokenModel?;
        final majorsData = snapshot.data?[1] as List<MajorModel>?;

        final signupCubit = getIt<SignupCubit>();
        _populateEditData(signupCubit, userData);

        final collegeMajorCubit = getIt<CollegeMajorsCubit>()..getColleges();
        _populateCollegeData(collegeMajorCubit, userData, majorsData);

        return _buildWithProviders(
          signupCubit: signupCubit,
          collegeMajorCubit: collegeMajorCubit,
        );
      },
    );
  }

  void _populateEditData(SignupCubit cubit, AuthTokenModel? userData) {
    if (userData == null) return;

    final user = userData.user;
    cubit.state.firstNameController?.text = user.firstName;
    cubit.state.lastNameController?.text = user.lastName;
    cubit.state.userNameController?.text = user.username;
    cubit.state.photoUrl = user.photoUrl ?? '';
    cubit.state.emailController?.text = user.email ?? '';
    cubit.state.bioController?.text = user.bio ?? '';
    cubit.state.selectedSemesterIndex = (user.currentYear ?? 1) - 1;
    cubit.state.selectedTagId = user.tagId;

    _originalUser = UpdateProfileRequestEntity(
      firstName: user.firstName,
      lastName: user.lastName,
      username: user.username,
      email: user.email ?? '',
      bio: user.bio ?? '',
      currentYear: user.currentYear ?? 0,
      tagId: user.tagId ?? 0,
    );
  }

  void _populateCollegeData(
    CollegeMajorsCubit cubit,
    AuthTokenModel? userData,
    List<MajorModel>? majorsData,
  ) {
    if (userData == null || majorsData == null || majorsData.isEmpty) return;

    final userMajor = majorsData.firstWhere(
      (major) => major.id == userData.user.tagId,
      orElse: () => majorsData.first,
    );

    if (userMajor.collegeEn != null) {
      cubit.selectCollege(userMajor.collegeEn!);
      cubit.state.selectedCollege = userMajor.collegeEn!;
      cubit.state.collegeAndMajor = '${userMajor.collegeEn!} (${userMajor.name}) ';
      cubit.state.selectedMajorIndex = majorsData.indexOf(userMajor);
    }
  }

  Widget _buildWithProviders({
    required SignupCubit signupCubit,
    CollegeMajorsCubit? collegeMajorCubit,
  }) {
    final providers = <BlocProvider>[
      BlocProvider<SignupCubit>(create: (_) => signupCubit),
      if (collegeMajorCubit != null)
        BlocProvider<CollegeMajorsCubit>(create: (_) => collegeMajorCubit),
    ];

    return MultiBlocProvider(
      providers: providers,
      child: BlocBuilder<SignupCubit, AuthState>(
        builder: (ctx, state) {
          final showEdu = state.showEducationInfo ?? false;
          return PopScope(
            canPop: !showEdu,
            onPopInvokedWithResult: (didPop, result) {
              if (showEdu) {
                ctx.read<SignupCubit>().showEduInfo(showEdu);
              }
            },
            child: Scaffold(
              body: ResponsiveLayout(
                mobile: _buildMobileLayout(ctx, state),
                tablet: _buildTabletLayout(ctx, state),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, AuthState state) {
    final showEdu = state.showEducationInfo ?? false;
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.wp(6),
          vertical: context.hp(2),
        ),
        child: Form(
          key: state.formKey,
          child: Column(
            children: [
              _buildProgressBar(context, state),
              SizedBox(height: context.hp(3)),
              CreateAccountHeader(step: showEdu ? 2 : 1, isEdit: widget.isEdit),
              SizedBox(height: context.hp(4)),
              if (!showEdu) ...[
                _buildPersonalInfoFields(context, state),
                SizedBox(height: context.hp(2)),
                _buildSubmitButton(
                  context,
                  onPressed: () => _handlePersonalInfoSubmit(state, context),
                  text: context.localizations.collegeLabel,
                ),
              ] else ...[
                _buildEducationInfoFields(context, state),
                SizedBox(height: context.hp(2.5)),
                _buildSubmitButton(
                  context,
                  onPressed: () => _handleEducationInfoSubmit(context, state),
                  text: context.localizations.createAccountButton,
                ),
              ],
              SizedBox(height: context.hp(showEdu ? 6 : 2)),
              if (!widget.isEdit) _buildLoginOption(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, AuthState state) {
    final showEdu = state.showEducationInfo ?? false;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.wp(4),
                vertical: context.hp(4),
              ),
              child: Column(
                children: [
                  _buildProgressBar(context, state),
                  SizedBox(height: context.hp(4)),
                  CreateAccountHeader(step: showEdu ? 2 : 1, isEdit: widget.isEdit),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.wp(4),
              vertical: context.hp(4),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (!showEdu) ...[
                    _buildPersonalInfoFields(context, state),
                    SizedBox(height: context.hp(3)),
                    _buildSubmitButton(
                      context,
                      onPressed: () => _handlePersonalInfoSubmit(state, context),
                      text: context.localizations.collegeLabel,
                    ),
                  ] else ...[
                    _buildEducationInfoFields(context, state),
                    SizedBox(height: context.hp(3)),
                    _buildSubmitButton(
                      context,
                      onPressed: () => _handleEducationInfoSubmit(context, state),
                      text: context.localizations.createAccountButton,
                    ),
                  ],
                  SizedBox(height: context.hp(4)),
                  if (!widget.isEdit) _buildLoginOption(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context, AuthState state) {
    final showEdu = state.showEducationInfo ?? false;
    return ProgressBarWithCloseButton(
      onTap: () {
        if (showEdu) {
          context.read<SignupCubit>().showEduInfo(showEdu);
        } else {
          Navigator.pop(context);
        }
      },
      isBack: showEdu,
      progressValue: showEdu ? 1.0 : 0.5,
    );
  }

  Widget _buildPersonalInfoFields(BuildContext context, AuthState state) {
    final isEdit = widget.isEdit;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: 'الاسم الأول',
                hintText: 'أدخل اسمك الأول',
                controller: state.firstNameController!,
                validator: isEdit ? null : FormValidators.validateName,
              ),
            ),
            17.pw(),
            Expanded(
              child: CustomTextField(
                label: 'الاسم الأخير',
                hintText: 'أدخل اسمك الأخير',
                controller: state.lastNameController!,
                validator: isEdit ? null : FormValidators.validateName,
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
          validator: isEdit ? null : FormValidators.validateEmail,
        ),
        if (!isEdit) ...[
          CustomTextField(
            label: 'رقم الهاتف',
            hintText: '000000000',
            controller: state.phoneController!,
            isPhone: true,
            validator: FormValidators.validatePhone,
          ),
          _buildGenderSelector(context, state),
          16.ph(),
          _buildPasswordFields(state, context),
        ],
      ],
    );
  }

  Widget _buildGenderSelector(BuildContext context, AuthState state) {
    const genderOptions = ['ذكر', 'أنثى'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: 'الجنس', fontSize: 14),
        16.ph(),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = SizeConfig().getCrossAxisCount(context, lengthOfList: 2);
            final itemHeight = SizeConfig().getItemHeight(context);
            final gridHeight = (genderOptions.length / crossAxisCount).ceil() * itemHeight;

            return SizedBox(
              height: gridHeight,
              child: ShowGridViewItem<String>(
                crossAxisCount: 2,
                data: genderOptions,
                onTap: (index, string) {
                  context.read<SignupCubit>().selectGenderIndex(index: index);
                },
                selectedIndex: state.selectedGenderIndex,
                displayTextBuilder: (item) => item,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPasswordFields(AuthState state, BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: context.localizations.passwordLabel,
          hintText: context.localizations.passwordHint,
          controller: state.passwordController!,
          isPassword: true,
          isPasswordVisible: state.isPasswordVisible,
          togglePasswordVisibility: () {
            context.read<SignupCubit>().togglePasswordVisibility();
          },
          validator: widget.isEdit ? null : FormValidators.validatePassword,
        ),
        CustomTextField(
          label: context.localizations.confirmPasswordLabel,
          hintText: context.localizations.passwordHint,
          controller: state.confirmPasswordController!,
          isPassword: true,
          isPasswordVisible: state.isPasswordVisible,
          togglePasswordVisibility: () {
            context.read<SignupCubit>().togglePasswordVisibility();
          },
          validator: widget.isEdit
              ? null
              : (value) => FormValidators.validateConfirmPassword(
                    value,
                    state.passwordController!.text,
                  ),
        ),
      ],
    );
  }

  Widget _buildEducationInfoFields(BuildContext context, AuthState state) {
    const semesterOptions = ['أولى', 'ثانية', 'ثالتة', 'رابعة'];
    return Column(
      children: [
        CollegeSelectionWidget(ctx: context),
        16.ph(),
        SizedBox(
          height: 98,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(text: 'سنة الدراسة الحالية ', fontSize: 14),
              16.ph(),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = SizeConfig().getCrossAxisCount(context);
                  final itemHeight = SizeConfig().getItemHeight(context);
                  final rowCount = (semesterOptions.length / crossAxisCount).ceil();
                  final gridHeight = rowCount * itemHeight;

                  return SizedBox(
                    height: gridHeight,
                    child: ShowGridViewItem<String>(
                      crossAxisCount: crossAxisCount,
                      data: semesterOptions,
                      onTap: (index, string) {
                        context.read<SignupCubit>().selectIndex(
                              index: index,
                              selectionType: SelectionType.semester,
                            );
                      },
                      selectedIndex: state.selectedSemesterIndex,
                      displayTextBuilder: (item) => item,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          context.showSnackBar(message: state.errorMessage![0], error: true);
        } else if (state.isAuthenticated) {
          context.go('/account_creation');
        } else if (state.isUpdated) {
          context.showSnackBar(message: 'تم تحديث البيانات بنجاح');
          context.go('/home_screen');
        }
      },
      builder: (context, state) {
        final buttonChild = state.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : AppText(
                text: widget.isEdit ? 'تحديث' : text,
                fontSize: context.isTablet ? 18 : 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              );

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
    if (state.formKey?.currentState?.validate() != true) return;

    if (!widget.isEdit && state.selectedGenderIndex == null) {
      context.showSnackBar(
        message: 'الرجاء اختيار الجنس',
        error: true,
      );
      return;
    }

    context.read<SignupCubit>().showEduInfo(state.showEducationInfo ?? false);
  }

  Future<void> _handleEducationInfoSubmit(
    BuildContext context,
    AuthState state,
  ) async {
    final collegeMajorState = context.read<CollegeMajorsCubit>().state;

    if (collegeMajorState.selectedCollege == null) {
      context.showSnackBar(message: 'الرجاء اختيار الكلية', error: true);
      return;
    }

    if (collegeMajorState.selectedMajorIndex == null) {
      context.showSnackBar(message: 'الرجاء اختيار التخصص', error: true);
      return;
    }

    if (state.selectedSemesterIndex == null) {
      context.showSnackBar(message: 'الرجاء اختيار السنة الدراسية', error: true);
      return;
    }

    if (widget.isEdit) {
      final originalUser = _originalUser;
      if (originalUser == null) return;

      final changedFields = originalUser.toChangedFieldsMap(state);
      if (changedFields.isEmpty) {
        context.showSnackBar(message: 'لا يوجد تغييرات', error: true);
        return;
      }
      await context.read<SignupCubit>().updateProfile(changedFields, context);
    } else {
      final newUser = SignupRequestEntity(
        firstName: state.firstNameController!.text.trim(),
        lastName: state.lastNameController!.text.trim(),
        username: state.userNameController!.text.trim(),
        email: state.emailController!.text.trim(),
        phoneNum: '+972${state.phoneController!.text.trim()}',
        gender: state.selectedGenderIndex == 0 ? 'MALE' : 'FEMALE',
        password: state.passwordController!.text,
        currentYear: state.selectedSemesterIndex! + 1,
        tagId: state.selectedTagId!,
      );
      await context.read<SignupCubit>().signup(newUser);
    }
  }
}
