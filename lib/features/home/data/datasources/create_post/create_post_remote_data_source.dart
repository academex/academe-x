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
            body:post.toJson(),
            timeAlive: 100,
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Imh1c3NlbiIsImlhdCI6MTczMjcwMDI5MywiZXhwIjoxNzMyNzAzODkzfQ.EZCN395SRecNq_lvCmIuVhCywXw7Dao0SZaCQuUb88k',
            });
        return PostReqModel.fromJson({});
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
