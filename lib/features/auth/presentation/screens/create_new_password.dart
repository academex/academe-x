import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
class CreateNewPasswordScreen extends StatelessWidget {
   CreateNewPasswordScreen({super.key});

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppCustomAppBar(
        leading: BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20   ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: context.localizations.newPasswordTitle,
              fontSize: 24 ,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            8.ph(),
            AppText(
              text: context.localizations.newPasswordSubTitle,
              fontSize: 14 ,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF94A3B8),
            ),
            30.ph(),
            CustomTextField(
              label: context.localizations.newPasswordLabel,
              hintText: context.localizations.passwordHint,
              controller: _passwordController,
              isPassword: true,
              isPasswordVisible: false,
            ),
            10.ph(),
            RichText(
              text: TextSpan(
                text:  context.localizations.passwordRequirement1,
                style: TextStyle(
                  fontSize: 12 ,
                  // fontFamily: GoogleFonts.cairo().fontFamily,
                  color: Colors.black87, // Default color for regular text
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:'  ${context.localizations.passwordMinimumChars}',
                    style: TextStyle(
                      fontSize: 12 ,
                      color: Colors.blue, // Color for highlighted text
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:'  ${context.localizations.passwordRequirement2}',
                    style: TextStyle(
                      fontSize: 12 ,
                      color: Colors.black87, // Continue with the default color
                    ),
                  ),
                ],
              ),
            ),

            20.ph(),
            CustomTextField(
              label: context.localizations.confirmPasswordLabel,
              hintText:context.localizations.confirmPasswordLabel,
              controller: _confirmPasswordController,
              isPassword: true,
              isPasswordVisible: false,

            ),
            const Spacer(),
            CustomButton(widget: AppText(text: context.localizations.confirmationButton, fontSize: 16 ,color: Colors.white,), onPressed: () {
            },   color: const Color(0xFF0077FF),)
            ,
            20.ph(),
          ],
        ),
      ),
    );
  }
}
