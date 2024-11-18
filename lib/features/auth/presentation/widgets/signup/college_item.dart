import 'package:academe_x/features/auth/presentation/widgets/signup/show_grid_view_item.dart';
import 'package:flutter/material.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'college_selection_widget.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => onCollegeSelected(college),
        child: Container(
          decoration: isSelected ? _selectedItemDecoration : null,
          width: double.infinity,
          // height: isSelected ? 98 : 45,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              10.ph(),
              _buildCollegeRow(),
              if (isSelected) ...[
                10.75.ph(),
                _buildMajorsList(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollegeRow() {
    return Row(
      children: [
        AppText(
          text: collegeData.icon,
          color: const Color(0xFF565A62),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        6.pw(),
        AppText(
          text: college,
          color: const Color(0xFF565A62),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _buildMajorsList(BuildContext context,) {
    return SizedBox(
      height: 60,
      child: ShowGridViewItem(data: collegeData.majors,onTap:  (index) {

        context.read<CollegeCubit>().appendMajorToBaseVar(collegeData.majors[index]);
        context.read<CollegeCubit>().selectIndex(index,SelectionType.major);
      },selectedIndex: context.read<CollegeCubit>().state.selectedMajorIndex,),

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