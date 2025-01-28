import 'dart:math';

import 'package:academe_x/core/config/app_config.dart';
import 'package:academe_x/core/utils/network/base_response.dart';
import 'package:academe_x/features/college_major/data/models/major_model.dart';
import 'package:academe_x/features/home/data/models/post/comment_model.dart';
import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:academe_x/features/home/data/models/post/save_response_model.dart';
import 'package:academe_x/features/home/domain/entities/post/comment_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/reaction_item_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/cache_keys.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/pagination/paginated_meta.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/storage/cache/hive_cache_manager.dart';
import '../../../../core/utils/storage/entery/cached_paginated_data.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/create_post/create_post_remote_data_source.dart';
import '../datasources/post_remote_data_source.dart';


class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final CreatePostRemoteDataSource createPostRemoteDataSource;
  final HiveCacheManager cacheManager;

  PostRepositoryImpl({
    required this.createPostRemoteDataSource,
    required this.remoteDataSource,
    required this.cacheManager,
  });

  @override
  Future<Either<Failure, PaginatedResponse<PostModel>>> getPosts(
      PaginationParams paginationParams
      ) async {
    try {
      // Try to get from network
      final result = await remoteDataSource.getPosts(paginationParams);
      AppLogger.success('get posts ${paginationParams.page}');

      // Cache successful network response
      await _cachePostsResults(
        result.items,
        paginationParams.page,
        tagId: paginationParams.tagId,
      );

      return Right(result);
    } on OfflineException catch (e) {
      AppLogger.success('no internet connection');
      return _handleOfflineCase(e, paginationParams);
    } on ServerException catch (e) {
      return _handleServerError(e, paginationParams);
    } on TimeOutExeption catch (e) {
      return _handleTimeoutError(e, paginationParams);
    } catch (e, stack) {
      AppLogger.e('Unexpected error: $e\n$stack');
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<PostModel>>> getPostDetails(PaginationParams paginationParams) async {
    try {
      // First try to get from network
      final result = await remoteDataSource.getPostDetails(paginationParams);

      // Cache successful network response

      return Right(result);
    } on OfflineException catch (e) {
      // Handle offline case by trying cache
      return Left(NoInternetConnectionFailure(message:e.errorMessage));
      // return _handleOfflineCase(e, paginationParams);
    } on ServerException catch (e) {
      // On server error, try cache first
      return Left(ServerFailure(message:e.message));
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

  Future<void> _cachePostsResults(
      List<PostModel> posts,
      int page,
      {int? tagId}
      ) async {
    try {
      final cacheKey = '${CacheKeys.POSTS}/$tagId';

      final existingCache = await _getPostsFromCache(tagId: tagId);
      final existingData = existingCache?.posts ?? [];
      final existingPages = existingCache?.pageToPostIds ?? {};
      final existingTimestamps = existingCache?.pageTimestamps ?? {};

      final mergedPosts = _mergePosts(existingData, posts);

      final pagePostIds = posts.map((post) => post.id!).toList();
      final updatedPages = Map<int, List<int>>.from(existingPages);
      final updatedTimestamps = Map<int, DateTime>.from(existingTimestamps);

      updatedPages[page] = pagePostIds;
      updatedTimestamps[page] = DateTime.now();

      final cachedData = CachedPaginatedData(
        posts: mergedPosts,
        pageToPostIds: updatedPages,
        pageTimestamps: updatedTimestamps,
      );

      // Cache the updated data
      await cacheManager.cacheResponse(
        cacheKey,
        cachedData.toJson(),
      );
      AppLogger.success('caching ${cachedData.posts.length}');
    } catch (e, stack) {
      AppLogger.w('Cache operation failed: $e\n$stack');
    }
  }


  Future<CachedPaginatedData?> _getPostsFromCache({int? tagId}) async {
    try {
      AppLogger.success('inside _getPostsFromCache and going to get from cache');
      final cachedData = await cacheManager.getCachedResponse<CachedPaginatedData>(
        '${CacheKeys.POSTS}/$tagId',
            (json) => CachedPaginatedData.fromJson(json as Map<String, dynamic>),
      );
      AppLogger.success('cache ${cachedData?.posts.length}');

      if (cachedData == null) return null;
      final now = DateTime.now();
      final validPages = Map<int, List<int>>.fromEntries(
          cachedData.pageToPostIds.entries.where((entry) {
            final pageTimestamp = cachedData.pageTimestamps[entry.key];
            return pageTimestamp != null &&
                now.difference(pageTimestamp) <= AppConfig.cacheMaxAge;
          })
      );

      if (validPages.isEmpty) return null;

      final validPostIds = validPages.values.expand((ids) => ids).toSet();
      final validPosts = cachedData.posts
          .where((post) => validPostIds.contains(post.id))
          .toList();

      AppLogger.success('message ${validPosts.length}');

      return CachedPaginatedData(
        posts: validPosts,
        pageToPostIds: validPages,
        pageTimestamps: Map<int, DateTime>.fromEntries(
            cachedData.pageTimestamps.entries.where(
                    (entry) => validPages.containsKey(entry.key)
            )
        ),
      );
    } catch (e) {
      AppLogger.w('Failed to get from cache: $e');
      return null;
    }
  }

  List<PostModel> _mergePosts(List<PostModel> existing, List<PostModel> new_) {
    final merged = [...existing];
    final existingIds = existing.map((p) => p.id!).toSet();

    for (var post in new_) {
      if (!existingIds.contains(post.id)) {
        merged.add(post);
        existingIds.add(post.id!);
      }
    }

    // Sort by creation date if available
    merged.sort((a, b) => b.createdAt?.compareTo(a.createdAt!) ?? 0);
    return merged;
  }

  Future<Either<Failure, PaginatedResponse<PostModel>>> _handleOfflineCase(
      OfflineException e,
      PaginationParams paginationParams,
      ) async {
    try {
      AppLogger.success('inside handle offline case and going to get posts from cache');
      final cachedData = await _getPostsFromCache(tagId: paginationParams.tagId);

      if (cachedData == null || cachedData.posts.isEmpty) {
        return Left(NoInternetConnectionFailure(
          message: 'No cached data available. Please check your internet connection.',
        ));
      }

      // Check if we have valid data for this page
      if (!cachedData.pageToPostIds.containsKey(paginationParams.page)) {
        return Left(NoInternetConnectionFailure(
          message: 'No cached data available for this page.',
        ));
      }

      final paginatedResponse = _createPaginatedResponse(
        cachedData,
        paginationParams,
      );

      return Right(paginatedResponse);
    } catch (error) {
      return Left(NoInternetConnectionFailure(
        message: 'Error accessing cached data: ${error.toString()}',
      ));
    }
  }

  Future<Either<Failure, PaginatedResponse<PostModel>>> _handleServerError(
      ServerException e,
      PaginationParams params,
      ) async {
    // Try to get from cache
    final cachedData = await _getPostsFromCache(tagId: params.tagId);
    if (cachedData != null &&
        cachedData.pageToPostIds.containsKey(params.page)) {
      return Right(_createPaginatedResponse(cachedData, params));
    }
    return Left(ServerFailure(message: e.message));
  }

  Future<Either<Failure, PaginatedResponse<PostModel>>> _handleTimeoutError(
      TimeOutExeption e,
      PaginationParams params,
      ) async {
    // Try to get from cache
    final cachedData = await _getPostsFromCache(tagId: params.tagId);
    if (cachedData != null &&
        cachedData.pageToPostIds.containsKey(params.page)) {
      return Right(_createPaginatedResponse(cachedData, params));
    }
    return Left(TimeOutFailure(message: e.errorMessage));
  }

  PaginatedResponse<PostModel> _createPaginatedResponse(
      CachedPaginatedData cachedData,
      PaginationParams params,
      ) {
    // Get post IDs for the requested page
    final pagePostIds = cachedData.pageToPostIds[params.page] ?? [];

    // Get the actual posts for this page
    final paginatedPosts = pagePostIds
        .map((id) => cachedData.posts.firstWhere(
          (post) => post.id == id,
      orElse: () => throw Exception('Post not found in cache'),
    ))
        .toList();

    // Calculate pagination metadata
    final totalPages = cachedData.pageToPostIds.length;
    final totalPosts = cachedData.posts.length;

    return PaginatedResponse(
      paginatedMeta: PaginatedMeta(
        limit: params.limit,
        page: params.page,
        pagesCount: totalPages,
        totalPosts: totalPosts,
      ),
      items: paginatedPosts,
      statisticsModel: null,
    );
  }

  @override
  Future<Either<Failure, BaseResponse<SaveResponseModel>>> savePost(int postId) async{
    try {
      // First try to get from network
      final result = await remoteDataSource.savePost(postId);
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

  @override
  Future<Either<Failure, PaginatedResponse<ReactionItemEntity>>> getReactions(PaginationParams paginationParams,String reactionType,int postId) async{
    try {
      // First try to get from network
      final result = await remoteDataSource.getReactions(paginationParams,reactionType,postId);

      // Cache successful network response
      // _cacheResults(result.items, paginationParams.page);

      return Right(result);
    } on OfflineException catch (e) {
      // Handle offline case by trying cache
      // return _handleOfflineCase(e, paginationParams);
      return Left(NoInternetConnectionFailure(message: e.errorMessage));
    } on ServerException catch (e) {
      // On server error, try cache first
      return Left(ServerFailure( message:e.message));
      // return _handleServerError(e, paginationParams);
    } on ValidationException catch (e) {
      return Left(ValidationFailure(messages: e.messages, message: ''));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } on TimeOutExeption catch (e) {
      return Left(TimeOutFailure(message: e.errorMessage));
      // On timeout, try cache
      // return _handleTimeoutError(e, paginationParams);
    } catch (e, stack) {
      AppLogger.e('Unexpected error: $e\n$stack');
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, PostEntity>> createPost(PostEntity post,BuildContext context,) async {
    return handlingException<PostEntity>(() => createPostRemoteDataSource.createPost(
      post: PostModel.fromEntity(post),
      context: context,
    ),);
  }

  @override
  Future<Either<Failure, List<MajorModel>>> getTags() async {
    return handlingException<List<MajorModel>>(() => createPostRemoteDataSource.getTags(),);
  }
  //Future<PaginatedResponse<CommentModel>>

  @override
  Future<Either<Failure, PaginatedResponse<CommentModel>>> getComments(PaginationParams paginationParams,int postId) {
    return handlingException<PaginatedResponse<CommentModel>>(() => remoteDataSource.getComments(paginationParams: paginationParams,postId: postId),);
  }

  @override
  Future<Either<Failure, CreatePostBaseResponse>> createComment({required int postId, required String content}) {
    return handlingException<CreatePostBaseResponse>(() => remoteDataSource.createComment(postId:postId,content:content),);
  }


  Future<Either<Failure, T>> handlingException<T>(Future<T> Function() implementRemoteDataSourceMethod) async{
    try {

      final result = await implementRemoteDataSourceMethod();
      if(T is Unit) {
        return Right(Unit as T);
      }else {
        return Right(result);
      }
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(message: e.errorMessage));
    } on TimeOutExeption catch (e) {
      return Left(TimeOutFailure(message: e.errorMessage));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(
          message: e.messages.first, messages: [e.messages.first]));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(message: 'Server Failure : $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteComment({required int postId, required int commentId}) {
    return handlingException<Unit>(() => remoteDataSource.deleteComment(postId:postId,commentId: commentId),);
  }

  @override
  Future<Either<Failure, CreatePostBaseResponse>> updateComment({required int postId, required String content, required int commentId}) {
    return handlingException<CreatePostBaseResponse>(() => remoteDataSource.updateComment(postId:postId,content:content,commentId: commentId),);
  }

  @override
  Future<Either<Failure, BaseResponse<CommentModel>>> createReply({required int commentId, int? parentId,required String content}) {
    return handlingException<BaseResponse<CommentModel>>(() => remoteDataSource.createReply(commentId:commentId,parentId:parentId,content:content),);

  }

  @override
  Future<Either<Failure, BaseResponse<List<CommentModel>>>> getReplies({required int commentId}) {
    return handlingException<BaseResponse<List<CommentModel>>>(() => remoteDataSource.getReplies(commentId:commentId),);

  }

  @override
  Future<Either<Failure, BaseResponse<void>>> likeOnCommentOrReply({required int commentId, int? postId, int? replyId}) {
    return handlingException<BaseResponse<void>>(() => remoteDataSource.likeOnCommentOrReply(commentId:commentId,postId:postId,replyId:replyId),);
  }









}