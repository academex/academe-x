// enum LoginStatus { initial, loading, success, failure }
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:equatable/equatable.dart';

abstract class TagState extends  Equatable{}

class InitTagState extends TagState   {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuccessTagState extends TagState{
  List<MajorEntity> selectedTags;
  SuccessTagState({required this.selectedTags});

  SuccessTagState copyWith({
    required List<MajorEntity> selectedTags,
  }) {
    return SuccessTagState(selectedTags: selectedTags);
  }

  add(MajorEntity tag) {
    selectedTags.add(tag);
  }

  remove(MajorEntity tag) {
    selectedTags.remove(tag);
    // for(int i =0;i<selectedTags.length;i++){

    // }
  }

  @override
  // TODO: implement props
  List<Object?> get props => [...selectedTags];



}
