import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'build_category_type.dart';

class BuildCategoryTabs extends StatelessWidget {
  const BuildCategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
      height: 55.h,
      width: 327.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          BuildCategoryTab(title: 'تطوير البرمجيات', isSelected: true),
          15.pw(),
          BuildCategoryTab(title: 'جامعتي'),
        ],
      ),
    );
  }
}
