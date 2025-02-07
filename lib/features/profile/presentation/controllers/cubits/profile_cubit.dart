import 'package:academe_x/core/error/failure.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/home/presentation/controllers/states/post/post_state.dart';
import 'package:academe_x/features/profile/domain/usecases/profile_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../../../home/domain/entities/post/post_entity.dart';
import '../../../../home/presentation/controllers/cubits/post/posts_cubit.dart';
import '../states/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase profileUseCase;
  final PostsCubit postsCubit;  // Inject PostsCubit
  final ScrollController scrollController = ScrollController();
  bool _isLoading = false;

  ProfileCubit({
    required this.postsCubit,
    required this.profileUseCase,
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


  Future<void> loadProfile(BuildContext context, {String? userId}) async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));

      if (userId == null) {
        // Load current user from cache
        final currentUser = await context.cachedUser;
        emit(state.copyWith(
          status: ProfileStatus.loaded,
          profileType: ProfileType.currentUser,
          user: currentUser,
          isEditable: true,
        ));
      }
      else {
        // Load other user's profile
        // You would typically make an API call here to get the user data
        // For now, we'll use cached user as placeholder
        final otherUser = await context.cachedUser;
        emit(state.copyWith(
          status: ProfileStatus.loaded,
          profileType: ProfileType.otherUser,
          user: otherUser,
          isEditable: false,
        ));
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

        // emit(state.copyWith(
        //   status: ProfileStatus.loaded,
        //   profileType: ProfileType.currentUser,
        //   userPosts: ,
        //   // profileUser: currentUser,
        //   isEditable: true,
        // ));
      }
      else {
        // Load other user's profile
        // You would typically make an API call here to get the user data
        // For now, we'll use cached user as placeholder
        // emit(state.copyWith(
        //   status: ProfileStatus.loaded,
        //   profileType: ProfileType.otherUser,
        //   profileUser: otherUser,
        //   isEditable: false,
        // ));

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
