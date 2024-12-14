// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ThemeCubit extends Cubit<ThemeMode> {
//   ThemeCubit() : super(ThemeMode.light);
//
//   void toggleTheme() {
//     final isDark = state == ThemeMode.dark;
//     emit(isDark ? ThemeMode.light : ThemeMode.dark);
//     StorageService.saveTheme(!isDark);
//   }
//
//   void loadTheme() {
//     final isDark = StorageService.getTheme();
//     emit(isDark ? ThemeMode.dark : ThemeMode.light);
//   }
// }
//
// class AppTheme {
//   static ThemeData light = ThemeData(
//     primaryColor: AppColors.primary,
//     scaffoldBackgroundColor: Colors.white,
//     // Add more theme data
//   );
//
//   static ThemeData dark = ThemeData(
//     primaryColor: AppColors.primary,
//     scaffoldBackgroundColor: Colors.black,
//     // Add more theme data
//   );
// }