import 'package:academe_x/features/features.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';

abstract class CreatePostState {}

class InitialState extends CreatePostState {}

class SendingState extends CreatePostState {}

class SuccessState extends CreatePostState {
  PostEntity postReqEntity;
  SuccessState({required this.postReqEntity});
}

class FailureState extends CreatePostState {
  String errorMessage;
  FailureState({required this.errorMessage});
}

class CancelledState extends CreatePostState {}
