import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:academe_x/features/home/domain/domain.dart';
import 'package:academe_x/features/home/domain/entities/post/tag_entity.dart';
import 'package:dartz/dartz.dart';

class GetTagsUseCase {
  final CreatePostRepository createPostRepository;
  GetTagsUseCase({required this.createPostRepository});
  Future<Either<Failure, List<MajorEntity>>> getTags() async {
    return await createPostRepository.getTags();
  }
}
