import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String message;
  Failure({required this.message});
  @override
  List<Object?> get props => [message];

}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}


class ValidationFailure extends Failure {
  final List<String> messages;

  ValidationFailure({required this.messages, required super.message});

  @override
  String get message => messages.join('\n');
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({required String message}) : super(message: message);
}

class NoInternetConnectionFailure extends Failure {
  NoInternetConnectionFailure({required super.message});
}
class NotFoundFailure extends Failure {
  NotFoundFailure({required super.message});
}class TooManyRequestsFailure extends Failure {
  TooManyRequestsFailure({required super.message});
}


class TimeOutFailure extends Failure {
  TimeOutFailure({required super.message});
}

