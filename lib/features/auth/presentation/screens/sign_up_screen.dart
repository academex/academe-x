import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24   ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            40.ph(),
            ProgressBarWithCloseButton(onClose: () {

            },
              progressValue: 0.5,),            19.ph(),
             // RobotWithSpeechBubble(svgString: mySignInRobotSVG, speechText: context.localizations.personalData),

            // _buildRobotWithSpeechBubble(),
            20.ph(),
            _buildGoogleSignInButton(context),
            30.ph(),
            _buildDividerWithText(context.localizations.orCreateAccount),
            _buildFormFields(context),
            30.ph(),
            _buildSubmitButton(context),
            20.ph(),
            _buildLoginOption(context),
            20.ph(),
          ],
        ),
      ),
    );
  }

  // Extracted ProgressBar and Close Button to avoid rebuilds
  // Widget _buildProgressBarWithCloseButton(BuildContext context) {
  //   return const _ProgressBarWithCloseButton();
  // }

  // Extracted Robot with SpeechBubble
  // Widget _buildRobotWithSpeechBubble() {
  //   return const _RobotWithSpeechBubble();
  // }

  // Extracted Google Sign-In Button
  Widget _buildGoogleSignInButton(BuildContext context) {
    return CustomButton(
      backgraoundColor: const Color(0xffF9F9F9),
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.string(
              googleSVG

          ),
          10.pw(),
          AppText(
            text:context.localizations.createAccountTitle,
            fontSize: 16  ,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
      onPressed: () {
        final email = emailController.text;
        final password = passwordController.text;
        // Handle sign in logic here
      },
    );
  }

  // Extracted Divider with Text
  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AppText(
            text: text,
            fontSize: 16  ,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ),
      ],
    );
  }

  // Extracted Form Fields
  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: context.localizations.nameHint,
          label:context.localizations.nameLabel,
          controller: nameController,
        ),
        16.ph(),
        CustomTextField(
          hintText: context.localizations.nameHint,
          label:context.localizations.emailLabel,
          controller: emailController,
        ),
        16.ph(),
        CustomTextField(
          hintText: context.localizations.passwordHint,
          label: context.localizations.passwordLabel,
          controller: passwordController,
          isPassword: true,
        ),
        16.ph(),
        CustomTextField(
          hintText: context.localizations.confirmPasswordLabel,
          label: context.localizations.confirmPasswordLabel,
          controller: confirmPasswordController,
          isPassword: true,
        ),
      ],
    );
  }

  // Extracted Submit Button
  Widget _buildSubmitButton(BuildContext context) {
    return CustomButton(
      onPressed: () {
        Navigator.pushNamed(context, '/edu_info');
      },
      widget: AppText(
        text: context.localizations.collegeLabel,
        fontSize: 14  ,
        color: Colors.white,
        fontWeight: FontWeight.bold,

      ),
      backgraoundColor: Colors.blueAccent,
    );
  }

  // Extracted Login Option Row
  Widget _buildLoginOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: context.localizations.already_have_account,
          fontSize: 14  ,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          child: AppText(
            text: context.localizations.loginTitle,
            fontSize: 14  ,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

// Separate ProgressBar and CloseButton into a StatelessWidget for better performance
// class _ProgressBarWithCloseButton extends StatelessWidget {
//   const _ProgressBarWithCloseButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50.h,
//       child: Stack(
//         children: [
//           Positioned.fill(
//             right: 40,
//             child: Align(
//               alignment: Alignment.center,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: SizedBox(
//                   height: 10.h,
//                   width: 284.w,
//                   child: LinearProgressIndicator(
//                     value: 0.5,
//                     minHeight: 16.h,
//                     backgroundColor: Colors.grey[200],
//                     color: const Color(0xff5DCA14),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             right: 0,
//             child: IconButton(
//               icon: Icon(Icons.close, size: 24.w, color: Colors.black),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

