import 'package:flutter/material.dart';
<<<<<<< HEAD
class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});
=======
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({Key? key, required this.onPressed}) : super(key: key);
>>>>>>> 536135a (Description of changes)

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(

      onPressed: onPressed,
      icon: Icon(
        Icons.g_mobiledata, // Placeholder for Google icon
<<<<<<< HEAD
        size: 24 ,
=======
        size: 24.sp,
>>>>>>> 536135a (Description of changes)
        color: Colors.black54,
      ),
      label: Text(
        'حساب جوجل',
        style: TextStyle(
<<<<<<< HEAD
          fontSize: 16 ,
=======
          fontSize: 16.sp,
>>>>>>> 536135a (Description of changes)
          color: Colors.black87,
        ),
      ),
      style: OutlinedButton.styleFrom(
<<<<<<< HEAD
        padding: EdgeInsets.symmetric(vertical: 12   , horizontal: 20   ),
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10 ),
=======
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
        side: BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
>>>>>>> 536135a (Description of changes)
        ),
      ),
    );
  }
}
