import 'package:flutter/material.dart';
// Import your screen files here
import '../features/auth/presentation/screens/EduInfoScreen.dart';
import '../features/auth/presentation/screens/congratulations_screen.dart';
import '../features/auth/presentation/screens/create_account_loading_screen.dart';
import '../features/auth/presentation/screens/create_new_password.dart';
import '../features/auth/presentation/screens/forgot_password.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/robot_intro.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import '../features/auth/presentation/screens/verification_code.dart';
import '../features/launch/presentation/screens/launch_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/lunch':
        return MaterialPageRoute(builder: (_) => const LunchScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/robot_intro':
        return MaterialPageRoute(builder: (_) => const RobotIntroScreen());
      case '/sign_up':
        return MaterialPageRoute(builder: (_) =>  SignUpScreen());
      case '/edu_info':
        return MaterialPageRoute(builder: (_) => const EduInfoScreen());
      case '/account_creation':
        return MaterialPageRoute(builder: (_) => const AccountCreationScreen());
      case '/account_creation_success':
        return MaterialPageRoute(builder: (_) => const AccountCreationSuccessScreen());
      case '/verification_code':
        return MaterialPageRoute(builder: (_) =>  VerificationCodeScreen());
      case '/forgot_password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case '/create_new_password':
        return MaterialPageRoute(builder: (_) =>  CreateNewPasswordScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
