import 'dart:convert';

import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/home.dart';
import 'package:academe_x/features/home/presentation/model/post_req_model.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CreatePostRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  CreatePostRemoteDataSource(
      {required this.apiController, required this.internetConnectionChecker});

  Future<PostReqModel> createPost({required PostReqModel post}) async {
    return await postWithExceptions(
      func: () async {
        final response = await apiController.post(
            Uri.parse(ApiSetting.createPost),
            timeAlive: 120,
            body: jsonEncode(post.toJson()),
            headers: {
              "Content-Type": "application/json",
              'Authorization':
                    'Bearer ${getIt<StorageService>().getUser()?.accessToken}',
            });
        Map<String, dynamic> jsonResponse = await jsonDecode(response.body);
        if (response.statusCode >= 400) {
          final errorResponse = ErrorResponseModel.fromJson(
              jsonResponse
          );
          

          switch (errorResponse.statusCode) {
            case 400:
              final messages = errorResponse.messages ?? [errorResponse.message ?? ''];
              throw ValidationException(messages: messages);
            case 403:
              throw AuthException(errorMessage: 'يرجى تسجيل الدخول');
            default:
              throw ServerException(
                message: errorResponse.message ?? 'Server error',
              );
          }
        }
        AppLogger.d(jsonResponse.toString());
        return PostReqModel.fromJson(jsonResponse);
      },
    );


  }

  Future<PostReqModel> postWithExceptions(
      {required Future<PostReqModel> Function() func}) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        return await func();
      } on TimeOutExeption catch (e) {
        // Handle timeout
        AppLogger.e('Timeout: ${e.errorMessage}');
        throw TimeOutExeption(errorMessage: e.errorMessage);
      } on Exception catch (e) {
        // Handle general exceptions
        AppLogger.e('Error From Remote Data Source: $e');
        throw Exception('Assdn error occurred: $e');
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }
}
