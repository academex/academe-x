import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(

      onPressed: onPressed,
      icon: Icon(
        Icons.g_mobiledata, // Placeholder for Google icon
        size: 24 ,
        color: Colors.black54,
      ),
      label: Text(
        'حساب جوجل',
        style: TextStyle(
          fontSize: 16 ,
          color: Colors.black87,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12   , horizontal: 20   ),
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10 ),
        ),
      ),
    );
  }
}
