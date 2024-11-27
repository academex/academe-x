import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/lib.dart';
import 'package:dartz/dartz.dart';

abstract class CreatePostRepository {
  CreatePostRepository();
  Future<Either<Failure, PostEntity>> createPost(PostEntity post);
}
