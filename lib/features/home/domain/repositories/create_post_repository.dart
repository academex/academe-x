
import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CreatePostRepository {
  CreatePostRepository();
  Future<Either<Failure, PostEntity>> createPost(PostEntity post);
  Future<Either<Failure, List<MajorEntity>>> getTags();

}
