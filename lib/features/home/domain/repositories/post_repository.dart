import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/pagination/pagination_params.dart';

abstract class PostRepository {
  PostRepository();
  Future<Either<Failure, PaginatedResponse<PostModel>>>getPosts(PaginationParams paginationParams);
  Future<Either<Failure, void>>reactToPost(String reactionType,int postId);

}