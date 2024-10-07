import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String message;
  Failure({required this.message});
  @override
  List<Object?> get props => [message];

}

class ServerFailure extends Failure {
  ServerFailure({required String message}) : super(message: message);
}

class WrongPasswordOrEmailFailure extends Failure {
  WrongPasswordOrEmailFailure({required String message}) : super(message: message);
}

class CacheFailure extends Failure {
  CacheFailure({required String message}) : super(message: message);
}

class NoInternetConnectionFailure extends Failure {
  NoInternetConnectionFailure({required String message}) : super(message: message);
}

class NoDataFailure extends Failure {
  NoDataFailure({required String message}) : super(message: message);
}


class ApiFailure extends Failure {
  ApiFailure({required String message}) : super(message: message);
}


