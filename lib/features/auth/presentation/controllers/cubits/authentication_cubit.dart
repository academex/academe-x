import 'dart:async';
import 'dart:io';

import 'package:academe_x/core/error/exception.dart';
import 'package:academe_x/features/auth/data/models/requset/login_requset_model.dart';
import 'package:academe_x/features/auth/domain/entities/request/login_requset_entity.dart';
import 'package:academe_x/features/auth/domain/usecases/authentication_use_case.dart';
import 'package:academe_x/features/auth/presentation/controllers/states/authentication_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AuthenticationCubit extends Cubit<AuthenticationStates> {
  final AuthenticationUseCase _authenticationUseCase;
  AuthenticationCubit({required AuthenticationUseCase authUseCase }) :_authenticationUseCase=authUseCase, super(AuthenticationInitialState());
  Future<void> login(LoginRequsetModel user) async {
    try {
      emit(AuthenticationLoadingState());

       await _authenticationUseCase.login(user);


      emit(AuthenticationSuccessState());

    }
    on WrongDataException {
      emit(const AuthenticationErrorState(
        message: 'Wrong username or password',
        errorType: AuthenticationErrorType.wrongUserNameOrPassword,
      ));
    }
    on TimeoutException {
      emit(const AuthenticationErrorState(
        message: 'The request timed out. Please try again.',
        errorType: AuthenticationErrorType.timeoutError,
      ));
    } on OfflineException {
      emit(const AuthenticationErrorState(
        message: 'Please check your internet connection.',
        errorType: AuthenticationErrorType.noInternetConnectionError,
      ));
    } on HttpException catch (e) {
      emit(AuthenticationErrorState(
        message: e.message,
        errorType: AuthenticationErrorType.serverError,
      ));
    } catch (e) {
      emit(const AuthenticationErrorState(
        message: 'An unknown error occurred',
        errorType: AuthenticationErrorType.unknownError,
      ));
    }
  }
}

class AuthActionCubit extends Cubit<bool>{
  AuthActionCubit(super.initialState);

  togglePasswordVisibility({required bool isVisible}){
    emit(isVisible);
  }


}
