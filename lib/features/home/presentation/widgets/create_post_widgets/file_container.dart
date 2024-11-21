import 'dart:io';

import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';

class FileContainer extends StatelessWidget {
  final File? file;
  final String? fileName;
  final String? fileUrl;
  const FileContainer({super.key, this.file, this.fileName, this.fileUrl});
  bool _fromCreatePost() {
    if (file != null) {
      return true;
    } else {
      return false;
    }
  }

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
          const ImageIcon(AssetImage('assets/icons/pdf.png'),
              color: Color(0xff9CA3AF)),
          10.pw(),
          Expanded(
            child: AppText(
                // text: basename(file.path),
                // fontSize: 14.sp,
                isUnderline: false,
                text: fileName ?? basename(file!.path),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff193648)),
          ),
          // Container(
          //   height: 36.h,
          //   width: 68.w,
          //   decoration: BoxDecoration(
          //       color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         'قيد الرفع ',
          //         style: TextStyle(fontSize: 7.5.sp, color: Colors.grey[600]),
          //       ),
          //       Text(
          //         '84%',
          //         style: TextStyle(
          //             fontSize: 12.sp,
          //             fontWeight: FontWeight.w600,
          //             color: Colors.black),
          //       ),
          //     ],
          //   ),
          // ),
          InkWell(
            onTap: !_fromCreatePost()
                ? () {
                    AppLogger.i('On Click Download');
                  }
                : null,
            child: Container(
              height: 36,
              width: 68,
              decoration: BoxDecoration(
                  color: _fromCreatePost()
                      ? Colors.white
                      : const Color(0xff0077ff),
                  borderRadius: BorderRadius.circular(10.r)),
              child: Visibility(
                visible: _fromCreatePost(),
                child: LoadingFile(
                  fromCreatePost: _fromCreatePost(),
                ),
                replacement: Center(
                    child: AppText(
                  text: 'تنزيل',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingFile extends StatelessWidget {
  final bool fromCreatePost;
  const LoadingFile({
    super.key,
    required this.fromCreatePost,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          fromCreatePost ? 'قيد الرفع' : 'قيد التنزيل',
          style: TextStyle(fontSize: 7.5.sp, color: Colors.grey[600]),
        ),
        4.pw(),
        Text(
          '84%',
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ],
    );
  }
}
