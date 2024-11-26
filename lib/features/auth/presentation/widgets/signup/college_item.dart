import 'package:flutter/material.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'college_selection_widget.dart';
//
// class CollegeItem extends StatelessWidget {
//   final String college;
//   final CollegeData collegeData;
//   final bool isSelected;
//   final String? selectedMajor;
//   final Function(String) onCollegeSelected;
//
//   const CollegeItem({
//     required this.college,
//     required this.collegeData,
//     required this.isSelected,
//     required this.selectedMajor,
//     required this.onCollegeSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: InkWell(
//         onTap: () => onCollegeSelected(college),
//         child: Container(
//           decoration: isSelected ? _selectedItemDecoration : null,
//           width: double.infinity,
//           // height: isSelected ? 98 : 45,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Column(
//             children: [
//               10.ph(),
//               _buildCollegeRow(),
//               if (isSelected) ...[
//                 10.75.ph(),
//                 _buildMajorsList(context),
//
//
//               ],
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCollegeRow() {
//     return Row(
//       children: [
//         AppText(
//           text: collegeData.icon,
//           color: const Color(0xFF565A62),
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//         ),
//         6.pw(),
//         AppText(
//           text: college,
//           color: const Color(0xFF565A62),
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//         ),
//       ],
//     );
//   }
//
//   // Widget _buildMajorsList(BuildContext context,) {
//   //
//   //   return SizedBox(
//   //     height: (((collegeData.majors.length)/4).ceil() *(52)),
//   //     child: ShowGridViewItem(data: collegeData.majors,onTap:  (index) {
//   //
//   //       context.read<CollegeCubit>().appendMajorToBaseVar(collegeData.majors[index]);
//   //       context.read<CollegeCubit>().selectIndex(index: index,selectionType: SelectionType.major);
//   //     },selectedIndex: context.read<CollegeCubit>().state.selectedMajorIndex,),
//   //
//   //   );
//   // }
//
//   Widget _buildMajorsList(BuildContext context) {
//     // Calculate number of columns based on orientation and screen width
//     int crossAxisCount = MediaQuery.of(context).orientation == Orientation.portrait
//         ? 4  // Portrait: 4 columns
//         : 6; // Landscape: 6 columns
//
//     // Calculate item height based on orientation
//     double itemHeight = MediaQuery.of(context).orientation == Orientation.portrait
//         ? 44.0
//         : 55.0;
//
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         int rowCount = (collegeData.majors.length / crossAxisCount).ceil();
//         double gridHeight = rowCount * itemHeight;
//
//         return SizedBox(
//           height: gridHeight,
//           child: ShowGridViewItem(
//             crossAxisCount: crossAxisCount, // Add this parameter to your ShowGridViewItem
//             data: collegeData.majors,
//             onTap: (index) {
//               context.read<CollegeCubit>().appendMajorToBaseVar(collegeData.majors[index]);
//               context.read<CollegeCubit>().selectIndex(
//                   index: index,
//                   selectionType: SelectionType.major
//               );
//             },
//             selectedIndex: context.read<CollegeCubit>().state.selectedMajorIndex!,
//           ),
//         );
//       },
//     );
//   }
//
//   ShapeDecoration get _selectedItemDecoration => ShapeDecoration(
//     color: const Color(0xffFFFFFF),
//     shape: RoundedRectangleBorder(
//       side: const BorderSide(
//         width: 0.50,
//         strokeAlign: BorderSide.strokeAlignCenter,
//         color: Color(0xFFE1E1E1),
//       ),
//       borderRadius: BorderRadius.circular(6),
//     ),
//     shadows: const [
//       BoxShadow(
//         color: Color(0x0A000000),
//         blurRadius: 16,
//         offset: Offset(0, 4),
//         spreadRadius: 0,
//       )
//     ],
//   );
// }


class CollegeItem extends StatelessWidget {
  final String college;
  final CollegeData collegeData;
  final bool isSelected;
  final AuthState state;
  final String? selectedMajor;

  final Function(String) onCollegeSelected;

  const CollegeItem({
    required this.college,
    required this.collegeData,
    required this.isSelected,
    required this.state,
    required this.selectedMajor,
    required this.onCollegeSelected,
  });

  @override
  Widget build(BuildContext context) {

    return ResponsiveContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.hp(1.2)),
        child: InkWell(
          onTap: () => onCollegeSelected(college),
          child: Container(
            decoration: isSelected ? _selectedItemDecoration : null,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: context.wp(3)),
            child: Column(
              children: [
                SizedBox(height: context.hp(1.2)),
                _buildCollegeRow(context),
                if (isSelected) ...[
                  SizedBox(height: context.hp(1.3)),
                  _buildMajorsList(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );


  }

  Widget _buildCollegeRow(BuildContext context) {
    return Row(
      children: [
        AppText(
          text: collegeData.icon,
          color: const Color(0xFF565A62),
          fontSize: context.isTablet ? 18 : 16,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(width: context.wp(1.5)),
        AppText(
          text: college,
          color: const Color(0xFF565A62),
          fontSize: context.isTablet ? 16 : 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _buildMajorsList(BuildContext ctx) {
    return ctx.read<SignupCubit>().state.isLoadingForMajors || ctx.read<SignupCubit>().state.isLoadingForCollege?  LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = SizeConfig().getCrossAxisCount(context);
        double itemHeight = SizeConfig().getItemHeight(context);
        int rowCount = (10 / crossAxisCount).ceil(); // Assuming 10 shimmer items
        double gridHeight = rowCount * itemHeight;

        return SizedBox(
          height: gridHeight,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2.5 : 3.0,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 10,
            itemBuilder: (context, index) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                height: 56,
                width: 80,
              ),
            ),
          ),
        );
      },
    )
        : LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount =SizeConfig().getCrossAxisCount(context) ;
        double itemHeight = SizeConfig().getItemHeight(context);
        int rowCount = (ctx.read<SignupCubit>().state.majors!.length / crossAxisCount).ceil();
        double gridHeight = rowCount * itemHeight;

        return SizedBox(
          height: gridHeight,
          child: ShowGridViewItem<MajorEntity>(
            crossAxisCount: crossAxisCount,
            data: ctx.read<SignupCubit>().state.majors!,
            onTap: (index,majorEntity) {
              AppLogger.success( majorEntity.id!.toString());
              ctx.read<SignupCubit>().appendMajorToBaseVar(
                  ctx.read<SignupCubit>().state.majors![index].name!
              );
              ctx.read<SignupCubit>().selectTagId(
                tagId: majorEntity.id!,
              );
              ctx.read<SignupCubit>().selectIndex(
                  index: index,
                  selectionType: SelectionType.major
              );
            },
            selectedIndex: ctx.read<SignupCubit>().state.selectedMajorIndex,
            displayTextBuilder: (p0)=>p0.majorAr!
          ),
        );
      },
    );
  }



  ShapeDecoration get _selectedItemDecoration => ShapeDecoration(
    color: const Color(0xffFFFFFF),
    shape: RoundedRectangleBorder(
      side: const BorderSide(
        width: 0.50,
        strokeAlign: BorderSide.strokeAlignCenter,
        color: Color(0xFFE1E1E1),
      ),
      borderRadius: BorderRadius.circular(6),
    ),
    shadows: const [
      BoxShadow(
        color: Color(0x0A000000),
        blurRadius: 16,
        offset: Offset(0, 4),
        spreadRadius: 0,
      )
    ],
  );
}

class CollegeListShimmer extends StatelessWidget {
  const CollegeListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5, // Show 5 college items
      itemBuilder: (context, index) {
        // Make the first item expanded to show how it looks
        return CollegeItemShimmer(isExpanded: index == 0);
      },
    );
  }
}

