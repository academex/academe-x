import 'package:academe_x/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academe_x/core/widgets/app_text.dart'; // Assuming you have this custom text widget
import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/const/app_robot.dart'; // Robot SVG import

class AccountCreationSuccessScreen extends StatelessWidget {
  const AccountCreationSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2200F3), // Background color same as previous screen
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context); // Close button action
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Robot SVG Image
            SvgPicture.string(
              mySignInRobotSVG,
              height: 150.h,
              width: 150.w,
            ),
            20.ph(),
            // Success Message
            AppText(
              text: 'تم تجهيز حسابك!',
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            13.ph(),
            AppText(
              text: 'تم إعداد حسابك بنجاح',
              fontSize: 16.sp,
              color: Colors.white,
              textAlign: TextAlign.center,
            ),
           const Spacer(),

            RichText(
              textAlign: TextAlign.center, // Center the text
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
                children: [

                  TextSpan(text: 'إعادة توجيه للرئيسية في ',style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                  )),
                  const TextSpan(
                    text: '4 ثوانٍ', // The green part
                    style: TextStyle(
                      color: Color(0xFF5DCA14), // Green color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            16.ph(),
            CustomButton(
                widget: AppText(text: 'الانتقال الرئيسية', fontSize: 16.sp,color: Colors.white,),
                onPressed:(){}, color:const Color(0xff2200F3),
              wihtBorder: true,

            ),


            // Icon(Icons.celebration, color: Colors.white, size: 40.h),
            21.ph(),
            // Button to navigate to main screen
            // CustomButton(widget: widget, onPressed: onPressed, color: color),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigator.pushReplacementNamed(context, '/main'); // Replace with the main page route
            //   },
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: const Color(0xFF2200F3), backgroundColor: Colors.white, // Button text color
            //     padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.h),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.r), // Rounded button
            //     ),
            //   ),
            //   child:
            // ),
            20.ph(),
            // Bottom Text

          ],
        ),
      ),
    );
  }
}
