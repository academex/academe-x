import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/lib.dart';
import 'package:dartz/dartz.dart';

class CreatePostUseCase {
  CreatePostRepository createPostRepository;
  CreatePostUseCase({required this.createPostRepository});

  Future<Either<Failure, PostEntity>> createPost(PostEntity post) async {
    return await createPostRepository.createPost(post);
  }
}
