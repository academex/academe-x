// enum LoginStatus { initial, loading, success, failure }

import 'package:academe_x/features/auth/domain/entities/response/user_response_entity.dart';

class ReplyState{
  final UserResponseEntity? user;
  final int? commentId;
  final int? parentId;

  ReplyState({this.user,this.commentId,this.parentId});
  ReplyState copyWith({
    UserResponseEntity? user,
    int? commentId,
    int? parentId,
  }){
    return ReplyState(
      user: user ?? this.user,
      commentId: commentId ?? this.commentId,
      parentId: parentId ?? this.parentId,
    );
  }
}