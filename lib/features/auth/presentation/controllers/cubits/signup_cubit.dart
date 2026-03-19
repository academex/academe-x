import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/cupertino.dart';

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
    result.fold(
      (failure) {
        final errorMessage = failure is ValidationFailure
            ? failure.messages
            : [failure.message];
        setError(errorMessage.first);
      },
      (user) async {
        await handleAuthSuccess(user);
      },
    );
  }

  Future<void> updateProfile(
      Map<String, dynamic> user, BuildContext context) async {
    if (state.isLoading) return;

    setLoading();

    final result = await authenticationUseCase.updateProfile(user);
    result.fold(
      (failure) {
        final errorMessage = failure is ValidationFailure
            ? failure.messages
            : [failure.message];
        setError(errorMessage.first);
      },
      (user) async {
        await handleUpdateSuccess(user, context);
      },
    );
  }

  void selectGenderIndex({int? index}) {
    emit(state.copyWith(selectedGenderIndex: index));
  }
}
