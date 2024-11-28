import 'package:academe_x/core/constants/cache_keys.dart';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/features.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/pagination/pagination_params.dart';
import '../../../../data/models/post/post_model.dart';
import '../../../../domain/entities/post/post_entity.dart';
import '../../states/post/post_state.dart';



class PostsCubit extends Cubit<PostsState> {
  final PostUseCase getPosts;
  final HiveCacheManager _cacheManager;

  bool _isLoading = false; // Add loading flag to prevent multiple simultaneous calls

  PostsCubit({
    required this.getPosts,
  }) : _cacheManager = getIt<HiveCacheManager>(),
        super(PostsState());



  Future<void> loadPosts({bool refresh = false}) async {
    if (_isLoading) return;
    if (state.hasReachedMax && !refresh) return;
    try {
      _isLoading = true;

      final page = refresh ? 1 : state.currentPage;
      if (kDebugMode) {
        print('Before load - Current page: ${state.currentPage}');
        print('Loading page: $page');
        print('After load - Next page will be: ${state.currentPage + 1}');


      }
        emit(state.copyWith(status: PostStatus.loading));

      final result = await getPosts.getPosts(PaginationParams(page: page));

      result.fold(
            (failure)async  {
              final cachedPosts = await _getCachedPosts();

              if (cachedPosts != null && cachedPosts.isNotEmpty) {
                // If we have cached posts, use them
                emit(state.copyWith(
                  status: PostStatus.success,
                  posts: cachedPosts,
                  errorMessage: 'Using cached data: ${failure.message}',
                  hasReachedMax: true, // Prevent pagination in offline mode
                ));
              } else {
                // If no cache, show error
                emit(state.copyWith(
                  status: PostStatus.failure,
                  errorMessage: failure.message,
                ));
              }
        },
            (paginatedData) {

              if (refresh) {
                emit(state.copyWith(
                  status: PostStatus.success,
                  posts: paginatedData.items,
                  hasReachedMax: !paginatedData.hasNextPage,
                  currentPage: 2,
                  errorMessage: null,
                ));
                return;
              }
              final List<PostEntity> newPosts = [...state.posts];

              // Add only non-duplicate items from paginatedData
              for (var newPost in paginatedData.items) {
                if (!newPosts.any((existingPost) => existingPost.id == newPost.id)) {
                  newPosts.add(newPost);
                }
              }
              final nextPage = state.currentPage + 1;
          emit(state.copyWith(
            status: PostStatus.success,
            posts: newPosts,
            hasReachedMax: !paginatedData.hasNextPage,
            currentPage:nextPage,
            errorMessage: null,
          ));
        },
      );
    } catch (e) {
      final cachedPosts = await _getCachedPosts();

      if (cachedPosts != null && cachedPosts.isNotEmpty) {
        emit(state.copyWith(
          status: PostStatus.success,
          posts: cachedPosts,
          errorMessage: 'Using cached data: $e',
          hasReachedMax: true, // Prevent pagination in offline mode
        ));
      } else {
        emit(state.copyWith(
          status: PostStatus.failure,
          errorMessage: e.toString(),
        ));
      }
    }finally {
      _isLoading = false;
    }
  }
  Future<List<PostEntity>?> _getCachedPosts() async {
    try {
      return await _cacheManager.getCachedResponse<List<PostEntity>>(
        CacheKeys.POSTS,
            (json) => (json as List)
            .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      AppLogger.w('Failed to get posts from cache: $e');
      return null;
    }
  }

  Future<void> clearCache() async {
    try {
      await _cacheManager.removeCacheItem(CacheKeys.POSTS);
    } catch (e) {
      AppLogger.w('Failed to clear cache: $e');
    }
  }

  Future<void> refreshPosts() async {
    emit(state.copyWith(
      status: PostStatus.loading,
      posts: [],
      hasReachedMax: false,
      currentPage: 1,
    ));
    await clearCache();
    await loadPosts(refresh: true);
  }
}