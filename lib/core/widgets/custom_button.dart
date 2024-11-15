import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onPressed;
  final Color backgraoundColor;
  final Color borderColor;
  final bool wihtBorder;

  const CustomButton({
    super.key,
    required this.widget,
    required this.onPressed,
    this.wihtBorder = false,
    required this.backgraoundColor,
    this.borderColor = const Color(0xFF6D6D6D),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
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
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: widget);
  }
}
