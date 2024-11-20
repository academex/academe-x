// enum LoginStatus { initial, loading, success, failure }
import 'package:academe_x/features/home/domain/entities/create_post/tag.dart';

class TagState {
  final List<Tag> selectedTags;
  TagState({required this.selectedTags});

  TagState copyWith({
    required List<Tag> selectedTags,
  }) {
    return TagState(selectedTags: selectedTags);
  }
}
