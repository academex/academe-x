import 'package:academe_x/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollegeCubit extends Cubit<CollegeState> {
  CollegeCubit() : super(const CollegeState());

  void toggleExpanded() {
    emit(state.copyWith(isExpanded: !state.isExpanded));

  }

  void selectCollege(String college) {
    emit(state.copyWith(
      selectedCollege: college,
    ));

  }

  void selectIndex({int? index,required SelectionType selectionType}) {
    selectionType == SelectionType.major? emit(state.copyWith(
      selectedMajorIndex: index,
      // isSelectedMajor: true
    )) :emit(state.copyWith(
      selectedSemesterIndex: index,
      // isSelectedMajor: true
    ));
  }

  void appendMajorToBaseVar(String major){
    emit(state.copyWith(
      collegeAndMajor:"${state.selectedCollege!} ($major) "
    ));
  }


  // String getSelectedCollege(String college){
  //   return
  // }
}