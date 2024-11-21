import 'dart:async';
import 'dart:convert';

import 'package:academe_x/core/constants/cache_keys.dart';
import 'package:academe_x/features/auth/data/models/response/college_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/web.dart';

import 'package:academe_x/lib.dart';


class AuthenticationRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;
  final HiveCacheManager cacheManager;



  AuthenticationRemoteDataSource({required this.apiController,required this.internetConnectionChecker,required this.cacheManager});



  Future<AuthTokenModel> login(LoginRequsetModel user) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(ApiSetting.login),
          body: user.toJson(),
          timeAlive: 10,
        );

        if (response.statusCode >= 400) {
          final errorResponse = ErrorResponseModel.fromJson(
            jsonDecode(response.body),
          );

          switch (errorResponse.statusCode) {
            case 400:
              final messages = errorResponse.messages ?? [errorResponse.message ?? ''];
              throw ValidationException(messages: messages);
            case 401:

              throw UnauthorizedException(
                message: errorResponse.message ?? 'Unauthorized',
              );
            default:
              throw ServerException(
                message: errorResponse.message ?? 'Server error',
              );
          }
        }

        return AuthTokenModel.fromJson(jsonDecode(response.body));
      } on ValidationException {
        rethrow;
      } on UnauthorizedException {
        rethrow;
      } on TimeOutExeption {
        rethrow;
      } catch (e) {
        throw ServerException(message: 'An error occurred: $e');
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }


  Future<AuthTokenModel> signup(SignupRequestModel user) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        AppLogger.success(ApiSetting.signup);
        final response = await apiController.post(
          Uri.parse(ApiSetting.signup),
          headers: {
            'Content-Type': 'application/json',
          },
          body:user.toJson(),
          timeAlive: 20,
        );



        if (response.statusCode >= 400) {
          final errorResponse = ErrorResponseModel.fromJson(
            jsonDecode(response.body),
          );

          switch (errorResponse.statusCode) {
            case 400:
              final messages = errorResponse.messages ?? [errorResponse.message ?? ''];
              throw ValidationException(messages: messages);
            default:
              throw ServerException(
                message: errorResponse.message ?? 'Server error',
              );
          }
        }

        return AuthTokenModel.fromJson(jsonDecode(response.body));
      } on ValidationException {
        rethrow;
      } on UnauthorizedException {
        rethrow;
      } on TimeOutExeption {
        rethrow;
      } catch (e) {
        throw ServerException(message: 'An error occurred: $e');
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<List<CollegeModel>> getColleges() async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(ApiSetting.colleges),
          headers: {
            'Content-Type': 'application/json',
          },
        );


        if (response.statusCode == 200) {
          final List<dynamic> jsonData = jsonDecode(response.body);
          return jsonData.map((college) => CollegeModel.fromJson(college as Map<String, dynamic>)).toList();
        }

        // Handle error responses
        final errorResponse = ErrorResponseModel.fromJson(jsonDecode(response.body));

        switch (errorResponse.statusCode) {
          case 400:
            final messages = errorResponse.messages ?? [errorResponse.message ?? ''];
            throw UnauthorizedException(message: messages[0]);
          case 401:
            throw UnauthorizedException(message: errorResponse.message ?? 'Unauthorized access');
              case 404:
            throw NotFoundException(message: errorResponse.message ?? 'Resource not found');
          case 429:
            throw TooManyRequestsException(message: errorResponse.message ?? 'Too many requests');
          case 500:
          case 502:
          case 503:
          case 504:
            throw ServerException(
              message: errorResponse.message ?? 'Server error (${response.statusCode})',
            );
          default:
            throw ServerException(
              message: errorResponse.message ?? 'Unexpected error (${response.statusCode})',
            );
        }
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

}

  // Future<AuthTokenModel> signup(SignupRequestModel userRegistration) async {
  //
  //   if(await internetConnectionChecker.hasConnection){
  //     try {
  //       final response = await apiController.post(
  //         Uri.parse(ApiSetting.signup),
  //         body: userRegistration.toJson(),
  //         timeAlive: 10,
  //       );
  //
  //       AppLogger.e(response.toString());
  //
  //
  //       return AuthTokenModel.fromJson(jsonDecode(response.body)); // Parse the response
  //     }on WrongDataException catch (e) {
  //       // Handle timeout
  //       throw WrongDataException(errorMessage: e.errorMessage);
  //     }on TimeOutExeption catch (e) {
  //       // Handle timeout
  //       Logger().e('Timeout: ${e.errorMessage}');
  //       throw TimeOutExeption(errorMessage: e.errorMessage);
  //     } on Exception catch (e) {
  //       // Handle general exceptions
  //       Logger().e('Error: $e');
  //       throw Exception('Assdn error occurred: $e');
  //     }
  //   }
  //   else{
  //     throw OfflineException(errorMessage: 'No Internet Connection');
  //   }
  //
  // }


