import 'package:academe_x/core/widgets/widgets.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_majors_state.dart';
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:academe_x/features/home/home.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/tag_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';


class SelectableButtonGrid extends StatelessWidget {
  // late List<bool> _isSelected;
  final int userTagId;
  SelectableButtonGrid({super.key,required this.userTagId});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollegeMajorsCubit, CollegeMajorsState>(
      buildWhen: (previous, current) {
        return previous.toString() != current.toString();
      },
        builder: (context, state) {
        if (state.status == MajorsStatus.loading) {
          return LoadingShimmerWidget();
        } else if (state.status == MajorsStatus.success) {
          return RawScrollbar(
            thumbVisibility: true,
            thumbColor: Colors.blue.shade100,
            shape: const StadiumBorder(),
            thickness: 6,
            scrollbarOrientation: ScrollbarOrientation.left,
            padding: const EdgeInsets.only(left: 0),

            minThumbLength: 100,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  /// start: This is place that
                  /// - display the tags
                  /// - select tags
                  children: List.generate(state.majors.length, (index) {
                    return BlocBuilder<TagCubit, TagState>(
                        // buildWhen: (previous, current) => current is SuccessTagState,
                        builder: (context, tagState) {
                          Logger().f(tagState);
                            if (tagState is SuccessTagState) {

                              return GestureDetector(
                                onTap: () {
                                  // Logger().d(tagState.selectedTags.toString() +'/'+state.majors[index].id.toString()+'/'+isSelectedTag(major: state.majors[index], tags: tagState.selectedTags).toString());
                                  if (!isSelectedTag(major: state.majors[index], tags: tagState.selectedTags)) {
                                    context.read<TagCubit>().addTag(state.majors[index]);
                                  } else {
                                    context
                                        .read<TagCubit>()
                                        .removeTag(state.majors[index]);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.h, vertical: 8.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelectedTag(major: state.majors[index],
                                        tags: tagState.selectedTags)
                                        ? Colors.blue
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: Text(
                                    '${state.majors[index].name!}#',
                                    style: TextStyle(
                                      color: isSelectedTag(major: state.majors[index], tags: tagState.selectedTags)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          },

                      );
                    
                  }),
                ),
              ),
            ),
          );
        } else if (state.status == MajorsStatus.failure) {
          return AppText(
            text: state.errorMessage!,
            fontSize: 12.sp,
            color: Colors.red,
          );
        } else {
          return SizedBox();
        }
      },);

  }

  bool isSelectedTag({required MajorEntity major, required List<MajorEntity> tags}) {
    for(int i =0;i<tags.length;i++){
      if(major.id == tags[i].id){
        return true;
      }
    }
    return false;
  }
}

class LoadingShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawScrollbar(
        thumbVisibility: true,
        thumbColor: Colors.blue.shade100,
        shape: const StadiumBorder(),
        thickness: 6,
        scrollbarOrientation: ScrollbarOrientation.left,
        padding: const EdgeInsets.only(left: 0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8.0, // Space between shimmer items horizontally
              runSpacing: 8.0, // Space between shimmer items vertically
              children: List.generate(6, (index) {
                // Example shimmer count
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 80.w, // Adjust size as needed
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
