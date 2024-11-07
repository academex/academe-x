import '../../../domain/entities/home/reaction_type.dart';

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
}