import 'package:academe_x/features/home/presentation/widgets/build_header_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildHeaderBackground extends StatelessWidget {
  bool inScroll;
   BuildHeaderBackground({required this.inScroll,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.81.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background_library.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: BuildHeaderContent(inScroll: inScroll),
    );
  }
}
