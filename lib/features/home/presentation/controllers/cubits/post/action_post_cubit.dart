import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/home/reaction_type.dart';
import '../../states/action_post_states.dart';

class ActionPostCubit extends Cubit<ActionPostState> {
  ActionPostCubit() : super(ActionPostState());

  void toggleDefaultReaction() {
    if (state.selectedReaction != null) {
      emit(state.copyWith(selectedReaction: null,isSaved: state.isSaved,));
    } else {
      emit(state.copyWith(selectedReaction: ReactionType.heart,isSaved: state.isSaved,));
    }
  }


  void selectReaction(ReactionType reaction) {
    emit(state.copyWith(
      selectedReaction: reaction,
      isSaved: state.isSaved, // Preserve the saved state
    ));
  }

  void performSaveAction(bool isSaved) {
    emit(state.copyWith(
      isSaved: isSaved,
      selectedReaction: state.selectedReaction, // Preserve the reaction state
    ));
  }
}