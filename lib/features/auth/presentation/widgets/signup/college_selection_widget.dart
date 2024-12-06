
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../college_major/controller/cubit/college_majors_state.dart';
import 'college_item.dart';
import 'dropown_label.dart';


class CollegeSelectionWidget extends StatelessWidget {
  BuildContext ctx;
   CollegeSelectionWidget({super.key,required this.ctx});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollegeMajorsCubit,CollegeMajorsState>(
      buildWhen: (previous, current) => previous!=current,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DropdownLabel(),
            12.ph(),
            _buildDropdown(context,state),
          ],
        );
      },
    );
  }
}

Widget _buildDropdown(BuildContext context,CollegeMajorsState state) {
  return GestureDetector(
    onTap: () => context.read<CollegeMajorsCubit>().toggleExpanded(),
    child: Container(
      decoration: _dropdownDecoration,
      width: double.infinity,
      child: Column(
        children: [
          _buildHeader(state),
          if (state.isExpanded) ...[
            _buildDivider(),
            _buildCollegesList(state, context),
          ],
        ],
      ),
    ),
  );
}

Widget _buildHeader(CollegeMajorsState state) {
  return Builder(
    builder: (context) => Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.hp(2),
        horizontal: context.wp(3),
      ),
      child: Row(
        children: [
          Expanded(
            child: AppText(
              text: state.collegeAndMajor ?? 'قم باختيار الكلية',
              color: state.selectedCollege != null
                  ? const Color(0xFF565A62)
                  : const Color(0xFF949494),
              fontSize: context.isTablet ? 16 : 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(
            state.isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.grey.shade600,
            size: context.isTablet ? 28 : 24,
          ),
        ],
      ),
    ),
  );
}
Widget _buildCollegesList(CollegeMajorsState state,BuildContext context) {
  AppLogger.success('there is error ${state.errorMessage}');
  AppLogger.success('there is error ${state.colleges}');
  if(state.errorMessage !=null){
    return CompactErrorWidget(
      message: 'خطأ في التحميل',
      onRetry: () async{
        await context.read<CollegeMajorsCubit>().retry();
      },
    );
  }
  else if(!state.isLoadingForCollege && state.colleges!=null){
    return Column(
        children: state.colleges!.map((college) {
          final isSelected = state.selectedCollege == college.collegeEn;
          return CollegeItem(
            state:state,
            college:  college.collegeEn!,
            collegeData:const CollegeData(icon: '', majors: []),
            isSelected: isSelected,
            selectedMajor: state.selectedCollege,
            onCollegeSelected: (college) async{
              context.read<CollegeMajorsCubit>().selectCollege(college);
             await context.read<CollegeMajorsCubit>().loadMajors(collegeName: college);
            },
          );
        }).toList()
    );
  }
  else if(state.isLoadingForCollege) {
    return const CollegeSelectionShimmer();
  }
  else{
    return CompactErrorWidget(
      message: 'خطأ في التحميل',
      onRetry: () async{
        await context.read<CollegeMajorsCubit>().retry();

      },
    );
  }


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