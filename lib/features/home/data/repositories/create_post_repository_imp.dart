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
