import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/features/auth/forgot_password/presentation/widgets/reset_password_type_way_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_button_widget.dart';
import '../../../../core/widgets/app_text.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const BackButton(color: Colors.black),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AppText(
                text: 'Forgot Password',
                fontSize: 24.sp,
                //
                fontWeight: FontWeight.w600,
              ),
              8.ph(),
              AppText(
                text:
                    'Don\'t worry! that happens. Please specify your email or phone number so we can send you a code.',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xff94A3B8),
              ),
              37.ph(),
              ResetPasswordTypeWayWidget(title: 'Email',subtitle: 'Email address : *****aklouk@mail.com',icon: Icons.email_outlined,isSelect: false,),
              12.ph(),

              ResetPasswordTypeWayWidget(title: 'Phone',subtitle:  'Phone number : +1 202-555-0156',icon: Icons.phone,isSelect: true,),
              12.ph(),
              const Spacer(),
              const Spacer(),
              const Spacer(),
              AppButton(
                width: 327,
                height: 60,
                color: const Color(0xFF0077FF),
                fontSize: 16.sp,
                onPressed: () {
                  Navigator.pushNamed(context, '/verification_code');
                },
                // color: Colors.white,
                fontWeight: FontWeight.w600,
                text: 'Confirmation',
              ),
              const Spacer(),
            ])));
  }
}

