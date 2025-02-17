import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onPressed;
  final Color backgraoundColor;
  final Color borderColor;
  final bool wihtBorder;
  final bool disable;
  final double? height;

  const CustomButton({
    super.key,
    required this.widget,
    required this.onPressed,
    this.wihtBorder = false,
    this.disable = false,
    required this.backgraoundColor,
    this.borderColor = const Color(0xFF6D6D6D),
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: disable ? () {} : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          side: wihtBorder
              ? BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: borderColor,
                )
              : BorderSide.none,
          backgroundColor: backgraoundColor,
          minimumSize: Size(double.infinity, height ?? 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: widget);
  }
}
