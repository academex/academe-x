
import 'package:flutter/material.dart';
import 'package:academe_x/lib.dart';
class MajorItem extends StatelessWidget {
  final String major;
  final bool isSelected;
  final VoidCallback onSelected;

  const MajorItem({
    required this.major,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
        decoration: ShapeDecoration(
          color: const Color(0xFFF9F9F9),
          shape: RoundedRectangleBorder(
            side:  BorderSide(
              width: 0.80,
              color:isSelected?const Color(0xFF0077FF): const Color(0x38E1E1E1),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Center(
          child: AppText(
            text: major,
            color: const Color(0xFF686868),
            fontSize: 12.80,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
