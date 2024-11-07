import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';
import 'library_item.dart';

class LibrarySection extends StatelessWidget {
  final String icon;
  final String title;
  final List<LibraryItem> items;

  const LibrarySection({
    required this.icon,
    required this.title,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(icon),
            8.w.pw(),
            AppText(
              text: title,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        15.h.ph(),
        Column(
          children: items.map((item) => item).toList(),
        ),
      ],
    );
  }
}
