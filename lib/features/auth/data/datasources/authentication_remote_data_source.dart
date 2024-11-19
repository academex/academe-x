import 'dart:async';
import 'dart:convert';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/web.dart';

import 'package:academe_x/lib.dart';


class AuthenticationRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;



  AuthenticationRemoteDataSource({required this.apiController,required this.internetConnectionChecker});



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


