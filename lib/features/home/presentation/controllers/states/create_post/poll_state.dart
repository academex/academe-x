class PollState {
  List<String>? optionContent;

  PollState({this.optionContent});

  copyWith({List<String>? optionContent}) {
    return PollState(
      optionContent: optionContent ?? this.optionContent,
    );
  }
}
