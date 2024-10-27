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

class WrongPasswordOrEmailFailure extends Failure {
  WrongPasswordOrEmailFailure({required super.message});
}

class CacheFailure extends Failure {
  CacheFailure({required super.message});
}

class NoInternetConnectionFailure extends Failure {
  NoInternetConnectionFailure({required super.message});
}

class NoDataFailure extends Failure {
  NoDataFailure({required super.message});
}


class ApiFailure extends Failure {
  ApiFailure({required super.message});
}


class TimeOutFailure extends Failure {
  TimeOutFailure({required super.message});
}

