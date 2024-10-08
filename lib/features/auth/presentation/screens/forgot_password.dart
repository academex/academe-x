import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/features/auth/presentation/widgets/reset_password_type_way_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_button_widget.dart';
import '../../../../core/widgets/app_text.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const BackButton(color: Colors.black),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'هل نسيت كلمة المرور',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                12.ph(),
                AppText(
                  text:
                  'لا تقلق، يحدث ذلك. يرجى تحديد بريدك الإلكتروني أو رقم هاتفك حتى نتمكن من إرسال رمز إليك.',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff94A3B8),
                  textAlign: TextAlign.start,
                ),
                30.ph(),
                ResetPasswordTypeWayWidget(
                  title: 'البريد الإلكتروني',
                  subtitle: 'بريدك الالكتروني: aklouk@mail.com',
                  icon: Icons.email_outlined,
                  isSelect: true, // Default selected
                ),
                12.ph(),
                ResetPasswordTypeWayWidget(
                  title: 'رقم الهاتف',
                  subtitle: 'هاتفك: *****4566',
                  icon: Icons.phone,
                  isSelect: false,
                ),
                50.ph(),
                Center(
                  child: AppButton(
                    width: 327.w,
                    height: 56.h,
                    color: const Color(0xFF0077FF),
                    fontSize: 16.sp,
                    onPressed: () {
                      Navigator.pushNamed(context, '/verification_code');
                    },
                    fontWeight: FontWeight.w600,
                    text: 'تأكيد',
                  ),
                ),
                20.ph(),
              ],
            )));
  }
}