class ErrorStateWidget extends StatelessWidget {
  final String? message;
  final VoidCallback onRetry;
  final String? retryButtonText;
  final IconData? icon;
  final bool showRetryButton;

  const ErrorStateWidget({
    super.key,
    this.message,
    required this.onRetry,
    this.retryButtonText,
    this.icon,
    this.showRetryButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.wp(4),
            vertical: context.hp(2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Error Icon
              Icon(
                icon ?? Icons.error_outline_rounded,
                size: context.isTablet ? 80 : 64,
                color: Theme.of(context).colorScheme.error.withOpacity(0.8),
              ),

              SizedBox(height: context.hp(2)),

              // Error Message
              AppText(
                text: message ?? 'context.localizations.generalErrorMessage',
                fontSize: context.isTablet ? 18 : 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                textAlign: TextAlign.center,
              ),

              if (showRetryButton) ...[
                SizedBox(height: context.hp(3)),

                // Retry Button
                CustomButton(
                  onPressed: onRetry,
                  widget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh_rounded,
                        size: context.isTablet ? 24 : 20,
                        color: Colors.white,
                      ),
                      SizedBox(width: context.wp(2)),
                      AppText(
                        text: retryButtonText ?? 'context.localizations.retryButton',
                        fontSize: context.isTablet ? 16 : 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  backgraoundColor: Theme.of(context).primaryColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Variant for no data state
class NoDataWidget extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final VoidCallback? onAction;
  final String? actionButtonText;

  const NoDataWidget({
    super.key,
    this.message,
    this.icon,
    this.onAction,
    this.actionButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.wp(4),
            vertical: context.hp(2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon ?? Icons.inbox_rounded,
                size: context.isTablet ? 80 : 64,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              ),

              SizedBox(height: context.hp(2)),

              AppText(
                text: message ?? 'context.localizations.noDataMessage',
                fontSize: context.isTablet ? 18 : 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                textAlign: TextAlign.center,
              ),

              if (onAction != null) ...[
                SizedBox(height: context.hp(3)),

                CustomButton(
                  onPressed: () {

                  },
                  widget: AppText(
                    text: actionButtonText ?? 'context.localizations.tryAgainButton',
                    fontSize: context.isTablet ? 16 : 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  backgraoundColor: Theme.of(context).primaryColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Compact error widget for smaller spaces
class CompactErrorWidget extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const CompactErrorWidget({
    super.key,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.wp(4),
        vertical: context.hp(1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: context.isTablet ? 24 : 20,
            color: Theme.of(context).colorScheme.error,
          ),
          SizedBox(width: context.wp(2)),
          Expanded(
            child: AppText(
              text: message ?? 'context.localizations.generalErrorMessage',
              fontSize: context.isTablet ? 14 : 12,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(width: context.wp(2)),
            IconButton(
              onPressed: onRetry,
              icon: Icon(
                Icons.refresh_rounded,
                size: context.isTablet ? 24 : 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
class CollegeItemShimmer extends StatelessWidget {
  final bool isExpanded;

  const CollegeItemShimmer({
    super.key,
    this.isExpanded = false,
  });
  ShapeDecoration get _selectedItemDecoration => ShapeDecoration(
    color: const Color(0xffFFFFFF),
    shape: RoundedRectangleBorder(
      side: const BorderSide(
        width: 0.50,
        strokeAlign: BorderSide.strokeAlignCenter,
        color: Color(0xFFE1E1E1),
      ),
      borderRadius: BorderRadius.circular(6),
    ),
    shadows: const [
      BoxShadow(
        color: Color(0x0A000000),
        blurRadius: 16,
        offset: Offset(0, 4),
        spreadRadius: 0,
      )
    ],
  );

  // ShapeDecoration get _selectedItemDecoration => ShapeDecoration(
  //   color: const Color(0xffFFFFFF),
  //   shape: RoundedRectangleBorder(
  //     side: const BorderSide(
  //       width: 0.50,
  //       strokeAlign: BorderSide.strokeAlignCenter,
  //       color: Color(0xFFE1E1E1),
  //     ),
  //     borderRadius: BorderRadius.circular(6),
  //   ),
  //   shadows: const [
  //     BoxShadow(
  //       color: Color(0x0A000000),
  //       blurRadius: 16,
  //       offset: Offset(0, 4),
  //       spreadRadius: 0,
  //     )
  //   ],
  // );
  @override
  Widget build(BuildContext context) {

    return ResponsiveContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.hp(1.2)),
        child: Container(
          decoration: isExpanded ? _selectedItemDecoration : null,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: context.wp(3)),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                SizedBox(height: context.hp(1.2)),
                _buildCollegeRowShimmer(context),
                if (isExpanded) ...[
                  SizedBox(height: context.hp(1.3)),
                  _buildMajorsListShimmer(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMajorsListShimmer(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = SizeConfig().getCrossAxisCount(context);
        double itemHeight = SizeConfig().getItemHeight(context);
        // Assuming 6 majors for shimmer effect
        int rowCount = (6 / crossAxisCount).ceil();
        double gridHeight = rowCount * itemHeight;

        return SizedBox(
          height: gridHeight,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 2.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 6, // Show 6 shimmer items
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              );
            },
          ),
        );
      },
    );


  }

  Widget _buildCollegeRowShimmer(BuildContext context) {
    return Row(
      children: [
        // Icon shimmer
        Container(
          width: context.isTablet ? 24 : 20,
          height: context.isTablet ? 24 : 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: context.wp(1.5)),
        // College name shimmer
        Container(
          width: context.wp(30),
          height: context.isTablet ? 20 : 16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

}

class CollegeSelectionShimmer extends StatelessWidget {
  const CollegeSelectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title shimmer
        // Shimmer.fromColors(
        //   baseColor: Colors.grey[300]!,
        //   highlightColor: Colors.grey[100]!,
        //   child: Container(
        //     width: context.wp(30),
        //     height: context.isTablet ? 24 : 20,
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(4),
        //     ),
        //   ),
        // ),
        // SizedBox(height: context.hp(2)),

        // List of college items with shimmer effect
        const CollegeListShimmer(),
      ],
    );
  }
}




