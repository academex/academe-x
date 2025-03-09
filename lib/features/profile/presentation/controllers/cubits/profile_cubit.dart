import 'package:academe_x/core/error/failure.dart';
import 'package:academe_x/core/utils/deep_link_service.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/core/utils/go_router.dart';
import 'package:academe_x/features/home/presentation/controllers/states/post/post_state.dart';
import 'package:academe_x/features/profile/domain/usecases/profile_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/cache_keys.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../../../../core/utils/logger.dart';
import '../../../../../core/utils/storage/cache/hive_cache_manager.dart';
import '../../../../auth/domain/entities/response/auth_token_entity.dart';
import '../../../../auth/domain/entities/response/updated_user_entity.dart';
import '../../../../auth/presentation/controllers/states/auth_state.dart';
import '../../../../home/domain/entities/post/post_entity.dart';
import '../../../../home/presentation/controllers/cubits/post/posts_cubit.dart';
import '../states/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase profileUseCase;
  final PostsCubit postsCubit;  // Inject PostsCubit
  // final AuthState authState ;  // Inject PostsCubit

  final ScrollController scrollController = ScrollController();
  bool _isLoading = false;

  ProfileCubit({
    required this.postsCubit,
    required this.profileUseCase,
    // required this.authState,

  }) : super(const ProfileState()) {
    // Listen to posts state changes
    postsCubit.stream.listen((PostsState postsState) {
      // Update profile state based on posts state changes
      if (postsState.status == PostStatus.success) {
        emit(state.copyWith(
          posts: postsState.posts,
          hasPostsReachedMax: postsState.hasPostsReachedMax,
          currentPage: postsState.postsCurrentPage,
        ));
      }
    });
  }


  Future<void> loadProfile(BuildContext context, {String? username}) async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));
      if (username == null) {
        // Load current user from cache
        final currentUser = await context.cachedUser;
        // currentUser
        emit(state.copyWith(
          status: ProfileStatus.loaded,
          profileType: ProfileType.currentUser,
          user: currentUser!.user,
          otherUser: null,
          isEditable: true,
        ));
      }
      else {
        emit(state.copyWith(status: ProfileStatus.loading));
        // Load other user's profile
        // You would typically make an API call here to get the user data
        // For now, we'll use cached user as placeholder
        final otherUser = await profileUseCase.getUserProfile(username);
        otherUser.fold(
          (l) => emit(state.copyWith(
            status: ProfileStatus.error,
            errorMessage: l.message,
          )),
          (r) => emit(state.copyWith(
            status: ProfileStatus.loaded,
            profileType: ProfileType.otherUser,
            otherUser: r,
            isEditable: false,
          )),
        );

      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading profile: $e');
      }
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'Failed to load profile data',
      ));
    }
  }

  void whenCloseOtherUserProfile(){
    // AppLogger.w('Im here');
    emit(state.copyWith(
      isEditable: true
    ));
  }

  Future<void> loadSavedPosts(BuildContext context, {required String username}) async {
    if (state.hasSavedPostsReachedMax) return;
    final page = state.currentSavedPostsPage;
    try {
      emit(state.copyWith(profileSavedPostsStatus: ProfileSavedPostsStatus.loading));
      final savedPosts = await profileUseCase.loadSavedPosts(
        PaginationParams(page: page, username: username),
      );
      savedPosts.fold(
        (l) => emit(state.copyWith(
          profileSavedPostsStatus: ProfileSavedPostsStatus.error,
          errorMessage: l.message,
        )),
        (r) {
          // AppLogger.success(r.items.length.toString());
          return emit(state.copyWith(
            profileSavedPostsStatus: ProfileSavedPostsStatus.loaded,
            savedPosts: r.items,
            hasSavedPostsReachedMax: !r.hasNextPage,
          ));
        }
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error loading profile: $e');
      }
      emit(state.copyWith(
        profileSavedPostsStatus: ProfileSavedPostsStatus.error,
        errorMessage: 'Failed to load saved Posts',
      ));
    }
  }

  Future<void> loadPosts(BuildContext context,{
    required
  String? username
  }) async {
    final Either<Failure, PaginatedResponse<PostEntity>> result;
    if (_isLoading) return;
    if (state.hasPostsReachedMax) return;

    try {
      _isLoading = true;
      final page = state.currentPage;

      if (username == null) {
        // Load current user from cache
        final currentUser = await context.cachedUser;

         result = await profileUseCase.loadPosts(
          PaginationParams(page: page, username: currentUser!.user.username),
        );
      }
      else {
         result = await profileUseCase.loadPosts(
          PaginationParams(page: page, username: username),
        );
      }
      result.fold(
        (failure) {
          emit(state.copyWith(
            status: ProfileStatus.error,
            errorMessage: failure.message,
          ));
        },
        (paginatedData) => _handleSuccessResponse(paginatedData),
      );
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: e.toString(),
      ));
    } finally {
      _isLoading = false;
    }
  }

  void _handleSuccessResponse(
    PaginatedResponse<PostEntity> paginatedData,
  ) {
    final List<PostEntity> newPosts = [...state.posts];
    for (var newPost in paginatedData.items) {
      if (!newPosts.any((existingPost) => existingPost.id == newPost.id)) {
        newPosts.add(newPost);
      }
    }

    emit(state.copyWith(
      status: ProfileStatus.loaded,
      posts: newPosts,

      hasPostsReachedMax: !paginatedData.hasNextPage,
      currentPage: state.currentPage + 1,
      errorMessage: null,
    ));
  }


  Future<void> updateProfile(
      Map<String, dynamic> user,BuildContext context) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));
    final result = await profileUseCase.updateProfile(user);
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
          emit(state.copyWith(
              errorMessage:errorMessage[0],
              isLoading: false
          ));
        },
            (user) async {
              // context.pop();
              Navigator.pop(context);
          await handleUpdateSuccess(user, context);

        },
      );
    });
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
        errorMessage: null,
        user: userAuthCached.user,
      ));
    }catch(e){
      AppLogger.e('Failed to cache user: $e');
    }
  }

  // Future<void> refreshProfile(String userId) async {
  //   emit(state.copyWith(
  //     status: ProfileStatus.loading,
  //     userPosts: [],
  //     hasPostsReachedMax: false,
  //     postsCurrentPage: 1,
  //   ));
  //
  //   await Future.wait([
  //     loadUserProfile(userId),
  //     loadUserPosts(refresh: true, userName: userId),
  //   ]);
  // }

  bool isAtTop() {
    return scrollController.position.pixels <= 0;
  }

  void goToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
