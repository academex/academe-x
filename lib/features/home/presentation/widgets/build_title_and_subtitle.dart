import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';

class BuildTitleAndSubtitle extends StatelessWidget {
  bool inScroll;
   BuildTitleAndSubtitle({required this.inScroll,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'مكتبتي',
          fontSize: 16.sp,
          color: inScroll ? Colors.black : Colors.white,
          fontWeight: FontWeight.w600,
        ),
        if (!inScroll) ...[
          // 6.ph(),
          AppText(
            text: 'كل ما تحتاجه من كتب وملخصات وشباتر',
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ],
      ],
    );
  }
}
