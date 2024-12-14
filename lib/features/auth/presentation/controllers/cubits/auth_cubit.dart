import 'package:academe_x/core/constants/cache_keys.dart';
import 'package:academe_x/core/utils/deep_link_service.dart';
import 'package:academe_x/core/utils/extensions/auth_cache_manager.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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


  void checkRememberMe() {
    emit(state.copyWith(isRememberMe: !state.isRememberMe));
  }

  Future<void> handleAuthSuccess(AuthTokenEntity user) async {

   try{
     await getIt<HiveCacheManager>().cacheAuthUser(user);
     emit(state.copyWith(
       isLoading: false,
       isAuthenticated: true,
       errorMessage: null,
     ));
   }catch(e){
     AppLogger.e('Failed to cache user: $e');
   }
  }


  void toggleExpanded() {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }

  void selectIndex({required int? index, required SelectionType selectionType}) {
    if (selectionType == SelectionType.major) {
      emit(state.copyWith(selectedMajorIndex: index));
    } else {
      emit(state.copyWith(selectedSemesterIndex: index));
    }
  }

  void selectTagId({required int? tagId,}) {
      emit(state.copyWith(selectedTagId: tagId));
  }

  void appendMajorToBaseVar(String major) {
    emit(state.copyWith(
        collegeAndMajor: "${state.selectedCollege!} ($major) "
    ));
  }





}