import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String message;
  Failure({required this.message});
  @override
  List<Object?> get props => [message];

}

class ServerFailure extends Failure {
<<<<<<< HEAD
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
=======
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
>>>>>>> 536135a (Description of changes)
}


class ApiFailure extends Failure {
<<<<<<< HEAD
  ApiFailure({required super.message});
}


class TimeOutFailure extends Failure {
  TimeOutFailure({required super.message});
}

=======
  ApiFailure({required String message}) : super(message: message);
}


>>>>>>> 536135a (Description of changes)
