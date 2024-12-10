import 'package:academe_x/core/widgets/widgets.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_majors_state.dart';
import 'package:academe_x/features/home/home.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/tag_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';
import 'package:academe_x/features/college_major/data/models/major_model.dart';


class SelectableButtonGrid extends StatelessWidget {
  late final List<bool> _isSelected;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollegeMajorsCubit, CollegeMajorsState>(
      buildWhen: (previous, current) {
        return previous.toString() == current.toString();
      },
        builder: (context, state) {
        if (state.status == MajorsStatus.loading) {
          return LoadingShimmerWidget();
        } else if (state.status == MajorsStatus.success) {

          _isSelected = List.generate(
            state.majors.length,
            (index) {
              if (index == 0) return true;
              return false;
            },
          );
          return Expanded(
            child: RawScrollbar(
              thumbVisibility: true,
              thumbColor: Colors.blue.shade100,
              shape: const StadiumBorder(),
              thickness: 6,
              scrollbarOrientation: ScrollbarOrientation.left,
              padding: const EdgeInsets.only(left: 0),
              //controller: PrimaryScrollController.of(context),
              ////controller: _wScrollController,
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
                      return GestureDetector(
                        onTap: () {
                          _isSelected[index] =!_isSelected[index]; // Toggle selection
                          if (_isSelected[index]) {
                            context.read<TagCubit>().addTag(state.majors[index]);
                          } else {
                            context
                                .read<TagCubit>()
                                .removeTag(state.majors[index]);
                          }
                        },
                        child: BlocBuilder<TagCubit, TagState>(

                          builder: (context, tagState) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.h, vertical: 8.w),
                              decoration: BoxDecoration(
                                color: _isSelected[index]
                                    ? Colors.blue
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Text(
                                '${state.majors[index].majorEn!}#'
                                    .replaceAll(' ', '_'),
                                style: TextStyle(
                                  color: _isSelected[index]
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ),
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
