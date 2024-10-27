import 'dart:async';

import 'package:academe_x/core/error/exception.dart';
import 'package:academe_x/features/auth/data/models/requset/login_requset_model.dart';
import 'package:academe_x/features/auth/data/models/response/auth_token_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/web.dart';

import '../../../../core/network/api_controller.dart';
import '../../../../core/network/api_setting.dart';

class AuthenticationRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;



  AuthenticationRemoteDataSource({required this.apiController,required this.internetConnectionChecker});

  Future<AuthTokenModel> login(LoginRequsetModel user) async {

    if(await internetConnectionChecker.hasConnection){
      Logger().d(Uri.parse(ApiSetting.login)); // Log the login API endpoint
      try {
        final response = await apiController.post(
          Uri.parse(ApiSetting.login),
          body: user.toJson(),
          timeAlive: 10, // Timeout set to 10 seconds
        );

        Logger().d(response); // Log the response

        return AuthTokenModel.fromJson(response); // Parse the response
      }on WrongDataException catch (e) {
        // Handle timeout
        throw WrongDataException(errorMessage: e.errorMessage);
      }on TimeOutExeption catch (e) {
        // Handle timeout
        Logger().e('Timeout: ${e.errorMessage}');
        throw TimeOutExeption(errorMessage: e.errorMessage);
      } on Exception catch (e) {
        // Handle general exceptions
        Logger().e('Error: $e');
        throw Exception('Assdn error occurred: $e');
      }
    }
    else{
      throw OfflineException(errorMessage: 'No Internet Connection');
    }

  }


}