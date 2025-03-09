import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/auth/data/models/requset/update_profile_request_model.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/request/update_profile_request_entity.dart';

class SignupCubit extends AuthCubit {
  CollegeMajorsCubit collegeMajorsCubit;

  SignupCubit(
      {required AuthenticationUseCase authUseCase,
      required this.collegeMajorsCubit})
      : super(
            initialState: AuthState.initialSignup(),
            authenticationUseCase: authUseCase);

  void showEduInfo(bool showEducationInfo) async {
    emit(state.copyWith(
      showEducationInfo: !showEducationInfo,
    ));
    if (!showEducationInfo) {
      // This means we're switching TO education info
      await collegeMajorsCubit.getColleges();
    }
  }

  Future<void> signup(SignupRequestEntity user) async {
    if (state.isLoading) return;

    var finalUser = SignupRequestModel.fromEntity(user);

    if (!finalUser.isValid()) {
      setError('Please check your input data');
      return;
    }
    setLoading();

    final result = await authenticationUseCase.signup(user);
    Future.delayed(const Duration(seconds: 0), () {
      result.fold(
        (failure) {
          List<String>? errorMessage = [];
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
          await handleAuthSuccess(user);
        },
      );
    });
  }

  Future<void> updateProfile(
      Map<String, dynamic> user, BuildContext context) async {
    if (state.isLoading) return;

    // var finalUser=UpdateProfileRequestModel.fromEntity(user);

    setLoading();

    final result = await authenticationUseCase.updateProfile(user);
    Future.delayed(const Duration(seconds: 0), () {
      result.fold(
        (failure) {
          List<String>? errorMessage = [];
          if (failure is ValidationFailure) {
            errorMessage = failure.messages;
            // AppLogger.e(errorMessage.toString());
          } else if (failure is UnauthorizedFailure) {
            errorMessage.add(failure.message);
          } else {
            errorMessage.add(failure.message);
          }
          setError(errorMessage[0]);
        },
        (user) async {
          await handleUpdateSuccess(user, context);
        },
      );
    });
  }

  void selectGenderIndex({int? index}) {
    emit(state.copyWith(
      selectedGenderIndex: index,
      // isSelectedMajor: true
    ));
  }
}
