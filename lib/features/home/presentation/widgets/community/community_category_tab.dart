import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Single category tab item with selection state.
///
/// Displays a tab button that can be selected/unselected.
/// Used in the community header for category switching.
class CommunityCategoryTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  const CommunityCategoryTab({
    super.key,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: AlignmentDirectional.center,
          height: 43.h,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondary : Colors.white,
            borderRadius: BorderRadius.circular(10.w),
          ),
          child: AppText(
            text: title,
            fontSize: 14,
            color: isSelected ? Colors.white : AppColors.grey,
          ),
        ),
      ),
    );
  }
}
