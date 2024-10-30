// enum LoginStatus { initial, loading, success, failure }
class ReplySatae{
  final String commenter;
  ReplySatae({required this.commenter});
  ReplySatae copyWith({
     required String commenter,
  }){
    return ReplySatae(commenter:commenter);
  }
}