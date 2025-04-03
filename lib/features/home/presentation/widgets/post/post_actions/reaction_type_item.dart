import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/utils/reaction_type_utils.dart';

class ReactionTypeItem extends StatelessWidget {
  final String type;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const ReactionTypeItem({
    required this.type,
    required this.count,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: isSelected
            ? BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE8E8E8)),
        )
            : null,
        child: Row(
          children: [
            SvgPicture.asset(
              ReactionTypeUtils.getIconPath(type),
              width: 22,
              height: 22,
            ),
            8.pw(),
            AppText(
              text: count.toString(),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
