import 'package:academe_x/academeX_main.dart';
import 'package:academe_x/core/config/app_config.dart';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/auth/auth.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
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
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ))
                  ],
                ),
                50.ph(),
                Column(
                  children: [
                    AppText(
                      text: 'ماذا عنا !',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )
                    // AppText(text: 'تغيير كلمة المرور', fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600,)
                  ],
                )
              ],
            ),
          ),
          Expanded(child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                // children: [
                //

                // ],
                children: List.generate(
                  10, // Number of repeated text blocks
                      (index) => Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: AppText(
                      text: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.right,
                      // height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
