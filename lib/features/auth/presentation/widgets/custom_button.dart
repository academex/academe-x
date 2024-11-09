import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onPressed;
  final Color color;

  const CustomButton({
    Key? key,
    required this.widget,
    required this.onPressed,
    required this.color  ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12.h), backgroundColor: color,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: widget

    );
  }
}
