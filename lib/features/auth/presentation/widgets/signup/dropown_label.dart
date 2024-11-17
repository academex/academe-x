import 'package:flutter/material.dart';
import 'package:academe_x/lib.dart';


class DropdownLabel extends StatelessWidget {
  const DropdownLabel();

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: 'الكلية',
      color: const Color(0xFF0F172A),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }
}