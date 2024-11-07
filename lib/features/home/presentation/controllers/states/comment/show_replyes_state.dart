// enum LoginStatus { initial, loading, success, failure }
class ShowReplyesState{
  final bool show;
  final int index;
  ShowReplyesState({ this.show = false,required this.index});
  ShowReplyesState copyWith({
     required bool show,
     required int index
  }){
    return ShowReplyesState(show: show, index: index);
  }
}
