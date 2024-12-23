import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:academe_x/features/home/data/datasources/post_remote_data_source.dart';
import 'package:academe_x/features/home/data/models/post/comment_model.dart';
import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:academe_x/features/home/domain/entities/post/comment_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/tag_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/network/base_response.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../entities/post/reaction_item_entity.dart';
import '../entities/post/save_response_entity.dart';

abstract class PostRepository {
  PostRepository();
  Future<Either<Failure, PaginatedResponse<PostModel>>>getPosts(PaginationParams paginationParams);
  Future<Either<Failure, BaseResponse<PostModel>>>getPostDetails(PaginationParams paginationParams);
  Future<Either<Failure, void>>reactToPost(String reactionType,int postId);
  Future<Either<Failure, BaseResponse<SaveResponseEntity>>>savePost(int postId);
  Future<Either<Failure, PaginatedResponse<ReactionItemEntity>>>getReactions(PaginationParams paginationParams,String reactionType,int postId);
  Future<Either<Failure, PostEntity>> createPost(PostEntity post);
  Future<Either<Failure, List<MajorEntity>>> getTags();
  Future<Either<Failure, CreatePostBaseResponse>> createComment({required int postId,required String content});
  Future<Either<Failure, PaginatedResponse<CommentModel>>>  getComments(PaginationParams paginationParams,int postId);

}
