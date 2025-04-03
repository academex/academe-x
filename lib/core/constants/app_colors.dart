import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFF1F02E8);
  static const Color secondary = Color(0xFF0077FF);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color background = Color(0xFFF5F5F5);

  // Reaction Colors
  static const Color heartReaction = Color(0xFFFF597B);
  static const Color celebrateReaction = Color(0xFF37B4AA);
  static const Color questionReaction = Color(0xFF6C5CE7);
  static const Color insightfulReaction = Color(0xFFFF8F3C);
  static const Color likeReaction = Color(0xFF2196F3);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFF9E9E9E);

  // Button Colors
  static const Color buttonPrimary = primary;
  static const Color buttonSecondary = Color(0xFF64748B);
  static const Color buttonDisabled = Color(0xFFBDBDBD);


  static const darkestBlue = Color(0xFF0A0B17);
  static const navyBlue = Color(0xFF0D1021);
  static const midnightBlue = Color(0xFF12162B);
  static const deepBlue = Color(0xFF161B35);
  static const deepIndigoBlue = Color(0xFF1A1F3F);

  // Gradient
  static const backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      darkestBlue,
      navyBlue,
      midnightBlue,
      deepBlue,
      deepIndigoBlue,
    ],
  );
}