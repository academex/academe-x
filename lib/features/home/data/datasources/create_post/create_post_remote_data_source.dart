import 'dart:convert';

import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/network/base_response.dart';
import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:academe_x/features/home/data/models/post/tag_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


typedef  PostBaseResponse = BaseResponse<PostModel>;
typedef  TagBaseResponse = BaseResponse<List<TagModel>>;


class CreatePostRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;
  CreatePostRemoteDataSource(
      {required this.apiController, required this.internetConnectionChecker});

  Future<PostModel> createPost({required PostModel post}) async {
    if(post.tags == null) throw ValidationException(messages: ['يرجى اختيار tag']);
    return await _postWithExceptions(
      func: () async {
        final response = await apiController.post(
            Uri.parse(ApiSetting.createPost),
            body:{
              'content':post.content,
              'tagIds':post.tags!.map((e) => e.id,).toList(),
            },
            timeAlive: 100,
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImJhcmFhIiwiaWF0IjoxNzMyNzEwMzA0LCJleHAiOjE3MzI3MTM5MDR9.ysmrCh79qV9e8vcJR5_UWABN6vb0tqtVrHHL-vCYGm4',
            });
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          _handleHttpError(responseBody);
        }
        final PostBaseResponse baseResponse = PostBaseResponse.fromJson(
          responseBody,
              (json) => PostModel.fromJson(json),
        );
        return baseResponse.data!;
      },
    );
  }

  Future<List<TagModel>> getTags() async {
    final response = await apiController.get(
        Uri.parse(ApiSetting.createPost),
        headers: {
          'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImJhcmFhIiwiaWF0IjoxNzMyNzEwMzA0LCJleHAiOjE3MzI3MTM5MDR9.ysmrCh79qV9e8vcJR5_UWABN6vb0tqtVrHHL-vCYGm4',
        });
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (response.statusCode >= 400) {
      _handleHttpError(responseBody);
    }
    final TagBaseResponse baseResponse = TagBaseResponse.fromJson(
      responseBody,
          (json) => (json as List).map((e) => TagModel.fromJson(e),).toList(),
    );
    return baseResponse.data!;
  }

  Future<PostModel> _postWithExceptions({required Future<PostModel> Function() func}) async {
    if (await internetConnectionChecker.hasConnection) {
      return await func();
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  void _handleHttpError(Map<String,dynamic> json) {
    // Handle error response format with statusCode field
    if (json.containsKey('statusCode')) {
      final errorResponse = ErrorResponseModel.fromJson(json);

      switch (errorResponse.statusCode) {
        case 400:
          final messages = errorResponse.messages ??
              [errorResponse.message ?? ''];
          throw ValidationException(messages: messages);
        case 401:
          throw UnauthorizedException(
            message: errorResponse.message ?? 'Unauthorized',
          );
        case 500:
        case 502:
        case 503:
        case 504:
          throw ServerException(
            message: errorResponse.message ?? 'Server error (${errorResponse.statusCode})',
          );
        default:
          throw ServerException(
            message: errorResponse.message ?? 'Server error',
          );
      }
    }else{
      if (json['status'] =='error') {
        AppLogger.e('Login Error: ${json['status']}');
        if (json['message'] is List) {
          final List<String> messages = (json['message'] as List)
              .map((e) => e.toString())
              .toList();
          throw ValidationException(messages: messages);
        }
        throw ValidationException(
          messages: [json['message'].toString() ?? 'Unknown error'],
        );
      }
    }
  }
}
