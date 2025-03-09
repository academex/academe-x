
import 'package:academe_x/core/utils/network/base_response.dart';
import 'package:academe_x/features/features.dart';
import 'package:academe_x/features/home/data/models/post/comment_model.dart';
import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:academe_x/features/home/domain/entities/post/comment_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/save_response_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/utils/logger.dart';
import '../entities/post/reaction_item_entity.dart';

class PostUseCase {
  PostRepository postRepository;
  PostUseCase({required this.postRepository});

  Future<Either<Failure, PaginatedResponse<PostEntity>>> getPosts(PaginationParams paginationParams) async {
    return await postRepository.getPosts(paginationParams);
  }

  Future<Either<Failure, BaseResponse<PostEntity>>> getPostDetails(PaginationParams paginationParams) async {
    return await postRepository.getPostDetails(paginationParams);
  }


  Future<Either<Failure, void>> reactToPost(String reactionType,int postId) async {
    return await postRepository.reactToPost(reactionType,postId);
  }

  Future<Either<Failure, PaginatedResponse<PostEntity>>> loadProfilePosts(
      PaginationParams params,
      ) async {
    // AppLogger.wtf('params.toString() ${params.toString()}');
    return await postRepository.loadProfilePosts(params);
  }



  Future<Either<Failure, BaseResponse<SaveResponseEntity>>> savePost(int postId) async {
    return await postRepository.savePost(postId);
  }

  Future<Either<Failure, PaginatedResponse<ReactionItemEntity>>> getReactions(PaginationParams paginationParams,String reactionType,int postId) async {
    return await postRepository.getReactions(paginationParams,reactionType,postId);
  }


  Future<Either<Failure, PostEntity>> createPost(PostEntity post,BuildContext context,) async {
    return await postRepository.createPost(post,context);
  }
  Future<Either<Failure, CreatePostBaseResponse>> createComment({required int postId,required String content}) async {
    return await postRepository.createComment(postId: postId,content: content);
  }

  Future<Either<Failure, CreatePostBaseResponse>> updateComment({required int postId,required String content,required int commentId}) async {
    return await postRepository.updateComment(postId: postId,content: content,commentId: commentId);
  }

  Future<Either<Failure, Unit>> deleteComment({required int postId,required int commentId}) async {
    return await postRepository.deleteComment(postId: postId,commentId: commentId);
  }

  Future<Either<Failure, PaginatedResponse<CommentModel>>> getComments(PaginationParams paginationParams,int postId) async {
    return await postRepository.getComments(paginationParams,postId);
  }

  Future<Either<Failure, BaseResponse<CommentModel>>> createReply(
      {required int commentId, int? parentId, required String content}) async {
    return await postRepository.createReply(
        commentId: commentId, parentId: parentId, content: content);
  }

  Future<Either<Failure, BaseResponse<List<CommentModel>>>> getReplies(
      {required int commentId}) async {
    return await postRepository.getReplies(commentId: commentId);
  }

  Future<Either<Failure, BaseResponse<void>>> likeOnCommentOrReply(
      {required int commentId, int? postId, int? replyId}) async {
    return await postRepository.likeOnCommentOrReply(
        commentId: commentId, postId: postId, replyId: replyId);
  }
}