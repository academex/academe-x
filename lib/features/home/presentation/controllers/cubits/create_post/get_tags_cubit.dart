import 'package:academe_x/features/home/domain/usecases/get_tags_use_case.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/get_tags_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetTagsCubit extends Cubit<GetTagsState> {
  GetTagsUseCase getTagsUseCase;
  GetTagsCubit(super.initialState, {required this.getTagsUseCase});
  getTags() async {
    emit(GetTagsLoading());
    var createPostRes = await getTagsUseCase.getTags();
    createPostRes.fold(
      (l) {
        emit(GetTagsError(errorMessage: l.message));
      },
      (r) {
        emit(GetTagsSuccessful(tags: r));
      },
    );
  }
}
