import 'package:flutter_bloc/flutter_bloc.dart';

import '../../states/bottom_sheet/bottom_sheet_state.dart';

class BottomSheetCubit extends Cubit<BottomSheetState> {
  BottomSheetCubit({
    required double initialHeight,
    required double minHeight,
    required double maxHeight,
  }) : super(BottomSheetState.initial(
    initialHeight: initialHeight,
    minHeight: minHeight,
    maxHeight: maxHeight,
  ));

  void startDragging() {
    emit(state.copyWith(isDragging: true));
  }

  void stopDragging() {
    emit(state.copyWith(isDragging: false));
  }

  void updateHeight(double delta) {
    final newHeight = (state.currentHeight - delta)
        .clamp(state.minHeight, state.maxHeight);

    if (newHeight != state.currentHeight) {
      emit(state.copyWith(currentHeight: newHeight));
    }
  }

  void snapToHeight(double height) {
    final snappedHeight = height.clamp(state.minHeight, state.maxHeight);
    emit(state.copyWith(currentHeight: snappedHeight));
  }

  void resetHeight() {
    emit(state.copyWith(currentHeight: state.minHeight));
  }
}