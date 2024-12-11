// import 'package:academe_x/core/utils/extensions/auth_cache_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:academe_x/lib.dart';
//
//
// class AppRouter {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//       return MaterialPageRoute(builder: (_) => FutureBuilder<bool>(
//         future: getIt<HiveCacheManager>().isAuthenticated(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData && snapshot.data == true) {
//             return const HomeScreen();
//           }
//           return  LoginScreen();
//         },
//       ),);
//       case '/on_boarding':
//         return MaterialPageRoute(builder: (_) => const OnBoarding());
//
//       case '/home_screen':
//         return MaterialPageRoute(builder: (_) => const HomeScreen());
//       case '/login':
//         return MaterialPageRoute(builder: (_) =>  LoginScreen());
//       case '/robot_intro':
//         return MaterialPageRoute(builder: (_) => const RobotIntroScreen());
//       case '/sign_up':
//         return MaterialPageRoute(builder: (_) => SignUpScreen());
//       case '/account_creation':
//         return MaterialPageRoute(builder: (_) => const AccountCreationScreen());
//       case '/account_creation_success':
//         return MaterialPageRoute(
//             builder: (_) => const AccountCreationSuccessScreen());
//       case '/verification_code':
//         return MaterialPageRoute(
//             builder: (_) => const VerificationCodeScreen());
//       case '/forgot_password':
//         return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
//       case '/create_new_password':
//         return MaterialPageRoute(builder: (_) => CreateNewPasswordScreen());
//       case '/community_screen':
//         return MaterialPageRoute(builder: (_) =>  CommunityPage());
//         return MaterialPageRoute(builder: (_) => CreateNewPasswordScreen());
//
//       case '/privacy_policy_page':
//         return MaterialPageRoute(builder: (_) => const PrivacyPolicyPage());
//         return MaterialPageRoute(builder: (_) => const PrivacyPolicyPage());
//       case '/app_notification':
//         return MaterialPageRoute(builder: (_) =>  const AppNotification());
//       default:
//         return MaterialPageRoute(
//           builder: (_) => const Scaffold(
//             body: Center(child: Text('Page not found')),
//           ),
//         );
//     }
//   }
// }
