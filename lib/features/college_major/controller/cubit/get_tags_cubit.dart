import 'package:academe_x/features/college_major/controller/cubit/college_majors_state.dart';
import 'package:academe_x/features/home/domain/usecases/get_tags_use_case.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/get_tags_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetTagsCubit extends Cubit<CollegeMajorsState> {
  GetTagsUseCase getTagsUseCase;
  GetTagsCubit({required this.getTagsUseCase}):  super(const CollegeMajorsState());
  getTags() async {
    emit(state.copyWith(
      status: MajorsStatus.loading
    ));
    var createPostRes = await getTagsUseCase.getTags();
    createPostRes.fold(
      (l) {
        emit(state.copyWith(status: MajorsStatus.failure,
        errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: MajorsStatus.success,
            majors: r));
      },
    );
  }
}
