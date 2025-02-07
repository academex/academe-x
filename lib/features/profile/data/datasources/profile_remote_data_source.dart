import 'dart:convert';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/utils/network/api_controller.dart';
import 'package:academe_x/core/utils/network/api_setting.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/academeX_main.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/utils/handle_http_error.dart';
import '../../../../core/utils/network/base_response.dart';
import '../../../home/data/models/post/post_model.dart';

class ProfileRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  ProfileRemoteDataSource({
    required this.apiController,
    required this.internetConnectionChecker,
  });

  Future<PaginatedResponse<PostModel>> loadPosts(
      PaginationParams paginationParams) async {
    String url =
        '${ApiSetting.getUserPosts}/${paginationParams.username}?page=${paginationParams.page}';
    // if(paginationParams.userName != null){
    //   url = ApiSetting.getUserPosts+paginationParams.userName!;
    // }
    if (await internetConnectionChecker.hasConnection) {
      try {
        AppLogger.network(url);
        final response = await apiController.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
            'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}'
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final baseResponse =
        BaseResponse<PaginatedResponse<PostModel>>.fromJson(
          responseBody,
              (json) {
            return PaginatedResponse<PostModel>.fromJson(
              json,
                  (p0) {
                return PostModel.fromJson(p0);
              },
            );
          },
        );
        return baseResponse.data!;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  // Future<UserProfile> getProfile() async {
  //   if (await internetConnectionChecker.hasConnection) {
  //     final response = await apiController.get(
  //       Uri.parse(ApiSetting.getProfile),

  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization':
  //             'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}'
  //       },
  //     );

  //     final Map<String, dynamic> responseBody = jsonDecode(response.body);
  //     if (response.statusCode >= 400) {
  //       HandleHttpError.handleHttpError(responseBody);
  //     }

  //     return ProfileModel.fromJson(responseBody['data']);
  //   } else {
  //     throw OfflineException(errorMessage: 'No Internet Connection');
  //   }
  // }

  // Future<ProfileModel> updateProfile(ProfileModel profile) async {
  //   if (await internetConnectionChecker.hasConnection) {
  //     final response = await apiController.put(
  //       Uri.parse(ApiSetting.updateProfile),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization':
  //             'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}'
  //       },
  //       body: profile.toJson(),
  //     );

  //     final Map<String, dynamic> responseBody = jsonDecode(response.body);
  //     if (response.statusCode >= 400) {
  //       HandleHttpError.handleHttpError(responseBody);
  //     }

  //     return ProfileModel.fromJson(responseBody['data']);
  //   } else {
  //     throw OfflineException(errorMessage: 'No Internet Connection');
  //   }
  // }
} 