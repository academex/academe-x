import 'package:academe_x/core/error/exception.dart';
import 'package:academe_x/core/pagination/paginated_response.dart';
import 'package:academe_x/core/pagination/pagination_params.dart';
import 'package:academe_x/features/auth/domain/entities/response/user_response_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:academe_x/core/error/failure.dart';
import 'package:academe_x/features/profile/data/datasources/profile_remote_data_source.dart';

import '../../../auth/data/models/response/updated_user_model.dart';
import '../../../auth/domain/entities/response/updated_user_entity.dart';
import '../../../home/data/models/post/post_model.dart';
import '../../domain/repositories/user_profile_repositories.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});



  @override
  Future<Either<Failure, PaginatedResponse<PostModel>>> loadPosts(
      PaginationParams paginationParams
      ) async {
    try {
      // Try to get from network
      final result = await remoteDataSource.loadPosts(paginationParams);
      return Right(result);
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(
        message: e.errorMessage,
      ));
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    } on TimeOutExeption catch (e) {

      return Left(
        TimeOutFailure(
          message: e.errorMessage,
        ),
      );
    } catch (e, stack) {
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, UserResponseEntity>> getUserProfile(String userId)async {
    try {
      // Try to get from network
      final result = await remoteDataSource.getUserProfile(userId);
      return Right(result);
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(
        message: e.errorMessage,
      ));
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    } on TimeOutExeption catch (e) {

      return Left(
        TimeOutFailure(
          message: e.errorMessage,
        ),
      );
    } catch (e, stack) {
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  // @override

  // Future<Either<Failure, UserProfile>> getProfile() async {
  //   return handlingException<UserProfile>(
  //     () => remoteDataSource.getProfile(),
  //   );
  // }

  // @override
  // Future<Either<Failure, ProfileEntity>> updateProfile(
  //     ProfileEntity profile) async {
  //   return handlingException<ProfileEntity>(
  //     () => remoteDataSource.updateProfile(ProfileModel.fromEntity(profile)),
  //   );
  // }

  // Future<Either<Failure, T>> handlingException<T>(
  //     Future<T> Function() implementRemoteDataSourceMethod) async {
  //   try {
  //     final result = await implementRemoteDataSourceMethod();
  //     if (T is Unit) {
  //       return Right(Unit as T);
  //     } else {
  //       return Right(result);
  //     }
  //   } on OfflineException catch (e) {
  //     return Left(NoInternetConnectionFailure(message: e.errorMessage));
  //   } on TimeOutExeption catch (e) {
  //     return Left(TimeOutFailure(message: e.errorMessage));
  //   } on ValidationException catch (e) {
  //     return Left(ValidationFailure(
  //         message: e.messages.first, messages: [e.messages.first]));
  //   } on AuthException catch (e) {
  //     return Left(AuthFailure(message: e.errorMessage));
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(message: e.message));
  //   } on Exception catch (e) {
  //     return Left(ServerFailure(message: 'Server Failure : $e'));
  //   }
  // }

  @override
  Future<Either<Failure, UpdatedUserModel>> updateProfile(Map<String, dynamic> user) async {
    try {
      final result = await remoteDataSource.updateProfile(
          user
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
    } catch (e) {
      return Left(ServerFailure(message: 'An error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<PostEntity>>> loadSavedPosts(PaginationParams paginationParams) async{
    try {
      // Try to get from network
      final result = await remoteDataSource.loadSavedPosts(paginationParams);
      return Right(result);
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(
        message: e.errorMessage,
      ));
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    } on TimeOutExeption catch (e) {

      return Left(
        TimeOutFailure(
          message: e.errorMessage,
        ),
      );
    } catch (e, stack) {
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }

}
