import 'dart:developer';

import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/core/widgets/app_button_widget.dart';
import 'package:academe_x/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pinput/pinput.dart';

import '../../../../core/widgets/app_text.dart';

class VerificationCode extends StatelessWidget {
  VerificationCode({super.key});
  // FocusNode

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color(0xFF3253FF);
    const fillColor = Color(0xFF838383);
    const borderColor = Color(0x38D9D9D9);
    // final defaultPinTheme = PinTheme(
    //   width: 70.w,
    //   height: 56.h,
    //   textStyle:  TextStyle(
    //     fontSize: 22.sp,
    //     color:const Color.fromRGBO(30, 60, 87, 1),
    //   ),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(12),
    //     border: Border.all(color: Colors.black.withOpacity(0.5)),
    //   ),
    // );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const BackButton(color: Colors.black),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Verification Code',
                fontSize: 24.sp,

                // color: Col,
                fontWeight: FontWeight.w600,
              ),
              8.ph(),
              AppText(
                text: 'Please enter the verification code sent to your email: ',
                fontSize: 14.sp,
                color: Color(0xff94A3B8),
              ),
              AppText(
                text: '****aklouk@mail.com',
                fontSize: 14.sp,
                color: Color(0xFF3253FF),
              ),
              23.ph(),
              // Pinput(
              //   controller: TextEditingController(),
              //   focusNode: FocusNode(),
              //   // androidSmsAutofillMethod:
              //   // AndroidSmsAutofillMethod.smsUserConsentApi,
              //   // listenForMultipleSmsOnAndroid: true,
              //   defaultPinTheme: defaultPinTheme,
              //   separatorBuilder: (index) => const SizedBox(width: 16),
              //   validator: (value) {
              //     return value == '2222' ? null: 'Pin is incorrect';
              //   },
              //   errorText: 'Pin is incorrect',
              //   // smsCodeMatcher: 'Pin is correct',
              //   hapticFeedbackType: HapticFeedbackType.lightImpact,
              //   onCompleted: (pin) {
              //     debugPrint('onCompleted: $pin');
              //   },
              //   onChanged: (value) {
              //     debugPrint('onChanged: $value');
              //   },
              //
              //   focusedPinTheme: defaultPinTheme.copyWith(
              //
              //     decoration: defaultPinTheme.decoration!.copyWith(
              //       borderRadius: BorderRadius.circular(12),
              //       border: Border.all(color: focusedBorderColor),
              //     ),
              //   ),
              //   submittedPinTheme: defaultPinTheme.copyWith(
              //     decoration: defaultPinTheme.decoration!.copyWith(
              //       color: fillColor,
              //       borderRadius: BorderRadius.circular(12),
              //       border: Border.all(color: focusedBorderColor),
              //     ),
              //   ),
              //   errorPinTheme: defaultPinTheme.copyBorderWith(
              //     border: Border.all(color: Colors.redAccent),
              //   ),
              // ),
              16.ph(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: 'Resend Code',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    isUnderline: true,
                  ),
                ],
              ),
              const Spacer(),
              AppButton(
                width: 327,
                height: 60,
                color: Color(0xFF0077FF),
                fontSize: 16.sp,
                onPressed: () {
                  // Navigator.pushNamed(context, '/forgot_Password');
                },
                // color: Colors.white,
                fontWeight: FontWeight.w600,
                text: 'Confirmation',
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
