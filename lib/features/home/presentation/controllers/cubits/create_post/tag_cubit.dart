import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/data/models/post/tag_model.dart';
import 'package:academe_x/features/home/domain/entities/post/tag_entity.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/tag_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagCubit extends Cubit<TagState> {
  TagCubit(super.initialState);
  final SucsessTagState _tagState = SucsessTagState(selectedTags: []);
  late List<TagEntity> data;
  changeTagesSelected(List<bool> selectedTags) {
    data = [];
    for (int i = 0; i < selectedTags.length; i++) {
      if (selectedTags[i]) {
        data.add(MockData.tags[i]);
      }
    }
    emit(_tagState.copyWith(selectedTags: data));
  }

  addTag(TagEntity tag) {
    emit(InitTagState());
    _tagState.add(tag);
    emit(_tagState);
  }

  removeTag(TagEntity tag) {
    emit(InitTagState());
    _tagState.remove(tag);
    emit(_tagState);
  }

  init(TagEntity tag) {
    emit(_tagState.copyWith(selectedTags: [tag]));
  }
}
