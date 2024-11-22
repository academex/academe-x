import 'dart:convert';

import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/home.dart';
import 'package:academe_x/features/home/presentation/model/post_req_model.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

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
          timeAlive: 20,
          body: jsonEncode(post.toJson()),
          headers: {
            // "Content-Type": "application/json",
          },
        );

        Map<String, dynamic> jsonResponse = await jsonDecode(response.body);
        AppLogger.i(jsonResponse.toString());
        AppLogger.i(response.statusCode.toString());
        if (response.statusCode >= 400) {
          final errorResponse = ErrorResponseModel.fromJson(jsonResponse);

          switch (errorResponse.statusCode) {
            case 400:
              AppLogger.e(errorResponse.message.toString());
              final messages =
                  errorResponse.messages ?? [errorResponse.message ?? ''];
              AppLogger.e(messages.first);
              throw ValidationException(messages: messages);
            case 403:
              throw AuthException(errorMessage: 'يرجى تسجيل الدخول');
            default:
              throw ServerException(
                message: errorResponse.message ?? 'Server error',
              );
          }
        }
        Logger().d(jsonResponse.toString());
        return PostReqModel.fromJson(jsonResponse);
      },
    );
  }

  Future<PostReqModel> postWithExceptions(
      {required Future<PostReqModel> Function() func}) async {
    if (await internetConnectionChecker.hasConnection) {
      return await func();
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }
}
