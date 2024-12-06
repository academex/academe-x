import 'package:academe_x/core/network/base_response.dart';
import 'package:academe_x/features/college_major/data/data.dart';
import 'package:academe_x/features/college_major/data/models/college_model.dart';
import 'package:academe_x/features/college_major/data/models/major_model.dart';
import 'package:academe_x/features/college_major/domain/domain.dart';
import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:academe_x/features/home/data/models/post/save_response_model.dart';
import 'package:academe_x/features/home/domain/entities/post/reaction_item_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/constants/cache_keys.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';

import '../../../../core/storage/cache/hive_cache_manager.dart';
import '../../../../core/utils/logger.dart';


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

  @override
  Future<Either<Failure, List<MajorModel>>> getMajorsByCollege(String collegeName) async {
    try {
      AppLogger.i('Getting majors from cache first');
      final cached = await cacheManager.getCachedResponse<List<MajorModel>>(
        CacheKeys.MAJORS,
            (dynamic data) {
          final List<dynamic> list = data as List;
          return list.map((item) {
            AppLogger.i('Parsing item: $item');
            return MajorModel.fromJson(item as Map<String, dynamic>);
          }).toList();
        },
      );

      if (cached != null) {
        AppLogger.i('Returning cached data: $cached');
        return Right(cached);
      }

      AppLogger.i('No cache found, fetching from remote');
      final majorsByName = await remoteDataSource.getMajorsByCollege(collegeName);

      await cacheManager.cacheResponse(CacheKeys.MAJORS, majorsByName);
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