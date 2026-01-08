import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_majors_state.dart';
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/core.dart';
import '../../controllers/cubits/create_post/create_post_cubit.dart';
import '../../controllers/states/create_post/create_post_state.dart';

class PostTagSelector extends StatelessWidget {
  const PostTagSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        if (!state.showTagSelector) {
          return const SizedBox();
        }

        return BlocBuilder<CollegeMajorsCubit, CollegeMajorsState>(
          builder: (context, majorsState) {
            if (majorsState.status == MajorsStatus.loading) {
              return _buildLoadingShimmer();
            }

            if (majorsState.status == MajorsStatus.failure) {
              return _buildError(majorsState.errorMessage);
            }

            if (majorsState.status == MajorsStatus.success) {
              return _buildTagGrid(context, state, majorsState.majors);
            }

            return const SizedBox();
          },
        );
      },
    );
  }

  Widget _buildTagGrid(
    BuildContext context,
    CreatePostState state,
    List<MajorEntity> allTags,
  ) {
    return Container(
      height: 300.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: RawScrollbar(
        thumbVisibility: true,
        thumbColor: Colors.blue.shade100,
        shape: const StadiumBorder(),
        thickness: 6,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: allTags.map((tag) {
              final isSelected = state.selectedTags.any((t) => t.id == tag.id);
              
              return _TagChip(
                tag: tag,
                isSelected: isSelected,
                onTap: () {
                  context.read<CreatePostCubit>().toggleTag(tag);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return Container(
      height: 300.h,
      padding: EdgeInsets.all(16.w),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: List.generate(
          12,
          (index) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 80.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildError(String? message) {
    return Container(
      height: 200.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48.r,
            color: Colors.red,
          ),
          12.ph(),
          AppText(
            text: message ?? 'فشل في تحميل التصنيفات',
            fontSize: 14.sp,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final MajorEntity tag;
  final bool isSelected;
  final VoidCallback onTap;

  const _TagChip({
    required this.tag,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0077FF) : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected 
                ? const Color(0xFF0077FF) 
                : const Color(0xFFD1D5DB),
          ),
        ),
        child: AppText(
          text: '#${tag.name}',
          fontSize: 14.sp,
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );
  }
}