import 'package:academe_x/features/college_major/data/data.dart';
import 'package:academe_x/features/college_major/data/models/college_model.dart';
import 'package:academe_x/features/college_major/data/models/major_model.dart';
import 'package:academe_x/features/college_major/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/constants/cache_keys.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';

import '../../../../core/utils/logger.dart';
import '../../../../core/utils/storage/cache/hive_cache_manager.dart';


class CollegeMajorRepositoryImpl implements CollegeMajorRepository {
  final CollegeMajorRemoteDataSource remoteDataSource;
  final HiveCacheManager cacheManager;
  final InternetConnectionChecker networkInfo;


  CollegeMajorRepositoryImpl({
    required this.remoteDataSource,
    required this.cacheManager,
    required this.networkInfo
  });

  @override
  Future<Either<Failure, List<CollegeModel>>> getColleges() async {
    try {
      final cached = await cacheManager.getCachedResponse<List<CollegeModel>>(
        CacheKeys.COLLEGES,
            (dynamic data) {
          final List<dynamic> list = data as List;
          return list.map((item) {
            return CollegeModel.fromJson(item as Map<String, dynamic>);
          }).toList();
        },
      );

      if (cached != null) {
        return Right(cached);
      }

      final result = await remoteDataSource.getColleges();

      await cacheManager.cacheResponse(CacheKeys.COLLEGES, result);
      return Right(result);
    }on ValidationException catch (e) {
      return Left(ValidationFailure(messages: e.messages, message: ''));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    }on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(message: e.errorMessage));
    } on TimeOutExeption catch (e) {
      return Left(TimeOutFailure(message: e.errorMessage));
    } catch (e,stackTrace) {
      AppLogger.i('Error in getColleges: $e\n$stackTrace');
      return Left(ServerFailure(message: 'An error occurred: $e'));
    }
  }

  Future<Either<Failure, List<MajorModel>>> getTags() async {
    try {
      final result = await remoteDataSource.getTags();
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
  Future<Either<Failure, List<MajorModel>>> getMajorsByCollege(String collegeName) async {
    try {
      final cached = await cacheManager.getCachedResponse<List<MajorModel>>(
        '${CacheKeys.MAJORS}/$collegeName',
            (dynamic data) {
          final List<dynamic> list = data as List;
          return list.map((item) {
            return MajorModel.fromJson(item as Map<String, dynamic>);
          }).toList();
        },
      );

      if (cached != null) {
        return Right(cached);
      }

      final majorsByName = await remoteDataSource.getMajorsByCollege(collegeName);

      await cacheManager.cacheResponse('${CacheKeys.MAJORS}/$collegeName', majorsByName);
      return Right(majorsByName);
    }on ValidationException catch (e) {
      return Left(ValidationFailure(messages: e.messages, message: ''));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    }on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(message: e.errorMessage));
    } on TimeOutExeption catch (e) {
      return Left(TimeOutFailure(message: e.errorMessage));
    } catch (e,stackTrace) {
      AppLogger.i('Error in getColleges: $e\n$stackTrace');
      return Left(ServerFailure(message: 'An error occurred: $e'));
    }
  }

  Future<List<CollegeModel>> _fetchAndCacheColleges() async {
    final collegesList = await remoteDataSource.getColleges();

    await cacheManager.cacheResponse<List<CollegeModel>>(CacheKeys.COLLEGES,collegesList);

    return collegesList;
  }

  // Method to force refresh colleges data
  Future<Either<Failure, List<CollegeModel>>> refreshColleges() async {
    try {
      if (!await networkInfo.hasConnection) {
        return Left(NoInternetConnectionFailure(
            message: 'No internet connection available for refresh'
        ));
      }

      final result = await _fetchAndCacheColleges();
      return Right(result);
    } catch (e, stackTrace) {
      AppLogger.e('Error in refreshColleges: $e\n$stackTrace');
      return Left(ServerFailure(message: 'Failed to refresh colleges: $e'));
    }
  }

  // Method to clear colleges cache
  Future<void> clearCollegesCache() async {
    try {
      await cacheManager.removeCacheItem(CacheKeys.COLLEGES);
    } catch (e) {
      AppLogger.e('Error clearing colleges cache: $e');
    }
  }


}