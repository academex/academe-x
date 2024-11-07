import 'dart:io';

import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';

class FileContainer extends StatelessWidget {
  final File file;
  const FileContainer({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 7.w),
      decoration: BoxDecoration(
        color: Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Color.fromRGBO(156, 163, 175, 0.44)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          11.pw(),
          const ImageIcon(AssetImage('assets/icons/pdf.png')),
          // Icon(Icons.picture_as_pdf_outlined, color: Colors.grey[700]),
          10.pw(),
          Expanded(
            child: AppText(
                text: basename(file.path),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),

          Container(
            height: 36.h,
            width: 68.w,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'قيد الرفع ',
                  style: TextStyle(fontSize: 7.5.sp, color: Colors.grey[600]),
                ),
                Text(
                  '84%',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
