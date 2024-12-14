
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/tag_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/data/mock_posts.dart';

class TagCubit extends Cubit<TagState> {
  TagCubit(super.initialState);
  SuccessTagState _tagState = SuccessTagState(selectedTags: []);
  late List<MajorEntity> data;
  changeTagsSelected(List<bool> selectedTags) {
    data = [];
    for (int i = 0; i < selectedTags.length; i++) {
      if (selectedTags[i]) {
        // data.add(MockData.tags[i]);
      }
    }
    _tagState = _tagState.copyWith(selectedTags: data);
    emit(_tagState);
  }

  addTag(MajorEntity tag) {
    emit(InitTagState());
    _tagState.add(tag);
    emit(_tagState);
  }

  removeTag(MajorEntity tag) {
    emit(InitTagState());
    _tagState.remove(tag);
    emit(_tagState);
  }

  init(MajorEntity tag) {
    _tagState = _tagState.copyWith(selectedTags: [tag]);
    emit(_tagState);
  }
}
