import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildIconButton extends StatelessWidget {
  String iconPath; bool inScroll;
   BuildIconButton({required this.iconPath,required this.inScroll});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Image.asset(
        iconPath,
        height: 20.h,
        width: 20.w,
        color: inScroll ? Colors.black : Colors.white,
      ),
      padding: EdgeInsets.zero,
    );
  }
}
