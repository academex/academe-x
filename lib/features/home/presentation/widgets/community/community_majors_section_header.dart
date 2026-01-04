import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';

/// "التخصصات" section header with expand/collapse toggle.
///
/// Displays the majors section title with a toggle button
/// to show or hide the full list of majors.
class CommunityMajorsSectionHeader extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;

  const CommunityMajorsSectionHeader({
    super.key,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(
          text: 'التخصصات',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        const Spacer(),
        InkWell(
          onTap: onToggle,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: AppText(
              text: isExpanded ? 'عرض اقل' : 'عرض المزيد',
              fontWeight: FontWeight.w500,
              onPressed: onToggle,
              fontSize: 12,
              color: Colors.white.withOpacity(0.66),
            ),
          ),
        ),
      ],
    );
  }
}
