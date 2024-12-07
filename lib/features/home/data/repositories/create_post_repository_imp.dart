import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/create_post_repository.dart';
import '../datasources/create_post/create_post_remote_data_source.dart';

class CreatePostRepositoryImp implements CreatePostRepository {
  CreatePostRemoteDataSource createPostRemoteDataSource;
  CreatePostRepositoryImp({required this.createPostRemoteDataSource});
  @override
  Future<Either<Failure, PostEntity>> createPost(PostEntity post) async {
    try {
      final result = await createPostRemoteDataSource.createPost(
        post: PostModel.fromEntity(post),
      );
      return Right(result);
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(message: e.errorMessage));
    } on TimeOutExeption catch (e) {
      return Left(TimeOutFailure(message: e.errorMessage));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(
          message: e.messages.first, messages: [e.messages.first]));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(message: 'Server Failure : $e'));
    }
  }

  @override
  Future<Either<Failure, List<MajorEntity>>> getTags() async {
    try {
      final result = await createPostRemoteDataSource.getTags();
      return Right(result);
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(message: e.errorMessage));
    } on TimeOutExeption catch (e) {
      return Left(TimeOutFailure(message: e.errorMessage));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(
          message: e.messages.first, messages: [e.messages.first]));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(message: 'Server Failure : $e'));
    }
  }
}
