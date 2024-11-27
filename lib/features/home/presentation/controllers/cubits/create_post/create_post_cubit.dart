import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/home/domain/usecases/create_post_use_case.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostUseCase createPostUseCase;
  CreatePostCubit(super.initialState, {required this.createPostUseCase});
  sendPost({required PostEntity post}) async {
    Logger().d(post);
    emit(SendingState());
    var createPostRes = await createPostUseCase.createPost(post);
    createPostRes.fold(
      (l) {
        emit(FailureState(errorMessage: l.message));
      },
      (r) {
        emit(SuccessState(postReqEntity: r));
      },
    );
  }
}
