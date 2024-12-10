
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/tag_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/data/mock_posts.dart';

class TagCubit extends Cubit<TagState> {
  TagCubit(super.initialState);
  final SuccessTagState _tagState = SuccessTagState(selectedTags: []);
  late List<MajorEntity> data;
  changeTagesSelected(List<bool> selectedTags) {
    data = [];
    for (int i = 0; i < selectedTags.length; i++) {
      if (selectedTags[i]) {
        // data.add(MockData.tags[i]);
      }
    }
    emit(_tagState.copyWith(selectedTags: data));
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
    emit(_tagState.copyWith(selectedTags: [tag]));
  }
}
