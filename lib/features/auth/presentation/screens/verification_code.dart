import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});
  // FocusNode

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color(0xFF3253FF);
    const fillColor = Color(0xFFF9F9F9);
    var borderColor =  Colors.grey[200];
    final defaultPinTheme = PinTheme(
      width: 70   ,
      height: 56   ,
      textStyle:  TextStyle(
        fontSize: 22  ,
        color:const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor!),
      ),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar:const AppCustomAppBar(
          leading: BackButton(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20   ,vertical: 30   ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: context.localizations.verificationTitle,
                fontSize: 24  ,

                // color: Col,
                fontWeight: FontWeight.w600,
              ),
              8.ph(),
              AppText(
                text:context.localizations.verificationSubTitle,
                fontSize: 14  ,
                color: const Color(0xff94A3B8),
              ),
              AppText(
                text: '****aklouk@mail.com',
                fontSize: 14  ,
                color: const Color(0xFF3253FF),
              ),
              23.ph(),
              Pinput(
                controller: TextEditingController(),
                focusNode: FocusNode(),
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 16),
                validator: (value) {
                  return value == '2222' ? null: 'Pin is incorrect';
                },
                errorText: 'Pin is incorrect',
                // smsCodeMatcher: 'Pin is correct',
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },

                focusedPinTheme: defaultPinTheme.copyWith(

                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(12),
                    // border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
              16.ph(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: context.localizations.resendCode,
                    fontSize: 16  ,
                    fontWeight: FontWeight.w500,
                    isUnderline: true,
                  ),
                ],
              ),
              const Spacer(),
              CustomButton(widget: AppText(text: context.localizations.confirmationButton, fontSize: 14  ,color: Colors.white,fontWeight: FontWeight.bold,), onPressed: (){
                Navigator.pushNamed(context, '/create_new_password');

              }, backgraoundColor: const Color(0xff0077FF)),

            ],
          ),
        ));
  }
}
