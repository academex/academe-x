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
  Future<Either<Failure, PaginatedResponse<PostModel>>> getPosts(PaginationParams paginationParams) async {


    try {
      // First try to get from network
      final result = await remoteDataSource.getPosts(paginationParams);

      // Cache successful network response
      _cachePostsResults(result.items, paginationParams.page,tagId: paginationParams.tagId);

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

  Future<void> _cachePostsResults(List<PostModel> posts, int page,{int? tagId}) async {
    try {
      if (page == 1) {
        // For first page, replace cache
        await cacheManager.cacheResponse(
          '${CacheKeys.POSTS}/$tagId',
          posts.map((post) => post.toJson()).toList(),
        );
      } else {
        // For pagination, merge with existing cache
        final existingCache = await _getPostsFromCache();
        if (existingCache != null) {
          final mergedPosts = _mergePosts(existingCache, posts);
          await cacheManager.cacheResponse(
            '${CacheKeys.POSTS}/$tagId',
            mergedPosts.map((post) => post.toJson()).toList(),
          );
        }
      }
    } catch (e,stack) {
      AppLogger.w('Cache operation failed: $e  ${stack}');
      // Don't throw - caching errors shouldn't affect the main flow
    }
  }

  Future<List<PostModel>?> _getPostsFromCache({int? tagId}) async {
    try {
      var x= await cacheManager.getCachedResponse<List<PostModel>>(
        '${CacheKeys.POSTS}/$tagId',
            (json) => (json as List)
            .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
            .toList(),


      );
      AppLogger.success('_getPostsFromCache $x');


      return x;


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
    final cachedPosts = await _getPostsFromCache(tagId: params.tagId);
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
    final cachedPosts = await _getPostsFromCache(tagId: params.tagId);
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
    final cachedPosts = await _getPostsFromCache(tagId: params.tagId);
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
      statisticsModel: null
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