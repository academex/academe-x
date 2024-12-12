// enum LoginStatus { initial, loading, success, failure }
class ShowRepliesState{
  final bool show;
  final int index;
  ShowRepliesState({ this.show = false,required this.index});
  ShowRepliesState copyWith({
     required bool show,
     required int index
  }){
    return ShowRepliesState(show: show, index: index);
  }
}
