
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'college_item.dart';
import 'dropown_label.dart';


class CollegeSelectionWidget extends StatelessWidget {
  BuildContext ctx;
   CollegeSelectionWidget({super.key,required this.ctx});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const DropdownLabel(),
        12.ph(),
        _buildDropdown(ctx),
      ],
    );
  }
}


Widget _buildDropdown(BuildContext context) {
  return GestureDetector(
    onTap: () {
      context.read<CollegeCubit>().toggleExpanded();
    },

    child: Container(
        decoration: _dropdownDecoration,
        width: double.infinity,
        child: Column(
          children: [
            _buildHeader(context.read<CollegeCubit>().state),
            if (context.read<CollegeCubit>().state.isExpanded) ...[
              _buildDivider(),
              _buildCollegesList(context.read<CollegeCubit>().state,context),
            ],
          ],
        )
    ),
  );
}

Widget _buildHeader(CollegeState state) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 12),
    child: Row(
      children: [
        Expanded(
          child: AppText(
            text: state.collegeAndMajor ?? 'قم باختيار الكلية',
            color: state.selectedCollege != null
                ? const Color(0xFF565A62)
                : const Color(0xFF949494),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Icon(
          state.isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: Colors.grey.shade600,
        ),
      ],
    ),
  );
}

Widget _buildCollegesList(CollegeState state,BuildContext context) {
  return Column(
    children: state.collegesData.entries.map((entry) {
      final isSelected = state.selectedCollege == entry.key;
      return CollegeItem(
        college: entry.key,
        collegeData: entry.value,
        isSelected: isSelected,
        selectedMajor: state.selectedCollege,
        onCollegeSelected: (college) {
          context.read<CollegeCubit>().selectCollege(college);
        },
        // onMajorSelected: (index) {
        //   // context.read<CollegeCubit>().selectMajorIndex(index);
        // },
      );
    }).toList(),
  );
}

Widget _buildDivider() {
  return const Divider(
    indent: 12,
    endIndent: 12,
    color: Color(0x54D9D9D9),
    thickness: 1,
  );
}

ShapeDecoration get _dropdownDecoration => ShapeDecoration(
  color: const Color(0xFFF9F9F9),
  shape: RoundedRectangleBorder(
    side: const BorderSide(
      width: 1,
      strokeAlign: BorderSide.strokeAlignCenter,
      color: Color(0x38D9D9D9),
    ),
    borderRadius: BorderRadius.circular(12),
  ),
);