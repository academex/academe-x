class ActionPostState {
  final bool isLiked;
  final bool isSaved;

  ActionPostState({
    required this.isLiked,
    required this.isSaved,
  });

  // Create a copyWith method to update specific fields in the state
  ActionPostState copyWith({
    bool? isLiked,
    bool? isSaved,
  }) {
    return ActionPostState(
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
