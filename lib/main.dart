import 'package:academe_x/features/launch/presentation/screens/launch_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/robot_intro.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     systemNavigationBarColor: Colors.transparent,
    //     statusBarColor: Colors.transparent,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //   ),
    // );
    return ScreenUtilInit(
      designSize: const Size(
          375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(

          title: 'AcademeX',
          locale: const Locale('ar'), // Set the locale to Arabic
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ar', ''),
            Locale('ar', 'IQ'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: GoogleFonts.cairo().fontFamily,
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.white),
          ),
          initialRoute: '/login',
          routes: {
            '/lunch': (context) => const LunchScreen(),
            '/login': (context) => const LoginScreen(),
            '/robot_intro': (context) => const RobotIntroScreen(),
            // '/verification_code': (context) =>  VerificationCode(),
            // '/forgot_Password': (context) =>  const ForgotPassword(),
          },
        );
      },
    );
  }
}
