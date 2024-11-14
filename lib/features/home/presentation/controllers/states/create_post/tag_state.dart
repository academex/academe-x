// enum LoginStatus { initial, loading, success, failure }
class TagState {
  final List<String> selectedTags;
  TagState({required this.selectedTags});

  TagState copyWith({
    required List<String> selectedTags,
  }) {
    return TagState(selectedTags: selectedTags);
  }
}
