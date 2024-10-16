import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';

class ActionButton extends StatelessWidget {
  late String iconPath;
  late String count;
  ActionButton({
    super.key,
    required this.iconPath,
    required this.count
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.h),
      // alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
          color: const Color(0xffF7F7F8),
          borderRadius: BorderRadius.circular(10.r)
      ),
      width: 74.w,
      height: 42.h,
      child: IconButton(
        icon: Row(
          children: [
            Image.asset(
              iconPath,
              height: 17.h,
              width: 19.w,
            ),
            4.pw(),
            AppText(
              text: count,
              fontSize: 14.sp,
              color: const Color(0xff707281),
            )
          ],
        ),
        padding: EdgeInsets.zero,
        onPressed: () {},
      ),
    );
  }
}