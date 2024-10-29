import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildLogoContainer extends StatelessWidget {
  const BuildLogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: const BoxDecoration(
        color: Color(0xff007BFF),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Image.asset(
        'assets/icons/logo_library.png',
        height: 28.h,
        width: 28.w,
      ),
    );
  }
}
