import 'package:academe_x/features/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class ShowRepliesCubit extends Cubit<ShowRepliesState>{
  ShowRepliesCubit(
    super.initialState, {
    required this.postUseCase,
  });

  final PostUseCase postUseCase;

  change({required int postIndex,required bool visibility}){
    emit(ShowRepliesState(show: visibility, index: postIndex));
  }

  getReplies({required int commentId}) async {
    emit(state.copyWith(
      status: ReplyStatus.loading,
    ));
    final result = await postUseCase.getReplies(commentId: commentId);
    result.fold(
          (failure) async {
        emit(
          state.copyWith(
            status: ReplyStatus.failure,
            error: failure.message,
          ),
        );
      },
          (reply) {
            Logger().d(reply);
          emit(
            state.copyWith(
              status: ReplyStatus.success,
              replies:reply.data,
            ),
          );
      },
    );
  }

  createRely(
      {required int commentId, int? parentId, required String content}) async {
    Logger().d(content);
    final result = await postUseCase.createReply(
        content: content, commentId: commentId, parentId: parentId);
    result.fold(
      (failure) async {
        emit(
          state.copyWith(
            status: ReplyStatus.failure,
            error: failure.message,
          ),
        );
      },
      (reply) {
        if(state.replies != null){
          state.replies!.add(reply.data!);
          emit(
            state.copyWith(
              status: ReplyStatus.success,
              replies:state.replies,
            ),
          );
        }else{
          emit(
            state.copyWith(
              status: ReplyStatus.success,
              replies:[reply.data!],
            ),
          );
        }

      },
    );
  }
}
