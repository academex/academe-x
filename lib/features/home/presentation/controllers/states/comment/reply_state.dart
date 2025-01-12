// enum LoginStatus { initial, loading, success, failure }

import 'package:academe_x/features/auth/domain/entities/response/user_response_entity.dart';

class ReplyState{
  final UserResponseEntity? user;
  final int? commentId;

  ReplyState({this.user,this.commentId});
  ReplyState copyWith({
    UserResponseEntity? user,
    int? commentId,
  }){
    return ReplyState(
      user: user ?? this.user,
      commentId: commentId ?? this.commentId,
    );
  }
}