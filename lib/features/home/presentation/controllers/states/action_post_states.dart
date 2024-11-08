import 'package:academe_x/lib.dart';

class ActionPostState {
  final bool isSaved;
  final ReactionType? selectedReaction;

  ActionPostState({
    this.isSaved = false,
    this.selectedReaction,
  });

  ActionPostState copyWith({
    bool? isSaved,
    ReactionType? selectedReaction,
  }) {
    return ActionPostState(
      isSaved: isSaved ?? this.isSaved,
      selectedReaction: selectedReaction,
    );
  }


  ActionPostState changeSelect({
    bool? isSaved,
  }) {
    return ActionPostState(
      isSaved: isSaved ?? this.isSaved,
    );
  }
}