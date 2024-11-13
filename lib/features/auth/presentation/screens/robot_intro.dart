import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

class RobotIntroScreen extends StatelessWidget {
  const RobotIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00009A),
      appBar:  AppCustomAppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: 0.ph(),
      ),
      body: Stack(
        // alignment: AlignmentDirectional.bottomEnd,
        children: [
          Padding(
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
                  textAlign: TextAlign.center,
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
          ),
          Positioned(
            top: 19,
            right: 21,
            child:  Container(
              alignment: AlignmentDirectional.bottomStart,
              // transformAlignment: ,
              width: 54,
              height: 53.47,
              decoration:const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/intro_splash.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 76,
            left: -20,
            child:  Container(
              alignment: AlignmentDirectional.bottomStart,
              // transformAlignment: ,
              width: 54,
              height: 53.47,
              decoration:const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/intro_splash.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
