import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              color: Color(0xff2769F2),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12
                ),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white,size: 30,),
                      onPressed: () {
                        // Navigator.pop(context);
                      },
                    ),
                    15.ph(),
                    AppText(text: 'الاعدادات', fontSize: 16,color: Colors.white,),
                    10.ph(),
                    AppText(text: 'يمكنك التحكم بجميع اعدادات حساب من هنا', fontSize: 12,color: Colors.white,),
                  ],
                ),
              )
            ),
            15.ph(),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 0
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Image.asset('assets/icons/setting/information_icon.png'),
                    title: AppText(text: 'تحديث معلوماتي الشخصية', fontSize: 14,fontWeight: FontWeight.w600,),
                  ),
                  12.ph(),
                  ListTile(
                    leading: Image.asset('assets/icons/setting/change_password_icon.png'),
                    title: AppText(text: 'تغيير كلمة المرور', fontSize: 14,fontWeight: FontWeight.w600),
                  ),
                  12.ph(),
                  ListTile(
                    leading: Image.asset('assets/icons/setting/center_help_icon.png'),
                    title: AppText(text: 'مركز الدعم والمساعدة', fontSize: 14,fontWeight: FontWeight.w600),
                  ),
                  12.ph(),
                  ListTile(
                    leading: Image.asset('assets/icons/setting/privacy_policy_icon.png'),
                    title: AppText(text: 'سياسة الخصوصية', fontSize: 14,fontWeight: FontWeight.w600),
                  ),
                  12.ph(),
                  ListTile(
                    leading: Image.asset('assets/icons/setting/about_academex_icon.png'),
                    // title: AppText(text: ' عن AcademeX ', fontSize: 14,fontWeight: FontWeight.bold),
                     title: Text.rich(
                       TextSpan(
                         children: [
                           TextSpan(
                             text: ' عن  ',
                             style: TextStyle(
                               color: Color(0xFF111827),
                               fontSize: 14,
                               fontFamily: 'Cairo',
                               fontWeight: FontWeight.w600,
                               height: 1.60,
                               letterSpacing: 0.20,
                             ),
                           ),
                           TextSpan(
                             text: 'AcademeX',
                             style: TextStyle(
                               color: Color(0xFF1501E6),
                               fontSize: 14,
                               fontFamily: 'Cairo',
                               fontWeight: FontWeight.w700,
                               height: 1.60,
                               letterSpacing: 0.20,
                             ),
                           ),
                           TextSpan(
                             text: ' ',
                             style: TextStyle(
                               color: Color(0xFF111827),
                               fontSize: 14,
                               fontFamily: 'Cairo',
                               fontWeight: FontWeight.w600,
                               height: 1.60,
                               letterSpacing: 0.20,
                             ),
                           ),
                         ],
                       ),
                     ),
                  ),
                  12.ph(),
                  ListTile(
                    leading: Image.asset('assets/icons/setting/logout_icon.png'),
                    title: AppText(text: 'تسجيل الخروج', fontSize: 14,color: Colors.red,fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )

          ],
        )
      ),
    );
  }
}
