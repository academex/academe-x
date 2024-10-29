import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';

class BuildCategoryTab extends StatelessWidget {
  late String title;

  late bool isSelected;
   BuildCategoryTab({required this.title, this.isSelected=false});

  @override
  Widget build(BuildContext context) {
  return Expanded(
  child: Container(
  alignment: AlignmentDirectional.center,
  height: 43.h,
  decoration: BoxDecoration(
  color: isSelected ? const Color(0xff2769F2) : Colors.white,
  borderRadius: BorderRadius.circular(10.r),
  ),
  child: AppText(
  text: title,
  fontSize: 14.sp,
  color: isSelected ? Colors.white : Colors.grey,
  ),
  ),
  );
  }
}
