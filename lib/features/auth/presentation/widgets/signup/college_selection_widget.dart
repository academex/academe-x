
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
    onTap: () => context.read<SignupCubit>().toggleExpanded(),
    child: Container(
      decoration: _dropdownDecoration,
      width: double.infinity,
      child: Column(
        children: [
          _buildHeader(context.read<SignupCubit>().state),
          if (context.read<SignupCubit>().state.isExpanded) ...[
            _buildDivider(),
            _buildCollegesList(context.read<SignupCubit>().state, context),
          ],
        ],
      ),
    ),
  );
}

Widget _buildHeader(AuthState state) {
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
Widget _buildCollegesList(AuthState state,BuildContext context) {
  AppLogger.success(state.colleges.toString());
  if(state.errorMessage !=null){
    // return ErrorStateWidget(onRetry: () async{
    //   await context.read<SignupCubit>().retry();
    //
    // },message: 'خطأ في التحميل',);
    return CompactErrorWidget(
      message: 'خطأ في التحميل',
      onRetry: () async{
        await context.read<SignupCubit>().retry();
      },
    );
  }
  else if(!state.isLoadingForCollege && state.colleges!=null){
    return Column(
        children: state.colleges!.map((college) {
          final isSelected = state.selectedCollege == college.collegeAr;
          return CollegeItem(
            state:state,
            college:  college.collegeAr!,
            collegeData:const CollegeData(icon: '', majors: []),
            isSelected: isSelected,
            selectedMajor: state.selectedCollege,
            onCollegeSelected: (college) {
              // AppLogger.success('mesdasssage');
              context.read<SignupCubit>().selectCollege(college);
              context.read<SignupCubit>().getMajorsByCollege(college);
              // context.read<SignupCubit>().selectIndex(selectionType: selectionType);
            },
            // onMajorSelected: (index) {
            //   // context.read<CollegeCubit>().selectMajorIndex(index);
            // },
          );
        }).toList()
    );
  }else if(state.isLoadingForCollege) {
    return const CollegeSelectionShimmer();
  }else{
    return CompactErrorWidget(
      message: 'خطأ في التحميل',
      onRetry: () async{
        await context.read<SignupCubit>().retry();

      },
    );
  }


  // var dummyListMajors= state.collegesData!.entries;
  //
  // return Column(
  //   children: state.colleges!.map((college) {
  //     final isSelected = state.selectedCollege == college.collegeAr;
  //     return CollegeItem(
  //       state:state,
  //       college: college.collegeAr!,
  //       collegeData: CollegeData(icon: 'icon', majors: []),
  //       isSelected: isSelected,
  //       selectedMajor: state.selectedCollege,
  //       onCollegeSelected: (college) {
  //         // AppLogger.success('mesdasssage');
  //         context.read<SignupCubit>().selectCollege(college);
  //         // context.read<SignupCubit>().selectIndex(selectionType: selectionType);
  //       },
  //       // onMajorSelected: (index) {
  //       //   // context.read<CollegeCubit>().selectMajorIndex(index);
  //       // },
  //     );
  //   }).toList(),
  // );
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