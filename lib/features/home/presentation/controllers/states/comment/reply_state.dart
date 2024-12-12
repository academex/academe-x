// enum LoginStatus { initial, loading, success, failure }
class ReplyState{
  final String commenter;
  ReplyState({required this.commenter});
  ReplyState copyWith({
     required String commenter,
  }){
    return ReplyState(commenter:commenter);
  }
}