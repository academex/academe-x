// enum LoginStatus { initial, loading, success, failure }
import 'package:academe_x/features/home/domain/entities/post/tag_entity.dart';

abstract class TagState {}

class InitTagState extends TagState {}

class SucsessTagState extends TagState {
  final List<TagEntity> selectedTags;
  SucsessTagState({required this.selectedTags});

  TagState copyWith({
    required List<TagEntity> selectedTags,
  }) {
    return SucsessTagState(selectedTags: selectedTags);
  }

  add(TagEntity tag) {
    selectedTags.add(tag);
  }

  remove(TagEntity tag) {
    selectedTags.remove(tag);
    // for(int i =0;i<selectedTags.length;i++){

    // }
  }
}
