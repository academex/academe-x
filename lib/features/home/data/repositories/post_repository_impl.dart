import 'package:academe_x/core/network/base_response.dart';
import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/cache_keys.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/pagination/paginated_meta.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/storage/cache/hive_cache_manager.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_data_source.dart';


class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final HiveCacheManager cacheManager;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.cacheManager,
  });

  @override
  Future<Either<Failure, PaginatedResponse<PostModel>>> getPosts(PaginationParams paginationParams) async {
    try {
      // First try to get from network
      final result = await remoteDataSource.getPosts(paginationParams);

      // Cache successful network response
      _cacheResults(result.items, paginationParams.page);

      return Right(result);
    } on OfflineException catch (e) {
      // Handle offline case by trying cache
      return _handleOfflineCase(e, paginationParams);
    } on ServerException catch (e) {
      // On server error, try cache first
      return _handleServerError(e, paginationParams);
    } on ValidationException catch (e) {
      return Left(ValidationFailure(messages: e.messages, message: ''));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } on TimeOutExeption catch (e) {
      // On timeout, try cache
      return _handleTimeoutError(e, paginationParams);
    } catch (e, stack) {
      AppLogger.e('Unexpected error: $e\n$stack');
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<void>>> reactToPost(String reactionType,int postId) async {
    try {
      // First try to get from network
      final result = await remoteDataSource.reactToPost(reactionType,postId);
      // result

      return  Right(result);
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(message:  e.errorMessage));
      // Handle offline case by trying cache
      // return _handleOfflineCase(e);
    } on ServerException catch (e) {
      return Left(ServerFailure(message:  e.message));
      // On server error, try cache first
      // return _handleServerError(e, paginationParams);
    } on ValidationException catch (e) {
      return Left(ValidationFailure(messages: e.messages, message: ''));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } on TimeOutExeption catch (e) {
      // On timeout, try cache

      return Left(TimeOutFailure(message: e.errorMessage));
    } catch (e, stack) {
      AppLogger.e('Unexpected error: $e\n$stack');
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  Future<void> _cacheResults(List<PostModel> posts, int page) async {
    try {
      if (page == 1) {
        // For first page, replace cache
        await cacheManager.cacheResponse(
          CacheKeys.POSTS,
          posts.map((post) => post.toJson()).toList(),
        );
      } else {
        // For pagination, merge with existing cache
        final existingCache = await _getFromCache();
        if (existingCache != null) {
          final mergedPosts = _mergePosts(existingCache, posts);
          await cacheManager.cacheResponse(
            CacheKeys.POSTS,
            mergedPosts.map((post) => post.toJson()).toList(),
          );
        }
      }
    } catch (e) {
      AppLogger.w('Cache operation failed: $e');
      // Don't throw - caching errors shouldn't affect the main flow
    }
  }

  Future<List<PostModel>?> _getFromCache() async {
    try {
      return await cacheManager.getCachedResponse<List<PostModel>>(
        CacheKeys.POSTS,
            (json) => (json as List)
            .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      AppLogger.w('Failed to get from cache: $e');
      return null;
    }
  }

  List<PostModel> _mergePosts(List<PostModel> existing, List<PostModel> new_) {
    final merged = [...existing];
    for (var post in new_) {
      if (!merged.any((p) => p.id == post.id)) {
        merged.add(post);
      }
    }
    return merged;
  }

  Future<Either<Failure, PaginatedResponse<PostModel>>> _handleOfflineCase(
      OfflineException e,
      PaginationParams params,
      ) async {
    // Try to get from cache
    final cachedPosts = await _getFromCache();
    if (cachedPosts != null) {
      return Right(_createPaginatedResponse(cachedPosts, params));
    }
    return Left(NoInternetConnectionFailure(message: e.errorMessage));
  }

  Future<Either<Failure, PaginatedResponse<PostModel>>> _handleServerError(
      ServerException e,
      PaginationParams params,
      ) async {
    // Try to get from cache
    final cachedPosts = await _getFromCache();
    if (cachedPosts != null) {
      return Right(_createPaginatedResponse(cachedPosts, params));
    }
    return Left(ServerFailure(message: e.message));
  }

  Future<Either<Failure, PaginatedResponse<PostModel>>> _handleTimeoutError(
      TimeOutExeption e,
      PaginationParams params,
      ) async {
    // Try to get from cache
    final cachedPosts = await _getFromCache();
    if (cachedPosts != null) {
      return Right(_createPaginatedResponse(cachedPosts, params));
    }
    return Left(TimeOutFailure(message: e.errorMessage));
  }

  PaginatedResponse<PostModel> _createPaginatedResponse(
      List<PostModel> cachedPosts,
      PaginationParams params,
      ) {
    final int start = ((params.page - 1) * params.limit);
    final int end = (start + params.limit);
    List<PostModel>  paginatedPosts = cachedPosts.length > start
        ? cachedPosts.sublist(
      start,
      end < cachedPosts.length ? end : cachedPosts.length,
    )
        : [];

    return PaginatedResponse(
      paginatedMeta: PaginatedMeta(
        limit: params.limit,
        page: params.page,
        pagesCount: (cachedPosts.length / params.limit).ceil(),
        totalPosts: cachedPosts.length ,
      ),
      items: paginatedPosts,
    );
  }
}