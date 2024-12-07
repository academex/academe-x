
import 'package:academe_x/features/college_major/domain/entities/college_entity.dart';
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/college_major_repository.dart';

class CollegeMajorUseCase {
  CollegeMajorRepository collegeMajorRepository;
  CollegeMajorUseCase({required this.collegeMajorRepository});
  Future<Either<Failure, List<MajorEntity>>> getTags() async {
    return await collegeMajorRepository.getTags();
  }
  // Future<Either<Failure, PaginatedResponse<PostEntity>>> getPosts(PaginationParams paginationParams) async {
  //   return await postRepository.getPosts(paginationParams);
  // }
  //
  //
  // Future<Either<Failure, void>> reactToPost(String reactionType,int postId) async {
  //   return await postRepository.reactToPost(reactionType,postId);
  // }
  //
  //
  //
  // Future<Either<Failure, BaseResponse<SaveResponseEntity>>> savePost(int postId) async {
  //   return await postRepository.savePost(postId);
  // }
  //
  // Future<Either<Failure, PaginatedResponse<ReactionItemEntity>>> getReactions(PaginationParams paginationParams,String reactionType,int postId) async {
  //   return await postRepository.getReactions(paginationParams,reactionType,postId);
  // }
  //
  //


  Future<Either<Failure, List<CollegeEntity>>> getColleges() async {
    return await collegeMajorRepository.getColleges();
  }

  Future<Either<Failure, List<MajorEntity>>> getMajorsByCollege(String collegeName) async {
    return await collegeMajorRepository.getMajorsByCollege(collegeName);
  }


}