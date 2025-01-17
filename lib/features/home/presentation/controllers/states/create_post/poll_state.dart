class PollState {
  List<String>? optionContent;
  String? question;

  PollState({this.optionContent,this.question});

  copyWith({List<String>? optionContent,String? question}) {
    return PollState(
      optionContent: optionContent ?? this.optionContent,
      question: question ?? this.question,
    );
  }
}
