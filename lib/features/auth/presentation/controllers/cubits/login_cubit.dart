import 'package:academe_x/features/auth/presentation/controllers/cubits/auth_cubit.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginCubit extends AuthCubit {
  LoginCubit({required AuthenticationUseCase authUseCase})
      : super(
    authenticationUseCase: authUseCase,
    initialState: AuthState.initial(),
  );

  Future<void> login(LoginRequsetModel user) async {
    if (state.isLoading) return;

    // Validate locally first
    if (user.username!.isEmpty || user.password!.isEmpty) {
      List<String> errors = [];
      if (user.username!.isEmpty) {
        errors.add('Username should not be empty');
      }
      if (user.password!.isEmpty) {
        errors.add('Password should not be empty');
      }
      setError(errors.join('\n'));
      return;
    }

    setLoading();
    //
    // emit(state.copyWith(
    //   isLoading: true,
    //   errorMessage: null,
    // ));

    final result = await authenticationUseCase.login(user);
    Future.delayed(
        const Duration(
            seconds: 0
        ),
            () {
              result.fold(
                    (failure) {
                  String errorMessage;
                  if (failure is ValidationFailure) {
                    errorMessage = failure.messages.join('\n');
                  } else if (failure is UnauthorizedFailure) {
                    errorMessage = failure.message;
                  } else {
                    errorMessage = failure.message;
                  }
                  setError(errorMessage);
                  emit(state.copyWith(
                    isLoading: false,
                    errorMessage: [errorMessage],
                    isAuthenticated: false,
                  ));
                },
                    (user) async {
                   await   handleAuthSuccess(user);
                },
              );
            }
              );
  }



  // @override
  // Future<void> close() {
  //   emailController.dispose();
  //  passwordController.dispose();
  //   return super.close();
  // }
}

class AuthActionCubit extends Cubit<bool>{
  AuthActionCubit(super.initialState);

  togglePasswordVisibility({required bool isVisible}){
    emit(!isVisible);
  }


}
