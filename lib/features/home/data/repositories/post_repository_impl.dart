

import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  // final NetworkConnection networkConnection;
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  // @override
  // Future<Either<Failure, List<PostModel>>> getPosts(PaginationParams paginationParams) async {
  //   // TODO: implement getProductHomeData
  //   try {
  //     final result = await remoteDataSource.getPosts(paginationParams);
  //
  //     return Right(result);
  //   } on ServerException {
  //     return Left(ServerFailure(message: 'something went wrong'));
  //   }
  // }


  @override
  Future<Either<Failure, PaginatedResponse<PostModel>>> getPosts(PaginationParams paginationParams) async {
    try {
      final result = await remoteDataSource.getPosts(
        paginationParams
      );
      return Right(result);
    } on ValidationException catch (e) {
      return Left(ValidationFailure(messages: e.messages, message: ''));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(message: e.errorMessage));
    } on TimeOutExeption catch (e) {
      return Left(TimeOutFailure(message: e.errorMessage));
    } catch (e,stack) {
      AppLogger.i('why did you make this error,$stack');
      return Left(ServerFailure(message: 'Im here An error occurred: $e'));
    }
  }


}