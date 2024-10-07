import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(

      onPressed: onPressed,
      icon: Icon(
        Icons.g_mobiledata, // Placeholder for Google icon
        size: 24.sp,
        color: Colors.black54,
      ),
      label: Text(
        'حساب جوجل',
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black87,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
        side: BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
