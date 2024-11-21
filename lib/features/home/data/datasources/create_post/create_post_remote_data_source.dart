import 'dart:convert';

import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/home.dart';
import 'package:academe_x/features/home/presentation/model/post_req_model.dart';
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
            body: post.toJson(),
            timeAlive: 100,
            headers: {
              "Content-Type": "application/json",
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImJhcmFhIiwiaWF0IjoxNzMyMDE1NDQyLCJleHAiOjE3MzIwMTkwNDJ9.Xbrmftv0sdmI2J-AFwASbQOnuofKly7t5tVGJ9zXYTM',
            });
        return PostReqModel.fromJson({});
      },
    );
  }

  Future<PostReqModel> postWithExceptions(
      {required Future<PostReqModel> Function() func}) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        return await func();
      }on TimeOutExeption catch (e) {
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
