// import 'package:academe_x/lib.dart';
// import 'package:flutter/material.dart';
//
//
// class SignUpScreen extends StatelessWidget {
//   SignUpScreen({super.key});
//
//   final _formKey = GlobalKey<FormState>();
//
//   // Controllers for text fields
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//   final TextEditingController genderController = TextEditingController();
//
//   void _handleSubmit(BuildContext context) {
//     if (_formKey.currentState?.validate() ?? false) {
//       if (passwordController.text != confirmPasswordController.text) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('كلمات المرور غير متطابقة')),
//         );
//         return;
//       }
//       //
//       // var _formData = const StudentFormData();
//       //
//       // Navigator.push(context, MaterialPageRoute(builder: (context) {
//       //   return StudentRegistrationForm(formData: _formData, onFormChanged: (value) {
//       //
//       //   }, onSubmit: () {
//       //     // Handle form submission
//       //   }, onSignInTap: () {
//       //     // Handle form submission
//       //   },);
//       // },));
//       Navigator.pushNamed(context, '/edu_info');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 ProgressBarWithCloseButton(
//                   onClose: () => Navigator.pop(context),
//                   progressValue: 0.5,
//                 ),
//                 26.ph(),
//                 const CreateAccountHeader(step: 1,),
//                 30.ph(),
//
//                 _buildFormFields(context),
//                 16.ph(),
//                 _buildSubmitButton(context),
//                 16.ph(),
//                 _buildLoginOption(context),
//                 20.ph(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget _buildHeader() {
//   //   return const Align(
//   //     alignment: Alignment.centerRight,
//   //     child: Text.rich(
//   //       TextSpan(
//   //         children: [
//   //           TextSpan(
//   //             text: 'انشاء حسابي',
//   //             style: TextStyle(
//   //               color: Color(0xFF001A27),
//   //               fontSize: 20,
//   //               fontWeight: FontWeight.w600,
//   //             ),
//   //           ),
//   //           TextSpan(text: ' '),
//   //           TextSpan(
//   //             text: '(1- البيانات الشخصية)',
//   //             style: TextStyle(
//   //               color: Color(0xFF001A27),
//   //               fontSize: 12,
//   //               fontWeight: FontWeight.w400,
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   Widget _buildFormFields(BuildContext context) {
//     return Column(
//       children: [
//         CustomTextField(
//           label: context.localizations.nameLabel,
//           hintText: context.localizations.nameHint,
//           controller: nameController,
//           // validator: (value) {
//           //   if (value == null || value.trim().isEmpty) {
//           //     return 'الرجاء إدخال الاسم';
//           //   }
//           //   return null;
//           // },
//         ),
//         CustomTextField(
//           label: context.localizations.emailLabel,
//           hintText: context.localizations.emailHint,
//           controller: emailController,
//           // validator: (value) {
//           //   if (value == null || value.trim().isEmpty) {
//           //     return 'الرجاء إدخال البريد الإلكتروني';
//           //   }
//           //   if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//           //     return 'البريد الإلكتروني غير صالح';
//           //   }
//           //   return null;
//           // },
//         ),
//         CustomTextField(
//           label: 'رقم الهاتف',
//           hintText: '000000000',
//           controller: phoneController,
//           isPhone: true,
//           // validator: (value) {
//           //   if (value == null || value.isEmpty) {
//           //     return 'الرجاء إدخال رقم الهاتف';
//           //   }
//           //   if (value.length != 9) {
//           //     return 'رقم الهاتف يجب أن يتكون من 9 أرقام';
//           //   }
//           //   if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
//           //     return 'رقم الهاتف يجب أن يحتوي على أرقام فقط';
//           //   }
//           //   return null;
//           // },
//         ),
//     SelectionGrid(title: 'الجنس', options: ['ذكر','انثى'], selectedOption: 'ذكر', onSelected: (p0) {},isTerm: true,),
//        16.ph(),
//         ValueListenableBuilder<bool>(
//           valueListenable: ValueNotifier<bool>(false),
//           builder: (context, isPasswordVisible, _) {
//             return CustomTextField(
//               label: context.localizations.passwordLabel,
//               hintText: context.localizations.passwordHint,
//               controller: passwordController,
//               isPassword: true,
//               isPasswordVisible: isPasswordVisible,
//               togglePasswordVisibility: () {
//                 (isPasswordVisible as ValueNotifier<bool>).value = !isPasswordVisible;
//               },
//               // validator: (value) {
//               //   if (value == null || value.isEmpty) {
//               //     return 'الرجاء إدخال كلمة المرور';
//               //   }
//               //   if (value.length < 8) {
//               //     return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
//               //   }
//               //   return null;
//               // },
//             );
//           },
//         ),
//         ValueListenableBuilder<bool>(
//           valueListenable: ValueNotifier<bool>(false),
//           builder: (context, isConfirmPasswordVisible, _) {
//             return CustomTextField(
//               label: context.localizations.confirmPasswordLabel,
//               hintText: context.localizations.passwordHint,
//               controller: confirmPasswordController,
//               isPassword: true,
//               isPasswordVisible: isConfirmPasswordVisible,
//               togglePasswordVisibility: () {
//                 (isConfirmPasswordVisible as ValueNotifier<bool>).value = !isConfirmPasswordVisible;
//               },
//               // validator: (value) {
//               //   if (value == null || value.isEmpty) {
//               //     return 'الرجاء تأكيد كلمة المرور';
//               //   }
//               //   if (value != passwordController.text) {
//               //     return 'كلمات المرور غير متطابقة';
//               //   }
//               //   return null;
//               // },
//             );
//           },
//         ),
//
//       ],
//     );
//   }
//
//   Widget _buildSubmitButton(BuildContext context) {
//     return CustomButton(
//       onPressed: () => _handleSubmit(context),
//       widget: AppText(
//         text: context.localizations.collegeLabel,
//         fontSize: 14,
//         color: Colors.white,
//         fontWeight: FontWeight.bold,
//       ),
//       backgraoundColor: Theme.of(context).primaryColor,
//     );
//   }
//
//   Widget _buildLoginOption(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         AppText(
//           text: context.localizations.already_have_account,
//           fontSize: 14,
//           color: Colors.black,
//         ),
//         GestureDetector(
//           onTap: () => Navigator.pushNamed(context, '/login'),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: AppText(
//               text: context.localizations.loginTitle,
//               fontSize: 14,
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController confirmPasswordController = TextEditingController();

  // Education info selections
  String? selectedCollege = "";
  String? selectedYear;
  String? selectedTerm;
  String selectedGender = 'ذكر';

  final List<String> colleges = [
    "هندسة", "طب", "تجارة", "IT", "محاسبة", "صحافة",
    "إنجليش", "شريعة", "صحافة", "إنجليش", "شريعة", "إنجليش",
  ];

  final List<String> studyYears = ["أولى", "ثانية", "ثالثة", "رابعة"];
  final List<String> terms = ["الأول", "الثاني"];

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
                  onTap:() {
                    AppLogger.success('message');
                    if(showEducationInfo){
                      setState(() {
                        showEducationInfo=false;
                      });
                    }else{
                      Navigator.pop(context);
                    }

                  },
                  isBack: showEducationInfo? true:false,
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

                ]
                else ...[
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
        CustomTextField(
          label: context.localizations.nameLabel,
          hintText: context.localizations.nameHint,
          controller: nameController,
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
        SelectionGrid(
          title: 'الجنس',
          options: ['ذكر', 'انثى'],
          selectedOption: selectedGender,
          onSelected: (value) => setState(() => selectedGender = value),
          isTerm: true,
        ),
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
                (isPasswordVisible as ValueNotifier<bool>).value = !isPasswordVisible;
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
                (isConfirmPasswordVisible as ValueNotifier<bool>).value = !isConfirmPasswordVisible;
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildEducationInfoFields() {
    return Column(
      children: [
        SelectionGrid(
          title: context.localizations.collegeLabel,
          options: colleges,
          selectedOption: selectedCollege,
          onSelected: (value) => setState(() => selectedCollege = value),
        ),
        20.ph(),
        SelectionGrid(
          title: context.localizations.currentYearLabel,
          options: studyYears,
          selectedOption: selectedYear,
          onSelected: (value) => setState(() => selectedYear = value),
          isYearVar: true,
        ),
        20.ph(),
        SelectionGrid(
          title: context.localizations.semesterLabel,
          options: terms,
          selectedOption: selectedTerm,
          onSelected: (value) => setState(() => selectedTerm = value),
          isTerm: true,
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, {
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