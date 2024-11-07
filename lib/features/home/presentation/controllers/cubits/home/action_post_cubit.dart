import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/home/reaction_type.dart';
import '../../states/action_post_states.dart';

class ActionPostCubit extends Cubit<ActionPostState> {
  ActionPostCubit() : super(ActionPostState());

  void toggleDefaultReaction() {
    if (state.selectedReaction != null) {
      emit(state.copyWith(selectedReaction: null));
    } else {
      emit(state.copyWith(selectedReaction: ReactionType.like));
    }
  }

  void selectReaction(ReactionType reaction) {
    emit(state.copyWith(selectedReaction: reaction));
  }

  void performSaveAction(bool isSaved) {
    emit(state.copyWith(isSaved: isSaved));
  }
}