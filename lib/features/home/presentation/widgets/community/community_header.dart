import 'package:academe_x/core/utils/extensions/sized_box_extension.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_majors_state.dart';
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:academe_x/features/home/presentation/widgets/community/community_major_list.dart';
import 'package:academe_x/features/home/presentation/widgets/community/community_majors_section_header.dart';
import 'package:academe_x/features/home/presentation/widgets/header_widget.dart';
// import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';

/// Community page header with major selection.
///
/// Displays different content based on scroll state:
/// - When scrolled: Compact header with category tabs
/// - When expanded: Full header with majors list
///
/// Handles loading, error, and success states for majors.
class CommunityHeader extends StatelessWidget {
  final bool inScroll;
  final CollegeMajorsState state;

  const CommunityHeader({
    super.key,
    required this.inScroll,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state.status == MajorsStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.status == MajorsStatus.failure && state.majors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.errorMessage ?? 'Failed to load majors'),
            ElevatedButton(
              onPressed: () =>
                  context.read<CollegeMajorsCubit>().refreshMajors(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    } else if (state.status == MajorsStatus.success) {
      final title = state.selectedMajor != null
          ? '${state.selectedMajor!.majorAr!} | ${state.selectedMajor!.name!.toUpperCase()}'
          : 'Loading...';

      if (inScroll) {
        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: HeaderWidget(
                    inScroll: inScroll,
                    logoPath: 'assets/images/Frame.png',
                    title: 'تطوير البرمجيات',
                    subTitle: 'مجتمع مخصص لكل تساؤلاتك',
                    firstIconPath: 'assets/icons/search.png',
                    secondIconPath: 'assets/icons/notification.png',
                    onTap: () {},
                  ),
                ),
              ),           
            ],
          ),
        );
      } else {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  60.ph(),
                  HeaderWidget(
                    inScroll: inScroll,
                    logoPath: 'assets/images/Frame.png',
                    title: title,
                    subTitle: 'مجتمع مخصص لكل تساؤلاتك',
                    firstIconPath: 'assets/icons/search.png',
                    secondIconPath: 'assets/icons/notification.png',
                    onTap: () {},
                  ),
                  18.ph(),
                  CommunityMajorsSectionHeader(
                    isExpanded: state.isVisibileMajors,
                    onToggle: () =>
                        context.read<CollegeMajorsCubit>().toggleVisibleMajors(),
                  ),
                  12.ph(),
                ],
              ),
            ),
            if (state.isVisibileMajors)
              CommunityMajorList(
                majors: state.majors,
                selectedTag: state.selectedTag,
                onMajorSelected: (MajorEntity major) async {
                  context.read<CollegeMajorsCubit>().selectTag(major);
                  await context.read<PostsCubit>().loadTagPosts(tagId: major.id!);
                },
              )
            else
              0.ph(),
          ],
        );
      }
    } else {
      return const Text('data');
    }
  }
}
