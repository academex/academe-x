import 'package:academe_x/features/features.dart';

abstract class CreatePostState {}

class InitialState extends CreatePostState {}

class SendingState extends CreatePostState {}

class SuccessState extends CreatePostState {
  PostReqEntity postReqEntity;
  SuccessState({required this.postReqEntity});
}

class FailureState extends CreatePostState {
  String errorMessage;
  FailureState({required this.errorMessage});
}

class CancelledState extends CreatePostState {}
