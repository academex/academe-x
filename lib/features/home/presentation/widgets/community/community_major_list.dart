import 'package:academe_x/core/utils/extensions/context_extenssion.dart';
import 'package:academe_x/core/utils/extensions/sized_box_extension.dart';
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:academe_x/features/home/presentation/widgets/community/community_major_item.dart';
// import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';

/// Horizontal scrolling list of college majors.
///
/// Displays a scrollable row of major items with selection state.
/// Only visible when isVisible is true.
class CommunityMajorList extends StatelessWidget {
  final List<MajorEntity> majors;
  final String? selectedTag;
  final Function(MajorEntity) onMajorSelected;

  const CommunityMajorList({
    super.key,
    required this.majors,
    this.selectedTag,
    required this.onMajorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 24),
      height: context.hp(12.3),
      child: ListView.separated(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final major = majors[index];
          final isSelected = major.name == selectedTag;

          return CommunityMajorItem(
            major: major,
            isSelected: isSelected,
            onTap: () => onMajorSelected(major),
          );
        },
        separatorBuilder: (context, index) => 10.pw(),
        itemCount: majors.length,
      ),
    );
  }
}
