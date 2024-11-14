import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/tag_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagCubit extends Cubit<TagState> {
  TagCubit(super.initialState);
  final TagState _tagState = TagState(selectedTags: [MockData.tags.first]);
  late List<String> data;
  changeTagesSelected(List<bool> selectedTags) {
    data = [];
    for (int i = 0; i < selectedTags.length; i++) {
      if (selectedTags[i]) {
        data.add(MockData.tags[i]);
      }
    }
    emit(_tagState.copyWith(selectedTags: data));
  }
}
