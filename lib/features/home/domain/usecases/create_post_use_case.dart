import 'package:academe_x/lib.dart';
import 'package:dartz/dartz.dart';

class CreatePostUseCase {
  CreatePostRepository createPostRepository;
  CreatePostUseCase({required this.createPostRepository});

  Future<Either<Failure, PostReqEntity>> createPost(PostReqEntity post) async {
    return await createPostRepository.createPost(post);
  }
}
