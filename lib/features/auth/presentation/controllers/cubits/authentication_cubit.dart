import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthenticationCubit extends Cubit<AuthenticationStates> {
  final AuthenticationUseCase _authenticationUseCase;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthenticationCubit({required AuthenticationUseCase authUseCase }) :_authenticationUseCase=authUseCase, super(AuthenticationInitialState());
  Future<void> login(LoginRequsetModel user) async {

    emit(AuthenticationLoadingState());
   var test=    await _authenticationUseCase.login(user);

   test.fold(
     (l) {
       emit(AuthenticationErrorState(message: l.message,));

     },
     (r) async{
       // r.

     await  StorageService.saveUser(r.fromEntity());
       // r.user
       emit(AuthenticationSuccessState());
     },
   );
  }
}

class AuthActionCubit extends Cubit<bool>{
  AuthActionCubit(super.initialState);

  togglePasswordVisibility({required bool isVisible}){
    emit(!isVisible);
  }


}
