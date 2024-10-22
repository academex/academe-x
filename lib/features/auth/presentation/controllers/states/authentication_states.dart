import 'package:equatable/equatable.dart';


enum AuthenticationErrorType {
  noInternetConnectionError,
  serverError,
  invalidCredentials,
  wrongUserNameOrPassword,
  unknownError,
  timeoutError,
}


abstract class AuthenticationStates extends Equatable{

  const AuthenticationStates();

  @override
  List<Object> get props => [];
}



class AuthenticationInitialState extends AuthenticationStates {}




class AuthenticationLoadingState extends AuthenticationStates {}




class AuthenticationSuccessState extends AuthenticationStates {}

// class AuthenticationWrongCredintiolState extends AuthenticationStates {}

class AuthenticationErrorState extends AuthenticationStates {

 const AuthenticationErrorState({required  this.message,required this.errorType});
  final String message;
  final AuthenticationErrorType errorType;
}

