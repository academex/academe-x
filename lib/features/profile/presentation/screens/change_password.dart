import 'package:academe_x/academeX_main.dart';
import 'package:academe_x/core/config/app_config.dart';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/auth/auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body:  Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 183,
            width: double.infinity,
            color: const Color(0xff1F02E8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.ph(),
                Row(
                  children: [
                    IconButton(onPressed: () {
                      Navigator.pop(context);

                    }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,))

                  ],
                ),
                50.ph(),
                Column(
                  children: [
                    AppText(text: 'تغيير كلمة المرور', fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600,)
                    // AppText(text: 'تغيير كلمة المرور', fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600,)
                  ],
                )


              ],
            ),

          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28,vertical: 14),
            child: Column(
              children: [
                CustomTextField(label: 'كلمة المرور الحالية', hintText: 'ادخل كلمة المرور هنا', controller: TextEditingController()),
                CustomTextField(label: 'كلمة المرور الجديدة', hintText: 'ادخل كلمة المرور هنا', controller: TextEditingController()),
                CustomTextField(label: 'تأكيد كلمة المرور الجديدة', hintText: 'ادخل كلمة المرور هنا', controller: TextEditingController()),
                CustomButton(widget: AppText(text: 'تغيير كلمة المرور', fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white,), onPressed:() {

                }, backgraoundColor: Color(0xFF0077FF),)
              ],
            ),
          )

        ],

      ),
    );
  }
}
