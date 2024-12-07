// enum LoginStatus { initial, loading, success, failure }
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';

abstract class TagState {}

class InitTagState extends TagState {}

class SucsessTagState extends TagState {
  final List<MajorEntity> selectedTags;
  SucsessTagState({required this.selectedTags});

  TagState copyWith({
    required List<MajorEntity> selectedTags,
  }) {
    return SucsessTagState(selectedTags: selectedTags);
  }

  add(MajorEntity tag) {
    selectedTags.add(tag);
  }

  remove(MajorEntity tag) {
    selectedTags.remove(tag);
    // for(int i =0;i<selectedTags.length;i++){

    // }
  }
}
