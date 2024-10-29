import 'package:academe_x/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LibraryItem extends StatelessWidget {
  final String title;
  final String description;

  const LibraryItem({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xffE2E2E2)),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: title,
                    fontSize: 14.01.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  AppText(
                    text: description,
                    fontSize: 12.01.sp,
                    color: const Color(0xff64748B),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Container(
                height: 44.h,
                width: 44.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Image.asset(
                  'assets/icons/download_file.png',
                  height: 24.02.h,
                  width: 24.02.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
