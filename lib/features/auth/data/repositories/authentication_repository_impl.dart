import 'dart:async';
import 'package:academe_x/core/constants/cache_keys.dart';
import 'package:academe_x/lib.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final HiveCacheManager cacheManager;
  final InternetConnectionChecker networkInfo;
  // static const String COLLEGES_CACHE_KEY = 'colleges';

  AuthenticationRepositoryImpl({required this.remoteDataSource,required this.cacheManager,required this.networkInfo});

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
    } catch (e,stack) {
      AppLogger.i('why did you make this error,$stack');
      return Left(ServerFailure(message: 'Im here An error occurred: $e'));
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
  // @override
  // Future<Either<Failure, List<CollegeModel>>> getColleges() async {
  //   try {
  //     AppLogger.i('Getting colleges from cache first');
  //     final cached = await cacheManager.getCachedResponse<List<CollegeModel>>(
  //       CacheKeys.COLLEGES,
  //           (dynamic data) {
  //         AppLogger.i('Parsing cached data: $data');
  //         final List<dynamic> list = data as List;
  //         return list.map((item) {
  //           AppLogger.i('Parsing item: $item');
  //           return CollegeModel.fromJson(item as Map<String, dynamic>);
  //         }).toList();
  //       },
  //     );
  //
  //     if (cached != null) {
  //       AppLogger.i('Returning cached data: $cached');
  //       return Right(cached);
  //     }
  //
  //     AppLogger.i('No cache found, fetching from remote');
  //     final result = await remoteDataSource.getColleges();
  //     AppLogger.i('Got remote data: $result');
  //
  //     await cacheManager.cacheResponse(CacheKeys.COLLEGES, result);
  //     return Right(result);
  //   }on ValidationException catch (e) {
  //     return Left(ValidationFailure(messages: e.messages, message: ''));
  //   } on UnauthorizedException catch (e) {
  //     return Left(UnauthorizedFailure(message: e.message));
  //   }on NotFoundException catch (e) {
  //     return Left(NotFoundFailure(message: e.message));
  //   } on OfflineException catch (e) {
  //     return Left(NoInternetConnectionFailure(message: e.errorMessage));
  //   } on TimeOutExeption catch (e) {
  //     return Left(TimeOutFailure(message: e.errorMessage));
  //   } catch (e,stackTrace) {
  //     AppLogger.i('Error in getColleges: $e\n$stackTrace');
  //     return Left(ServerFailure(message: 'An error occurred: $e'));
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, List<MajorModel>>> getMajorsByCollege(String collegeName) async {
  //   try {
  //     AppLogger.i('Getting majors from cache first');
  //     final cached = await cacheManager.getCachedResponse<List<MajorModel>>(
  //       CacheKeys.MAJORS,
  //           (dynamic data) {
  //         final List<dynamic> list = data as List;
  //         return list.map((item) {
  //           AppLogger.i('Parsing item: $item');
  //           return MajorModel.fromJson(item as Map<String, dynamic>);
  //         }).toList();
  //       },
  //     );
  //
  //     if (cached != null) {
  //       AppLogger.i('Returning cached data: $cached');
  //       return Right(cached);
  //     }
  //
  //     AppLogger.i('No cache found, fetching from remote');
  //     final majorsByName = await remoteDataSource.getMajorsByCollege(collegeName);
  //
  //     await cacheManager.cacheResponse(CacheKeys.MAJORS, majorsByName);
  //     return Right(majorsByName);
  //   }on ValidationException catch (e) {
  //     return Left(ValidationFailure(messages: e.messages, message: ''));
  //   } on UnauthorizedException catch (e) {
  //     return Left(UnauthorizedFailure(message: e.message));
  //   }on NotFoundException catch (e) {
  //     return Left(NotFoundFailure(message: e.message));
  //   } on OfflineException catch (e) {
  //     return Left(NoInternetConnectionFailure(message: e.errorMessage));
  //   } on TimeOutExeption catch (e) {
  //     return Left(TimeOutFailure(message: e.errorMessage));
  //   } catch (e,stackTrace) {
  //     AppLogger.i('Error in getColleges: $e\n$stackTrace');
  //     return Left(ServerFailure(message: 'An error occurred: $e'));
  //   }
  // }
  //
  // Future<List<CollegeModel>> _fetchAndCacheColleges() async {
  //   final collegesList = await remoteDataSource.getColleges();
  //
  //   await cacheManager.cacheResponse<List<CollegeModel>>(CacheKeys.COLLEGES,collegesList);
  //
  //   return collegesList;
  // }
  //
  // // Method to force refresh colleges data
  // Future<Either<Failure, List<CollegeModel>>> refreshColleges() async {
  //   try {
  //     if (!await networkInfo.hasConnection) {
  //       return Left(NoInternetConnectionFailure(
  //           message: 'No internet connection available for refresh'
  //       ));
  //     }
  //
  //     final result = await _fetchAndCacheColleges();
  //     return Right(result);
  //   } catch (e, stackTrace) {
  //     AppLogger.e('Error in refreshColleges: $e\n$stackTrace');
  //     return Left(ServerFailure(message: 'Failed to refresh colleges: $e'));
  //   }
  // }
  //
  // // Method to clear colleges cache
  // Future<void> clearCollegesCache() async {
  //   try {
  //     await cacheManager.removeCacheItem(CacheKeys.COLLEGES);
  //   } catch (e) {
  //     AppLogger.e('Error clearing colleges cache: $e');
  //   }
  // }
  //

}



