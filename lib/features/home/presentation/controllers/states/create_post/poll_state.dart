class PollState {
  List<String>? optionContent;
  String? question;
  late DateTime endPoll;

  PollState({this.optionContent, this.question, DateTime? endPoll}) {
    this.endPoll = endPoll ??
        DateTime(DateTime.now().year, DateTime.now().month + 1,
            DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  }

  copyWith({
    List<String>? optionContent,
    String? question,
    DateTime? endPoll
  }) {
    return PollState(
      optionContent: optionContent ?? this.optionContent,
      question: question ?? this.question,
      endPoll: endPoll ?? this.endPoll,
    );
  }
  deleteDateTime(){
    endPoll =
        DateTime(DateTime.now().year, DateTime.now().month + 1,
            DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  }
}
