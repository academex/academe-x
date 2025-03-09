import 'package:academe_x/features/college_major/domain/entities/college_entity.dart';
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class CollegeMajorRepository {
  CollegeMajorRepository();
  Future<Either<Failure, List<CollegeEntity>>>getColleges();
  Future<Either<Failure, List<MajorEntity>>>getMajorsByCollege(String collegeName);
  Future<Either<Failure, List<MajorEntity>>> getTags();
  // Future<Either<Failure, PaginatedResponse<PostModel>>>getPosts(PaginationParams paginationParams);
  // Future<Either<Failure, void>>reactToPost(String reactionType,int postId);
  // Future<Either<Failure, BaseResponse<SaveResponseEntity>>>savePost(int postId);
  // Future<Either<Failure, PaginatedResponse<ReactionItemEntity>>>getReactions(PaginationParams paginationParams,String reactionType,int postId);

}