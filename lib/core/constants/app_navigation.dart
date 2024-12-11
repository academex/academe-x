import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  static void goToHome(BuildContext context) {
    context.goNamed('home');
  }

  static void goToLogin(BuildContext context) {
    context.goNamed('login');
  }

  static void goToSignUp(BuildContext context) {
    context.goNamed('signUp');
  }

  static void goToCommunity(BuildContext context) {
    context.goNamed('community');
  }

  static void goToPost(BuildContext context, String postId) {
    context.goNamed('post', pathParameters: {'postId': postId});
  }

  static void goToPrivacyPolicy(BuildContext context) {
    context.goNamed('privacyPolicy');
  }

  static void goToAppNotification(BuildContext context) {
    context.goNamed('appNotification');
  }

  static void goToForgotPassword(BuildContext context) {
    context.goNamed('forgotPassword');
  }

  static void goToVerificationCode(BuildContext context) {
    context.goNamed('verificationCode');
  }

  static void goToCreateNewPassword(BuildContext context) {
    context.goNamed('createNewPassword');
  }

  static void goToAccountCreation(BuildContext context) {
    context.goNamed('accountCreation');
  }

  static void goToAccountCreationSuccess(BuildContext context) {
    context.goNamed('accountCreationSuccess');
  }

  // For replacing the current route
  static void replaceWithHome(BuildContext context) {
    context.pushReplacementNamed('home');
  }

  static void replaceWithLogin(BuildContext context) {
    context.pushReplacementNamed('login');
  }

  // For pushing new routes
  static void pushPost(BuildContext context, String postId) {
    context.pushNamed('post', pathParameters: {'postId': postId});
  }
}