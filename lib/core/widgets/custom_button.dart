import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onPressed;
  final Color color;
  final bool wihtBorder;



  const CustomButton({
    super.key,
    required this.widget,
    required this.onPressed,
    this.wihtBorder= false,
    required this.color  ,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: wihtBorder? const BorderSide(
          color: Colors.white
        ) : BorderSide.none,
        padding: EdgeInsets.symmetric(vertical: 12.h), backgroundColor: color,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),

        ),
      ),
      child: widget

    );
  }
}
