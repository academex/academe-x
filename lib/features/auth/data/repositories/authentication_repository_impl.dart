import 'dart:async';
import 'dart:convert';
import 'package:academe_x/core/constants/cache_keys.dart';
import 'package:academe_x/features/auth/data/models/response/college_model.dart';
import 'package:academe_x/lib.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/services/hive_cache_manager.dart';


class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final HiveCacheManager cacheManager;
  // static const String COLLEGES_CACHE_KEY = 'colleges';

  AuthenticationRepositoryImpl({required this.remoteDataSource,required this.cacheManager});

  @override
  Future<Either<Failure, AuthTokenModel>> login(LoginRequsetEntity user) async {
    try {
      final result = await remoteDataSource.login(
        LoginRequsetModel.fromEntity(user),
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
  Future<Either<Failure, AuthTokenModel>> signup(SignupRequestEntity user) async {
    try {
      final result = await remoteDataSource.signup(
        SignupRequestModel.fromEntity(user),
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
  Future<Either<Failure, List<CollegeModel>>> getColleges() async {
    try {
      AppLogger.i('Getting colleges from cache first');
      final cached = await cacheManager.getCachedResponse<List<CollegeModel>>(
        CacheKeys.COLLEGES,
            (dynamic data) {
          AppLogger.i('Parsing cached data: $data');
          final List<dynamic> list = data as List;
          return list.map((item) {
            AppLogger.i('Parsing item: $item');
            return CollegeModel.fromJson(item as Map<String, dynamic>);
          }).toList();
        },
      );

      if (cached != null) {
        AppLogger.i('Returning cached data: $cached');
        return Right(cached);
      }

      AppLogger.i('No cache found, fetching from remote');
      final result = await remoteDataSource.getColleges();
      AppLogger.i('Got remote data: $result');

      await cacheManager.cacheResponse(CacheKeys.COLLEGES, result);
      return Right(result);
    } catch (e, stackTrace) {
      AppLogger.i('Error in getColleges: $e\n$stackTrace');
      return Left(ServerFailure(message: 'An error occurred: $e'));
    }
  }
  // Future<Either<Failure, List<CollegeModel>>> getColleges() async {
  //   try {
  //
  //     // Try to get cached data first
  //     var cached= await cacheManager.getCachedResponse<List<CollegeModel>>(
  //       CacheKeys.COLLEGES,
  //           (dynamic data) {
  //             // AppLogger.database(data.toString());
  //
  //
  //         return (data as List)
  //             .map((item) {
  //           AppLogger.e(' cache ${item.toString()}');
  //               return CollegeModel.fromJson(item as Map<String, dynamic>);
  //         })
  //             .toList();
  //           },
  //     );
  //
  //     // AppLogger.database(cached.toString());
  //
  //
  //     if (cached != null) {
  //       return Right(cached);
  //     }
  //
  //
  //     AppLogger.e('not found in cache');
  //
  //     // If no cache, fetch from remote
  //     final result = await remoteDataSource.getColleges();
  //
  //     // Cache the new data
  //     await cacheManager.cacheResponse(CacheKeys.COLLEGES, result);
  //
  //     return Right(result);
  //   } on UnauthorizedException catch (e) {
  //     return Left(UnauthorizedFailure(message: e.message));
  //   } on OfflineException catch (e) {
  //     // Try to get cached data when offline
  //     final cached = await cacheManager.getCachedResponse<List<CollegeModel>>(
  //       CacheKeys.COLLEGES,
  //           (dynamic data) => (data as List)
  //           .map((item) => CollegeModel.fromJson(item as Map<String, dynamic>))
  //           .toList(),
  //           // (json) => CollegeModel.fromJson(json),
  //
  //     );
  //
  //     if (cached != null) {
  //       return Right(cached);
  //     }
  //     return Left(NoInternetConnectionFailure(message: e.errorMessage));
  //   } catch (e) {
  //     return Left(ServerFailure(message: 'An error occurred: $e'));
  //   }
  // }
  // Future<Either<Failure, List<CollegeModel>>> getColleges() async{
  //   try {
  //     final cached =await cacheManager.getCachedResponse(CacheKeys.COLLEGES);
  //     AppLogger.success('int get college impl ${cached.toString()}');
  //
  //     if (cached != null) {
  //       return Right(jsonDecode(cached) as List<CollegeModel>);
  //     }
  //     AppLogger.success('after cache');
  //
  //     final result = await remoteDataSource.getColleges();
  //     return Right(result);
  //   } on UnauthorizedException catch (e) {
  //     return Left(UnauthorizedFailure(message: e.message));
  //   } on OfflineException catch (e) {
  //     return Left(NoInternetConnectionFailure(message: e.errorMessage));
  //   } on NotFoundException catch (e) {
  //     return Left(NotFoundFailure(message: e.message));
  //   } on TooManyRequestsException catch (e) {
  //     return Left(TooManyRequestsFailure(message: e.message));
  //   } on TimeOutExeption catch (e) {
  //     return Left(TimeOutFailure(message: e.errorMessage));
  //   } catch (e) {
  //     return Left(ServerFailure(message: 'An error occurred: $e'));
  //   }
  // }

}



