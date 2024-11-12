import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class RobotIntroScreen extends StatelessWidget {
  const RobotIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0000FF),
      appBar: const AppCustomAppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Load the SVG robot logo
            SvgPicture.string(
              mySignInfoRobotSVG,
              width: 153.31,
              height: 154.66,
            ),
            30.ph(), // Vertical spacing
            // Using AppText for the title
            AppText(
              text: context.localizations.robotIntroTitle,
              textAlign: TextAlign.center,
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
            10.ph(), // Vertical spacing
            // Using AppText for the description
            AppText(
              text:context.localizations.robotIntroSubTitle,
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            16.ph(),// Vertical spacing
            // Using CustomButton for the "Start" button
            CustomButton(
              backgraoundColor: Colors.transparent,
              wihtBorder: true,
              borderColor: Colors.white,
              // text: ,
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up');

                // Add your navigation logic here for the next step
              }, widget: AppText(text: context.localizations.startButton, fontSize: 16  ,color: Colors.white,),
            ),
          ],
        ),
      )
    );
  }
}
