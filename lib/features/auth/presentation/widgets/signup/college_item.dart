import 'package:flutter/material.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final String? selectedMajor;
  final Function(String) onCollegeSelected;

  const CollegeItem({
    required this.college,
    required this.collegeData,
    required this.isSelected,
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
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount =SizeConfig().getCrossAxisCount(context) ;
        double itemHeight = SizeConfig().getItemHeight(context);
        int rowCount = (collegeData.majors.length / crossAxisCount).ceil();
        double gridHeight = rowCount * itemHeight;

        return SizedBox(
          height: gridHeight,
          child: ShowGridViewItem(
            crossAxisCount: crossAxisCount,
            data: collegeData.majors,
            onTap: (index) {
              ctx.read<SignupCubit>().appendMajorToBaseVar(
                  collegeData.majors[index]
              );
              ctx.read<SignupCubit>().selectIndex(
                  index: index,
                  selectionType: SelectionType.major
              );
            },
            selectedIndex: ctx.read<SignupCubit>().state.selectedMajorIndex,
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