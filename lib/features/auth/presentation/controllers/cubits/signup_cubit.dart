import 'package:academe_x/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends AuthCubit {
  SignupCubit({required AuthenticationUseCase authUseCase})
      : super(
      initialState: AuthState.initialSignup(),
      authenticationUseCase: authUseCase

  );

//
//  Future<void> signup(SignupRequestEntity user) async {
//
//   emit(AuthenticationLoadingState() as SignupState);
//   var test=    await authenticationUseCase.signup(user);
//
//   test.fold(
//         (l) {
//       // emit(AuthenticationErrorState(message: l.message,));
//
//     },
//         (r) async{
//       // r.
//
//       await  StorageService.saveUser(r.fromEntity());
//       // r.user
//       // emit(AuthenticationSuccessState());
//     },
//   );
// }
//
// void initData() {
//   emit(state.copyWith(
//     showEducationInfo: false,
//     confirmPasswordController: TextEditingController(),
//     phoneController: TextEditingController(),
//     emailController: TextEditingController(),
//     passwordController: TextEditingController(),
//     nameController: TextEditingController(),
//     formKey:GlobalKey<FormState>(),
//   ));
// }
//
void showEduInfo(bool showEducationInfo){
  emit(state.copyWith(
    showEducationInfo: !showEducationInfo,
  ));
}
  Future<void> signup(SignupRequestEntity user) async {
    if (state.isLoading) return;

    var finalUser=SignupRequestModel.fromEntity(user);

    AppLogger.e((!finalUser.isValid()).toString());

    if (!finalUser.isValid()) {
      setError('Please check your input data');
      return;
    }
    setLoading();

    final result = await authenticationUseCase.signup(user);
    Future.delayed(
        const Duration(
            seconds: 0
        ),
            () {
          result.fold(
                (failure) {
              List<String>? errorMessage=[];
              if (failure is ValidationFailure) {
                errorMessage = failure.messages;
              } else if (failure is UnauthorizedFailure) {
                errorMessage.add(failure.message);
              } else {
                errorMessage.add(failure.message);
              }
              setError(errorMessage[0]);
              // emit(state.copyWith(
              //   isLoading: false,
              //   errorMessage: errorMessage,
              //   isAuthenticated: false,
              // ));
            },
                (user) async {
              await   handleAuthSuccess(user);
            },
          );
        }
    );
  }

  void selectGenderIndex({int? index}) {
    emit(state.copyWith(
      selectedGenderIndex: index,
      // isSelectedMajor: true
    ));
  }


}