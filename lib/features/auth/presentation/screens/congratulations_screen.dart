import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccountCreationSuccessScreen extends StatelessWidget {
  const AccountCreationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2200F3), // Background color same as previous screen
      appBar: AppCustomAppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const SizedBox(),
        showCloseButton: true, // Add close button
        onCloseButtonPressed: () {
          // Custom action or Navigator.pop(context)
        },
      ),

        body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24   , vertical: 40   ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Robot SVG Image
            SvgPicture.string(
              mySignInRobotSVG,
              height: 150   ,
              width: 150   ,
            ),
            20.ph(),
            // Success Message
            AppText(
              text: context.localizations.accountCreationSuccessTitle,
              fontSize: 24 ,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            13.ph(),
            AppText(
              text: context.localizations.accountCreationLoadingSubTitle,
              fontSize: 16 ,
              color: Colors.white,
              textAlign: TextAlign.center,
            ),
           const Spacer(),

            RichText(
              textAlign: TextAlign.center, // Center the text
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16 ,
                  color: Colors.white,
                ),
                children: [

                  TextSpan(text: context.localizations.redirectIn,style: TextStyle(
                    fontSize: 14 ,
                    // fontFamily: GoogleFonts.cairo().fontFamily,
                  )),
                   TextSpan(
                    text: '4 ${context.localizations.seconds}', // The green part
                    style: const TextStyle(
                      color: Color(0xFF5DCA14), // Green color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            16.ph(),
            CustomButton(
                widget: AppText(text: context.localizations.goToMainPage, fontSize: 16 ,color: Colors.white,),
                onPressed:(){}, color:const Color(0xff2200F3),
              wihtBorder: true,

            ),


            // Icon(Icons.celebration, color: Colors.white, size: 40   ),
            21.ph(),
            // Button to navigate to main screen
            // CustomButton(widget: widget, onPressed: onPressed, color: color),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigator.pushReplacementNamed(context, '/main'); // Replace with the main page route
            //   },
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: const Color(0xFF2200F3), backgroundColor: Colors.white, // Button text color
            //     padding: EdgeInsets.symmetric(horizontal: 50   , vertical: 15   ),
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
