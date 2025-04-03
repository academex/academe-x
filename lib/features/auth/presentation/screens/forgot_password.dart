import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                  text: context.localizations.forgotPasswordTitle,
                  fontSize: 22 ,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                12.ph(),
                AppText(
                  text:
                  context.localizations.forgotPasswordSubTitle,
                  fontSize: 14 ,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff94A3B8),
                  textAlign: TextAlign.start,
                ),
                30.ph(),
                ResetPasswordTypeWayWidget(
                  title: context.localizations.emailOption,
                  subtitle: '${context.localizations.emailDescription}: aklouk@mail.com',
                  icon: Icons.email_outlined,
                  isSelect: true, // Default selected
                ),
                12.ph(),
                ResetPasswordTypeWayWidget(
                  title: context.localizations.phoneOption,
                  subtitle: '${context.localizations.phoneDescription}: *****4566',
                  icon: Icons.phone,
                  isSelect: false,
                ),
                50.ph(),
                Center(
                  child: CustomButton(widget: AppText(text: context.localizations.confirmationButton, fontSize: 16 ,fontWeight: FontWeight.w600,), onPressed: (){
                        context.pushNamed('/verification_code');

                  }, backgraoundColor: const Color(0xFF0077FF))

                  // AppButton(
                  //   width: 327.w,
                  //   height: 56.h,
                  //   color: const Color(0xFF0077FF),
                  //   fontSize: 16  ,
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/verification_code');
                  //   },
                  //   fontWeight: FontWeight.w600,
                  //   text:,
                  // ),
                ),
                20.ph(),
              ],
            )));
  }
}
