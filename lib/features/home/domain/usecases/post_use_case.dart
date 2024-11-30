
import 'package:academe_x/features/features.dart';
import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/pagination/pagination_params.dart';

class PostUseCase {
  PostRepository postRepository;
  PostUseCase({required this.postRepository});

  Future<Either<Failure, PaginatedResponse<PostEntity>>> getPosts(PaginationParams paginationParams) async {
    return await postRepository.getPosts(paginationParams);
  }


  Future<Either<Failure, void>> reactToPost(String reactionType,int postId) async {
    return await postRepository.reactToPost(reactionType,postId);
  }






}