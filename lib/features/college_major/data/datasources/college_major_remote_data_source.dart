import 'dart:async';
import 'dart:convert';
import 'package:academe_x/core/utils/network/base_response.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/college_major/data/models/college_model.dart';
import 'package:academe_x/features/college_major/data/models/major_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../academeX_main.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/network/api_controller.dart';
import '../../../../core/utils/network/api_setting.dart';
import '../../../../core/utils/handle_http_error.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/storage/cache/hive_cache_manager.dart';
typedef CollegesResponse  = BaseResponse<List<CollegeModel>>;
typedef MajorsResponse  = BaseResponse<List<MajorModel>>;
typedef TagBaseResponse = BaseResponse<List<MajorModel>>;



class CollegeMajorRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;


  CollegeMajorRemoteDataSource({required this.apiController,required this.internetConnectionChecker});


  Future<List<CollegeModel>> getColleges() async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(ApiSetting.colleges),
          headers: {
            'Content-Type': 'application/json',
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if(response.statusCode>=400){
          HandleHttpError.handleHttpError(responseBody);
        }

        final CollegesResponse baseResponse = CollegesResponse.fromJson(
          responseBody,
              (dynamic json) => (json as List)
              .map((item) => CollegeModel.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
        return baseResponse.data!;


      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }


  Future<List<MajorModel>> getTags() async {
    List<MajorModel>? majorCached =
    await (NavigationService.navigatorKey.currentContext!.cachMajor);
    if (majorCached == null) {
      final response =
      await apiController.get(Uri.parse(ApiSetting.getTags), headers: {
        'Authorization':
        'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}',
      });
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode >= 400) {
        HandleHttpError.handleHttpError(responseBody);
      }
      final TagBaseResponse baseResponse = TagBaseResponse.fromJson(
        responseBody,
            (json) => (json as List)
            .map(
              (e) => MajorModel.fromJson(e),
        )
            .toList(),
      );
      try {
        // AppLogger.success('in cacheAuthUser ${user.toString()}');
        await getIt<HiveCacheManager>()
            .cacheResponse(CacheKeys.MAJORS, baseResponse.data);

      } catch (e) {
        AppLogger.e('Failed to cache Major: $e');
        rethrow;
      }
      return baseResponse.data!;
    } else {
      List<MajorModel> tags = majorCached!
          .map(
            (e) => MajorModel.fromJson(e.toJson()),
      )
          .toList();
      return tags;
    }
  }

  Future<List<MajorModel>> getMajorsByCollege(String majorName) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse('${ApiSetting.majors}?collegeEn=$majorName') ,
          headers: {
            'Content-Type': 'application/json',
          },
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if(response.statusCode>=400){
          HandleHttpError.handleHttpError(responseBody);
        }

        final MajorsResponse baseResponse = MajorsResponse.fromJson(
          responseBody,
              (dynamic json) => (json as List)
              .map((item) => MajorModel.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
        return baseResponse.data!;

      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

}

