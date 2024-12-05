import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/get_tags_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/tag_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/get_tags_state.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';

class SelectableButtonGrid extends StatelessWidget {
  // List to keep track of selected states
  late final List<bool> _isSelected;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetTagsCubit>(
      create: (context) => getIt<GetTagsCubit>()..getTags(),
      child: BlocBuilder<GetTagsCubit, GetTagsState>(builder: (context, state) {
        if (state is GetTagsLoading) {
          return LoadingShimmerWidget();
        } else if (state is GetTagsSuccessful) {
          context.read<TagCubit>().init(state.tags.first);
          _isSelected = List.generate(
            state.tags.length,
            (index) {
              if (index == 0) return true;
              return false;
            },
          );
          Logger().d(state.tags.toString());
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
                    spacing: 8.0, // Space between buttons horizontally
                    runSpacing: 8.0, // Space between buttons vertically
                    children: List.generate(state.tags.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          // setState(() {
                          _isSelected[index] =
                              !_isSelected[index]; // Toggle selection
                          if (_isSelected[index]) {
                            context.read<TagCubit>().addTag(state.tags[index]);
                          } else {
                            context
                                .read<TagCubit>()
                                .removeTag(state.tags[index]);
                          }
                          // context.read<TagCubit>().changeTagesSelected(_isSelected);
                          // });
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
                                '${state.tags[index].majorEn!}#'
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
        } else if (state is GetTagsError) {
          return AppText(
            text: state.errorMessage,
            fontSize: 12.sp,
            color: Colors.red,
          );
        } else {
          return SizedBox();
        }
      }),
    );
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
              children: List.generate(10, (index) {
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
