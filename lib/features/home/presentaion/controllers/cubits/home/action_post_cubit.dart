import 'package:flutter_bloc/flutter_bloc.dart';

import '../../states/action_post_states.dart';

class ActionPostCubit extends Cubit<ActionPostState> {
  ActionPostCubit() : super(ActionPostState(isLiked: false, isSaved: false));

  // Method to toggle the like state
  void performLikeAction(bool isLike) {
    emit(state.copyWith(isLiked: isLike));
  }

  // Method to toggle the save state
  void performSaveAction(bool isSave) {
    emit(state.copyWith(isSaved: isSave,));
  }
}
