import 'package:academe_x/core/constants/app_colors.dart';
import 'package:academe_x/core/utils/extensions/sized_box_extension.dart';
import 'package:academe_x/core/widgets/app_text.dart';
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
// import 'package:academe_x/lib.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Individual major card with image and label.
///
/// Displays a major with its image and name in Arabic.
/// Shows visual feedback when selected.
class CommunityMajorItem extends StatelessWidget {
  final MajorEntity major;
  final bool isSelected;
  final VoidCallback onTap;

  const CommunityMajorItem({
    super.key,
    required this.major,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white
                  : AppColors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(10.w),
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: CachedNetworkImage(
                  imageUrl: major.photoUrl ?? '',
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
        12.ph(),
        AppText(
          text: major.majorAr ?? '',
          fontSize: 14,
          color: Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ],
    );
  }
}
