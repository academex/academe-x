// // import 'package:academe_x/lib.dart';
// // import 'package:flutter/material.dart';
// //
// //
// // class SignUpScreen extends StatelessWidget {
// //   SignUpScreen({super.key});
// //
// //   final _formKey = GlobalKey<FormState>();
// //
// //   // Controllers for text fields
// //   final TextEditingController nameController = TextEditingController();
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //   final TextEditingController phoneController = TextEditingController();
// //   final TextEditingController confirmPasswordController = TextEditingController();
// //   final TextEditingController genderController = TextEditingController();
// //
// //   void _handleSubmit(BuildContext context) {
// //     if (_formKey.currentState?.validate() ?? false) {
// //       if (passwordController.text != confirmPasswordController.text) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('كلمات المرور غير متطابقة')),
// //         );
// //         return;
// //       }
// //       //
// //       // var _formData = const StudentFormData();
// //       //
// //       // Navigator.push(context, MaterialPageRoute(builder: (context) {
// //       //   return StudentRegistrationForm(formData: _formData, onFormChanged: (value) {
// //       //
// //       //   }, onSubmit: () {
// //       //     // Handle form submission
// //       //   }, onSignInTap: () {
// //       //     // Handle form submission
// //       //   },);
// //       // },));
// //       Navigator.pushNamed(context, '/edu_info');
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
// //           child: Form(
// //             key: _formKey,
// //             child: Column(
// //               children: [
// //                 ProgressBarWithCloseButton(
// //                   onClose: () => Navigator.pop(context),
// //                   progressValue: 0.5,
// //                 ),
// //                 26.ph(),
// //                 const CreateAccountHeader(step: 1,),
// //                 30.ph(),
// //
// //                 _buildFormFields(context),
// //                 16.ph(),
// //                 _buildSubmitButton(context),
// //                 16.ph(),
// //                 _buildLoginOption(context),
// //                 20.ph(),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // Widget _buildHeader() {
// //   //   return const Align(
// //   //     alignment: Alignment.centerRight,
// //   //     child: Text.rich(
// //   //       TextSpan(
// //   //         children: [
// //   //           TextSpan(
// //   //             text: 'انشاء حسابي',
// //   //             style: TextStyle(
// //   //               color: Color(0xFF001A27),
// //   //               fontSize: 20,
// //   //               fontWeight: FontWeight.w600,
// //   //             ),
// //   //           ),
// //   //           TextSpan(text: ' '),
// //   //           TextSpan(
// //   //             text: '(1- البيانات الشخصية)',
// //   //             style: TextStyle(
// //   //               color: Color(0xFF001A27),
// //   //               fontSize: 12,
// //   //               fontWeight: FontWeight.w400,
// //   //             ),
// //   //           ),
// //   //         ],
// //   //       ),
// //   //     ),
// //   //   );
// //   // }
// //
// //   Widget _buildFormFields(BuildContext context) {
// //     return Column(
// //       children: [
// //         CustomTextField(
// //           label: context.localizations.nameLabel,
// //           hintText: context.localizations.nameHint,
// //           controller: nameController,
// //           // validator: (value) {
// //           //   if (value == null || value.trim().isEmpty) {
// //           //     return 'الرجاء إدخال الاسم';
// //           //   }
// //           //   return null;
// //           // },
// //         ),
// //         CustomTextField(
// //           label: context.localizations.emailLabel,
// //           hintText: context.localizations.emailHint,
// //           controller: emailController,
// //           // validator: (value) {
// //           //   if (value == null || value.trim().isEmpty) {
// //           //     return 'الرجاء إدخال البريد الإلكتروني';
// //           //   }
// //           //   if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
// //           //     return 'البريد الإلكتروني غير صالح';
// //           //   }
// //           //   return null;
// //           // },
// //         ),
// //         CustomTextField(
// //           label: 'رقم الهاتف',
// //           hintText: '000000000',
// //           controller: phoneController,
// //           isPhone: true,
// //           // validator: (value) {
// //           //   if (value == null || value.isEmpty) {
// //           //     return 'الرجاء إدخال رقم الهاتف';
// //           //   }
// //           //   if (value.length != 9) {
// //           //     return 'رقم الهاتف يجب أن يتكون من 9 أرقام';
// //           //   }
// //           //   if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
// //           //     return 'رقم الهاتف يجب أن يحتوي على أرقام فقط';
// //           //   }
// //           //   return null;
// //           // },
// //         ),
// //     SelectionDropDown(title: 'الجنس', options: ['ذكر','انثى'], selectedOption: 'ذكر', onSelected: (p0) {},isTerm: true,),
// //        16.ph(),
// //         ValueListenableBuilder<bool>(
// //           valueListenable: ValueNotifier<bool>(false),
// //           builder: (context, isPasswordVisible, _) {
// //             return CustomTextField(
// //               label: context.localizations.passwordLabel,
// //               hintText: context.localizations.passwordHint,
// //               controller: passwordController,
// //               isPassword: true,
// //               isPasswordVisible: isPasswordVisible,
// //               togglePasswordVisibility: () {
// //                 (isPasswordVisible as ValueNotifier<bool>).value = !isPasswordVisible;
// //               },
// //               // validator: (value) {
// //               //   if (value == null || value.isEmpty) {
// //               //     return 'الرجاء إدخال كلمة المرور';
// //               //   }
// //               //   if (value.length < 8) {
// //               //     return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
// //               //   }
// //               //   return null;
// //               // },
// //             );
// //           },
// //         ),
// //         ValueListenableBuilder<bool>(
// //           valueListenable: ValueNotifier<bool>(false),
// //           builder: (context, isConfirmPasswordVisible, _) {
// //             return CustomTextField(
// //               label: context.localizations.confirmPasswordLabel,
// //               hintText: context.localizations.passwordHint,
// //               controller: confirmPasswordController,
// //               isPassword: true,
// //               isPasswordVisible: isConfirmPasswordVisible,
// //               togglePasswordVisibility: () {
// //                 (isConfirmPasswordVisible as ValueNotifier<bool>).value = !isConfirmPasswordVisible;
// //               },
// //               // validator: (value) {
// //               //   if (value == null || value.isEmpty) {
// //               //     return 'الرجاء تأكيد كلمة المرور';
// //               //   }
// //               //   if (value != passwordController.text) {
// //               //     return 'كلمات المرور غير متطابقة';
// //               //   }
// //               //   return null;
// //               // },
// //             );
// //           },
// //         ),
// //
// //       ],
// //     );
// //   }
// //
// //   Widget _buildSubmitButton(BuildContext context) {
// //     return CustomButton(
// //       onPressed: () => _handleSubmit(context),
// //       widget: AppText(
// //         text: context.localizations.collegeLabel,
// //         fontSize: 14,
// //         color: Colors.white,
// //         fontWeight: FontWeight.bold,
// //       ),
// //       backgraoundColor: Theme.of(context).primaryColor,
// //     );
// //   }
// //
// //   Widget _buildLoginOption(BuildContext context) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: [
// //         AppText(
// //           text: context.localizations.already_have_account,
// //           fontSize: 14,
// //           color: Colors.black,
// //         ),
// //         GestureDetector(
// //           onTap: () => Navigator.pushNamed(context, '/login'),
// //           child: Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: AppText(
// //               text: context.localizations.loginTitle,
// //               fontSize: 14,
// //               color: Theme.of(context).primaryColor,
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
//
import 'package:academe_x/features/auth/presentation/widgets/signup/show_grid_view_item.dart';
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
  final _formKey = GlobalKey<FormState>();
  bool showEducationInfo = false;

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Education info selections
  String? selectedCollege;
  String? selectedYear;
  String? selectedTerm;
  String selectedGender = 'ذكر';

  final List<String> colleges = [
    "شريعة",
    "صحافة",
    "إنجليش",
    'قم باختيار الكلية من هنا '
  ];

  final List<String> studyYears = ["أولى", "ثانية", "ثالثة", "رابعة"];
  final List<String> terms = ["الأول", "الثاني"];

  final List<String> genderOptions = ['ذكر', 'انثى'];

  void _handlePersonalInfoSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('كلمات المرور غير متطابقة')),
        );
        return;
      }
      setState(() {
        showEducationInfo = true;
      });
    }
  }

  void _handleEducationInfoSubmit() {
    Navigator.pushNamed(context, '/account_creation');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ProgressBarWithCloseButton(
                  onTap: () {
                    AppLogger.success('message');
                    if (showEducationInfo) {
                      setState(() {
                        showEducationInfo = false;
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  isBack: showEducationInfo ? true : false,
                  progressValue: showEducationInfo ? 1.0 : 0.5,
                ),
                26.ph(),
                CreateAccountHeader(
                  step: showEducationInfo ? 2 : 1,
                ),
                30.ph(),
                if (!showEducationInfo) ...[
                  _buildPersonalInfoFields(context),
                  16.ph(),
                  _buildSubmitButton(
                    context,
                    onPressed: _handlePersonalInfoSubmit,
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
                if (showEducationInfo) ...[
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
    );
  }

  Widget _buildPersonalInfoFields(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: 'الاسم الأول',
                hintText: 'أدخل اسمك الأول',
                controller: nameController,
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
          controller: emailController,
        ),
        CustomTextField(
          label: context.localizations.emailLabel,
          hintText: context.localizations.emailHint,
          controller: emailController,
        ),
        CustomTextField(
          label: 'رقم الهاتف',
          hintText: '000000000',
          controller: phoneController,
          isPhone: true,
        ),
        SelectionDropDown(
          value: selectedGender,
          items: genderOptions,
          label: 'الجنس',
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedGender = newValue;
              });
            }
          },
        ),
        // SelectionDropDown(
        //   title: 'الجنس',
        //   options: ['ذكر', 'انثى'],
        //   selectedOption: 'ذكر',
        //   onSelected: (value) => setState(() => selectedGender = value),
        //   isTerm: true,
        // ),
        16.ph(),
        _buildPasswordFields(),
      ],
    );
  }

  Widget _buildPasswordFields() {
    return Column(
      children: [
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
              controller: confirmPasswordController,
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
      child: BlocBuilder<CollegeCubit,CollegeState>(
        builder: (context, state) => Column(
          children: [
             CollegeSelectionWidget(ctx: context,),
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
                      child: ShowGridViewItem(data: const ['أولى','ثانية','ثالتة','رابعة',],onTap:(index) {
                        context.read<CollegeCubit>().selectIndex(index,SelectionType.semester);


                      },selectedIndex: state.selectedSemesterIndex ,)
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
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
