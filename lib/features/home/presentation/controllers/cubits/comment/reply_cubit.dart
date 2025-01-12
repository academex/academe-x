import 'package:academe_x/features/auth/domain/entities/response/user_response_entity.dart';
import 'package:academe_x/features/home/presentation/controllers/states/comment/reply_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReplyCubit extends Cubit<ReplyState> {
  ReplyCubit(super.initialState);

  reply({required UserResponseEntity user,required int commentId}){
    emit(state.copyWith(user: user,commentId: commentId));
  }
  cancelReply(){
    emit(ReplyState(user: null));
    //
  }
}