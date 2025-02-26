import 'package:academe_x/core/constants/cache_keys.dart';
import 'package:academe_x/core/utils/deep_link_service.dart';
import 'package:academe_x/core/utils/extensions/auth_cache_manager.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/storage/cache/hive_cache_manager.dart';
import '../../../domain/entities/response/updated_user_entity.dart';
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


  Future<void> handleUpdateSuccess(UpdatedUserEntity updatedUser,BuildContext context) async {

    try{
      AuthTokenEntity userAuthCached=((await context.cachedUser) as AuthTokenEntity).copyWith(
        user: (await context.cachedUser)!.user.copyWith(
          firstName: updatedUser.firstName,
          lastName: updatedUser.lastName,
          username: updatedUser.username,
          email: updatedUser.email,
          currentYear: updatedUser.currentYear,
          bio: updatedUser.bio,
          tagId: updatedUser.tagId,
          photoUrl: updatedUser.photoUrl,
        ),
      );

      getIt<HiveCacheManager>().cacheResponse(
        CacheKeys.USER,
        userAuthCached.fromEntity().toJson(),
        isUser: true,
      );

      emit(state.copyWith(
        isLoading: false,
        isUpdated: true,
        errorMessage: null,
      ));
    }catch(e){
      AppLogger.e('Failed to cache user: $e');
    }
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


}