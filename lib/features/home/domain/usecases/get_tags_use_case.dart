import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/domain/domain.dart';
import 'package:academe_x/features/home/domain/entities/post/tag_entity.dart';
import 'package:dartz/dartz.dart';

class GetTags{
  final CreatePostRepository createPostRepository;
  GetTags({required this.createPostRepository});
  Future<Either<Failure, List<TagEntity>>> getTags() async {
    return await createPostRepository.getTags();
  }
}