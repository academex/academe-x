import 'dart:math';

import 'package:academe_x/academeX_main.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/auth/auth.dart';
import 'package:academe_x/features/home/data/models/post/comment_model.dart';
import 'package:academe_x/features/home/home.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import 'package:flutter/cupertino.dart';
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
  likeOnCommentOrReply({required int commentId,int? postId,int? replyId}) async {
    // emit(state.copyWith(
    //   status: ReplyStatus.loading,
    // ));
    final result = await postUseCase.likeOnCommentOrReply(commentId: commentId, postId: postId, replyId: replyId);
    result.fold(
          (failure) async {
            Logger().d('failure liked: ${failure.message}');
        emit(
          state.copyWith(
            // status: ReplyStatus.failure,
            errorLike: failure.message,
          ),

        );
      },
          (reply) {
            Logger().d('success liked');
          emit(
            state.copyWith(
                errorLike: '',
              // status: ReplyStatus.success,

            ),
          );
      },
    );
  }

  createRely({required int commentId, int? parentId, required String content, required BuildContext context}) async {
    UserResponseEntity user = (await NavigationService.navigatorKey.currentContext!.cachedUser)!.user;
    int random = Random().nextInt(100);
    Logger().d(random);
    context.read<PostsCubit>().increaseReplyCunt(commentId);
    // context.read<ShowRepliesCubit>().change(postIndex: commentId, visibility: true);
    Logger().d(content);
    CommentModel newReply = CommentModel(user: user,
        content: content,
        postId: random,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSending: true,
        likes: 0);
    if(state.replies != null){
      state.replies!.add(newReply);
      emit(
        state.copyWith(
          replies:state.replies,
        ),
      );
    }else {
      emit(
        state.copyWith(
          replies: [newReply],
        ),
      );
    }
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
        if(state.replies!.length == 1){
          state.replies!.addAll([reply.data!]);
          emit(
            state.copyWith(
              status: ReplyStatus.success,
              replies:state.replies,
            ),
          );
        }else{
          for(int i = 0; i < state.replies!.length; i++){
            if(state.replies![i].postId == random){
              state.replies![i] = reply.data!;
            }
          }
          emit(
            state.copyWith(
              status: ReplyStatus.success,
              replies:state.replies,
            ),
          );
        }

      },
    );
  }
}
