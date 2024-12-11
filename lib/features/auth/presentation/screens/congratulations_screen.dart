import 'package:academe_x/core/utils/go_router.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AccountCreationSuccessScreen extends StatelessWidget {
  const AccountCreationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2200F3), // Background color same as previous screen
        body: Stack(
          children: [
            Image.asset(AppAssets.lightUnderContent,width: 812,fit: BoxFit.fill,height: 1000,),
            Positioned(
              child:  Container(
                decoration:const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.celebrateCreatingAccount),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  SvgPicture.string(
                    signInfoRobotSVG,
                    height: 150   ,
                    width: 150   ,
                  ),
                  21.ph(),
                  // Success Message
                  AppText(
                    text: context.localizations.accountCreationSuccessTitle,
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  13.ph(),
                  AppText(
                    text: context.localizations.accountCreationLoadingSubTitle,
                    fontSize: 16 ,
                    color: Colors.white.withOpacity(0.8799999952316284),
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
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
                    onPressed:(){
                      context.go('/home_screen');
                      // Navigator.pushReplacementNamed(context, '/home_screen');
                    }, backgraoundColor:Colors.transparent,
                    wihtBorder: true,
                  ),
                  50.ph()
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
                    image: AssetImage(AppAssets.introSplash),
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
            ),


          ],
        )

    );
  }
}
