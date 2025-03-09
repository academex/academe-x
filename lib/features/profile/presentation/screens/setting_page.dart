import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/utils/deep_link_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/controllers/cubits/login_cubit.dart';

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
                        Navigator.pop(context);
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

              child: Column(
                children: [
                  ListTile(
                    onTap: () => context.pushNamed(
                      'signUp',
                      extra: {'isEdit': true}
                    ),
                    leading: Image.asset('assets/icons/setting/information_icon.png'),
                    title: AppText(text: 'تحديث معلوماتي الشخصية', fontSize: 14,fontWeight: FontWeight.w600,),
                  ),
                  12.ph(),
                  ListTile(

                    onTap: () => context.pushNamed(
                      'changePassword'
                    ),
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
                    onTap: () => context.pushNamed(
                      'aboutUs'
                    ),
                    leading: Image.asset('assets/icons/setting/about_academex_icon.png'),
                    // title: AppText(text: ' عن AcademeX ', fontSize: 14,fontWeight: FontWeight.bold),
                     title: const Text.rich(
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
                    onTap: () => showLogoutBottomSheet(context),
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
  Future showLogoutBottomSheet(BuildContext context){
    return showModalBottomSheet(

      builder: (context) {
        return SizedBox(
          height: 217,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              37.ph(),
              Row(
                children: [
                  const Spacer(),
                  AppText(text: 'تسجيل الخروج',fontSize: 18,fontWeight: FontWeight.w400),
                  const Spacer(),
                  IconButton(onPressed: () {
                    Navigator.pop(context);

                  }, icon: Icon(Icons.close))
                ],
              ),
              10.ph(),
              AppText(text: 'هل تريد تسجيل الخروج من Academx حقا؟', fontSize: 16,fontWeight: FontWeight.w400,color: Color(0xFF7D7D7D),),
              20.ph(),
              Padding(padding: EdgeInsets.symmetric(horizontal: 30),child: CustomButton(widget:AppText(text: 'تسجيل الخروج', fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white,),
                  onPressed:() async{
                    await  context.read<LoginCubit>().logout();

                  }, backgraoundColor: Color(0xFFFF0000),),)
            ],
          ),
          // child: Stack(
          //   children: [
          //     Positioned(
          //       left: 0,
          //       top: 0,
          //       child: Container(
          //         width: 375,
          //         height: 217,
          //         decoration: ShapeDecoration(
          //           color: Colors.white,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(18),
          //               topRight: Radius.circular(18),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Positioned(
          //       left: 8.01,
          //       top: 16,
          //       child: Container(
          //         width: 45.50,
          //         height: 45.50,
          //         child: Stack(
          //           children: [
          //             Positioned(
          //               left: 0,
          //               top: 0,
          //               child: Container(
          //                 width: 45.50,
          //                 height: 45.50,
          //                 decoration: ShapeDecoration(
          //                   shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(12.13),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Positioned(
          //               left: 6.07,
          //               top: 23.26,
          //               child: Transform(
          //                 transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.79),
          //                 child: Container(
          //                   width: 24.31,
          //                   height: 24.31,
          //                   clipBehavior: Clip.antiAlias,
          //                   decoration: BoxDecoration(),
          //                   child: FlutterLogo(),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     Positioned(
          //       left: 33,
          //       top: 127.10,
          //       child: Container(
          //         width: 327,
          //         height: 60,
          //         decoration: ShapeDecoration(
          //           color: Color(0xFFFF0000),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(12),
          //           ),
          //         ),
          //         child: Stack(
          //           children: [
          //             Positioned(
          //               left: 117,
          //               top: 16.50,
          //               child: Text(
          //                 'تسجيل الخروج',
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 16,
          //                   fontFamily: 'Cairo',
          //                   fontWeight: FontWeight.w600,
          //                   height: 1.70,
          //                   letterSpacing: 0.10,
          //                 ),
          //               ),
          //             ),
          //             Positioned(
          //               left: -27.72,
          //               top: 120.14,
          //               child: Opacity(
          //                 opacity: 0.40,
          //                 child: Transform(
          //                   transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-1.58),
          //                   child: Container(
          //                     width: 177.37,
          //                     height: 384.06,
          //                     decoration: BoxDecoration(
          //                       gradient: LinearGradient(
          //                         begin: Alignment(0.00, -1.00),
          //                         end: Alignment(0, 1),
          //                         colors: [Colors.white, Colors.black.withOpacity(0.2199999988079071)],
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     Positioned(
          //       left: 57,
          //       top: 37,
          //       child: Container(
          //         width: 279,
          //         height: 69,
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             SizedBox(
          //               width: double.infinity,
          //               child: SizedBox(
          //                 width: double.infinity,
          //                 child: Text(
          //                   'تسجيل الخروج',
          //                   textAlign: TextAlign.center,
          //                   style: TextStyle(
          //                     color: Color(0xFF14130E),
          //                     fontSize: 18,
          //                     fontFamily: 'Cairo',
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             const SizedBox(height: 10),
          //             SizedBox(
          //               width: double.infinity,
          //               child: SizedBox(
          //                 width: double.infinity,
          //                 child: Text(
          //                   'هل تريد تسجيل الخروج من Academx حقا؟',
          //                   textAlign: TextAlign.center,
          //                   style: TextStyle(
          //                     color: Color(0xFF7D7D7D),
          //                     fontSize: 16,
          //                     fontFamily: 'Cairo',
          //                     fontWeight: FontWeight.w400,
          //                     height: 1.56,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        );
      },
      context: context
    );
  }
}
