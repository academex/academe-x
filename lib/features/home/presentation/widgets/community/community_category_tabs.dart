import 'package:academe_x/features/home/presentation/widgets/community/community_category_tab.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Category switcher tabs (تطوير البرمجيات / جامعتي).
///
/// Displays two tabs for switching between different category views.
/// Currently extracted as-is, non-functional placeholder for future implementation.
class CommunityCategoryTabs extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String>? onCategoryChanged;

  const CommunityCategoryTabs({
    super.key,
    this.selectedCategory,
    this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      height: 55.h,
      width: context.wp(87),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Row(
        children: [
          CommunityCategoryTab(
            title: 'تطوير البرمجيات',
            isSelected: true,
            onTap: () => onCategoryChanged?.call('تطوير البرمجيات'),
          ),
          15.pw(),
          CommunityCategoryTab(
            title: 'جامعتي',
            isSelected: false,
            onTap: () => onCategoryChanged?.call('جامعتي'),
          ),
        ],
      ),
    );
  }
}
