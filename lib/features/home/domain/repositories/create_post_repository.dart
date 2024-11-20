import 'package:academe_x/lib.dart';
import 'package:dartz/dartz.dart';

abstract class CreatePostRepository {
  CreatePostRepository();
  Future<Either<Failure, PostReqEntity>> createPost(PostReqEntity post);
}
