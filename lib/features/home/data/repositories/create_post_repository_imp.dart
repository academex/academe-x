import 'package:academe_x/lib.dart';
import 'package:dartz/dartz.dart';

class CreatePostRepositoryImp implements CreatePostRepository {
  CreatePostRemoteDataSource createPostRemoteDataSourse;
  CreatePostRepositoryImp({required this.createPostRemoteDataSourse});
  @override
  Future<Either<Failure, PostReqModel>> createPost(PostReqEntity post) async {
    try {
      final result = await createPostRemoteDataSourse.createPost(
        post: post.fromEntity(),
      );
      return Right(result);
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(message: e.errorMessage));
    } on TimeOutExeption catch (e) {
      return Left(TimeOutFailure(message: e.errorMessage));
    } on Exception catch (e) {
      return Left(ServerFailure(message: 'An error occurred: $e'));
    }
  }
}
