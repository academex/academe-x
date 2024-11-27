// enum LoginStatus { initial, loading, success, failure }
import 'package:academe_x/features/home/domain/entities/create_post/tag.dart';
import 'package:academe_x/features/home/domain/entities/post/tag_entity.dart';

class TagState {
  final List<TagEntity> selectedTags;
  TagState({required this.selectedTags});

  TagState copyWith({
    required List<TagEntity> selectedTags,
  }) {
    return TagState(selectedTags: selectedTags);
  }
}
