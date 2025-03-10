import 'package:academe_x/features/library/domain/entities/library_entity.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LibraryItem extends StatelessWidget {
  final LibraryEntity file;


  const LibraryItem({
    required this.file,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
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
                    text: file.name!,
                    fontSize: 14.01,
                    color: Color(0xff0F172A),
                    fontWeight: FontWeight.w500,
                  ),
                  AppText(
                    text:  file.description! ?? '',
                    fontSize: 12.01,
                    color: Color(0xff64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(
                  'assets/icons/download_file.png',
                  height: 24.02,
                  width: 24.02,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
