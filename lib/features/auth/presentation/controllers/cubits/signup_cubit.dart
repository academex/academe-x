import 'package:academe_x/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends AuthCubit {
  SignupCubit({required AuthenticationUseCase authUseCase})
      : super(
      initialState: AuthState.initialSignup(),
      authenticationUseCase: authUseCase

  );

void showEduInfo(bool showEducationInfo){
  AppLogger.d(showEducationInfo.toString());
  emit(state.copyWith(
    showEducationInfo: !showEducationInfo,
  ));

  if (!showEducationInfo) {  // This means we're switching TO education info
    getColleges();
  }
}
  Future<void> signup(SignupRequestEntity user) async {
    if (state.isLoading) return;

    var finalUser=SignupRequestModel.fromEntity(user);


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


  Future<void> getColleges() async {
  AppLogger.success('in getColleges');
    if (state.isLoadingForCollege) return;
    emit(state.copyWith(isLoadingForCollege: true));

    final result = await authenticationUseCase.getColleges();
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
              emit(state.copyWith(
                errorMessage: errorMessage,
                isLoadingForCollege: false,
              ));
            },
                (colleges) async {
                  emit(state.copyWith(
                    colleges: colleges,
                    isLoadingForCollege: false,
                  ));
            },
          );
        }
    );
  }


  Future<void> getMajorsByCollege(String collegeName) async {
    if (state.isLoadingForMajors) return;
    emit(state.copyWith( isLoadingForMajors: true,));

    final result = await authenticationUseCase.getMajorsByCollege(collegeName);
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
              emit(state.copyWith(
                errorMessage: errorMessage,
                isLoadingForMajors: false,
              ));
            },
                (majors) async {
                  AppLogger.success(majors.toString());
              emit(state.copyWith(
                majors: majors,
                isLoadingForMajors: false,
              ));
            },
          );
        }
    );
  }

  Future<void> retry()async{
  await getColleges();

  }


}