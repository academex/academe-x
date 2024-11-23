import 'package:academe_x/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
enum AuthStatus { initial, authenticated, unauthenticated }

abstract class AuthCubit extends Cubit<AuthState> {
  final AuthenticationUseCase authenticationUseCase;
  // final StorageService storageService;

  AuthCubit({
    required this.authenticationUseCase,
    required AuthState initialState,
    // required this.storageService
  }) : super(initialState);

  // Common methods
  void setLoading() {
    // AppLogger.success('setLoading');

    emit(state.copyWith(isLoading: true,errorMessage: null));
  }

  void setError(String message) {
    // AppLogger.i("in cubit in set error $message");
    emit(state.copyWith(
      isAuthenticated: false,
      errorMessage: [message],
      isLoading: false
    ));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible,));
  }


  // Future<List<CollegeEntity>> getColleges() async{
  //  return await authenticationUseCase.getColleges();
  // }

  Future<void> getColleges() async {
    if (state.isLoading) return;
    setLoading();

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
              setError(errorMessage[0]);
              // emit(state.copyWith(
              //   isLoading: false,
              //   errorMessage: errorMessage,
              //   isAuthenticated: false,
              // ));
            },
                (colleges) async {
                  emit(state.copyWith(
                    colleges: colleges
                  ));
                  // state.collegesData = Map.fromEntries(
                  //     colleges?.map((college) => MapEntry(college.collegeAr!, CollegeData(icon: icon, majors: majors))) ?? {}
                  // );
                  // state.collegesData!.addEntries(colleges);
               // emit(state)

            },
          );
        }
    );
  }

  void checkRememberMe() {
    emit(state.copyWith(isRememberMe: !state.isRememberMe));
  }

  Future<void> handleAuthSuccess(AuthTokenEntity user) async {

    // await StorageService.saveUser(user.fromEntity());
    emit(state.copyWith(
      isLoading: false,
      isAuthenticated: true,
      errorMessage: null,
    ));
  }


  void toggleExpanded() {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }

  void selectCollege(String college) {
    emit(state.copyWith(selectedCollege: college));
  }

  void selectIndex({required int? index, required SelectionType selectionType}) {
    if (selectionType == SelectionType.major) {
      emit(state.copyWith(selectedMajorIndex: index));
    } else {
      emit(state.copyWith(selectedSemesterIndex: index));
    }
  }

  void appendMajorToBaseVar(String major) {
    emit(state.copyWith(
        collegeAndMajor: "${state.selectedCollege!} ($major) "
    ));
  }

  // Future<void> checkAuthStatus() async {
  //   try {
  //     // Get the stored token or any auth data
  //     final token = await storageService.getToken();
  //
  //     if (token != null && token.isNotEmpty) {
  //       emit(AuthStatus.authenticated);
  //     } else {
  //       emit(AuthStatus.unauthenticated);
  //     }
  //   } catch (e) {
  //     emit(AuthStatus.unauthenticated);
  //   }
  // }


  // Future<void> checkAuthStatus() async {
  //   try {
  //     // Get the stored user data using your existing method
  //     final AuthTokenModel? userData = storageService.getUser();
  //
  //     if (userData != null&& userData.accessToken.isNotEmpty) {
  //       emit(AuthStatus.authenticated);
  //     } else {
  //       emit(AuthStatus.unauthenticated);
  //     }
  //   } catch (e) {
  //     emit(AuthStatus.unauthenticated);
  //   }
  // }
}