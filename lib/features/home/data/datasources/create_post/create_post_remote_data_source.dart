import 'dart:convert';
import 'dart:io';

import 'package:academe_x/academeX_main.dart';
import 'package:academe_x/core/constants/cache_keys.dart';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/network/base_response.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/auth/auth.dart';
import 'package:academe_x/features/features.dart';
import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:academe_x/features/home/data/models/post/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

typedef PostBaseResponse = BaseResponse<PostModel>;
typedef TagBaseResponse = BaseResponse<List<TagModel>>;

class CreatePostRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;
  CreatePostRemoteDataSource(
      {required this.apiController, required this.internetConnectionChecker});

  Future<void> _uploadImage(
      {required File file,
      required List<File> images,
      required PostModel post}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiSetting.createPost));

    request.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
    ));
    for (File image in images) {
      request.files.add(await http.MultipartFile.fromPath(
        'images',
        image.path,
      ));
    }

    request.fields['content'] = post.content!;
    request.fields['tagIds'] = jsonEncode(post.tags!
        .map(
          (e) => e.id,
        )
        .toList());

    // Send the request
    var response = await request.send();

    // Check the response status
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Image upload failed with status: ${response.statusCode}');
    }
  }

  Future<PostModel> createPost({
    required PostModel post,
    BuildContext? context,
  }) async {
    // _uploadImage(file: file, images: images, post: post);
    if (post.tags == null) {
      throw ValidationException(messages: ['يرجى اختيار tag']);
    }
    return await _postWithExceptions(
      func: () async {
        File? file = getIt<FilePickerLoaded>().file;
        late String base64File;
        if (file != null) {
          Logger().d(file!.exists().toString());

          List<int> fileBytes = await file.readAsBytes();
          base64File = base64Encode(fileBytes);
        }
        // Encode the file to base64 (if required by the server)
        Logger().d(ApiSetting.createPost);
        var url = Uri.parse('https://academex-1.onrender.com/post/');
        var request = http.MultipartRequest('POST', url);

        // Add fields
        request.fields['content'] = post.content!;
        request.fields['tagIds[0]'] ='1'; // Add more tagIds as needed
        var file1;
        // Add file
        if(file != null) {
           file1 = await http.MultipartFile.fromPath(
            'file',
            file.path,
            // contentType:
            //     MediaType('application', 'pdf'), // Change based on your file type
          );
        }
        if(file != null) {
          request.files.add(file1);
        }
        // Add headers
        request.headers.addAll({
          'Authorization':
              'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}',
        });

        // Send request
        var response = await request.send();

        if (response.statusCode == 200) {
          var responseData = await http.Response.fromStream(response);
          print('Response: ${responseData.body}');
        } else {
          print('Error: ${response.statusCode}');
        }
        // final response = await apiController.post(
        //     Uri.parse('https://academex-1.onrender.com/post/'),
        //     body: {
        //       'file': base64File,
        //       'content': post.content,
        //       'tagIds': post.tags!
        //           .map(
        //             (e) => e.id,
        //           )
        //           .toList(),
        //     },
        //     timeAlive: 100,
        //     headers: {
        //       // 'Content-Type': 'application/json',
        //       'Authorization':
        //           'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}',
        //     });
        getIt<ImagePickerLoaded>().images = null;
        getIt<FilePickerLoaded>().file = null;
        final Map<String, dynamic> responseBody = jsonDecode(await response.stream.bytesToString());
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
        _handleHttpError(responseBody);
      }
      final TagBaseResponse baseResponse = TagBaseResponse.fromJson(
        responseBody,
        (json) => (json as List)
            .map(
              (e) => TagModel.fromJson(e),
            )
            .toList(),
      );
      try {
        // AppLogger.success('in cacheAuthUser ${user.toString()}');
        await getIt<HiveCacheManager>()
            .cacheResponse(CacheKeys.MAJORS, baseResponse.data);

        AppLogger.success('Major cached successfully');
      } catch (e) {
        AppLogger.e('Failed to cache Major: $e');
        rethrow;
      }
      return baseResponse.data!;
    } else {
      List<TagModel> tags = majorCached!
          .map(
            (e) => TagModel.fromJson(e.toJson()),
          )
          .toList();
      return tags;
    }
  }

  Future<PostModel> _postWithExceptions(
      {required Future<PostModel> Function() func}) async {
    if (await internetConnectionChecker.hasConnection) {
      return await func();
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  void _handleHttpError(Map<String, dynamic> json) {
    // Handle error response format with statusCode field
    if (json.containsKey('statusCode')) {
      final errorResponse = ErrorResponseModel.fromJson(json);

      switch (errorResponse.statusCode) {
        case 400:
          final messages =
              errorResponse.messages ?? [errorResponse.message ?? ''];
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
            message: errorResponse.message ??
                'Server error (${errorResponse.statusCode})',
          );
        default:
          throw ServerException(
            message: errorResponse.message ?? 'Server error',
          );
      }
    } else {
      if (json['status'] == 'error') {
        AppLogger.e('Login Error: ${json['status']}');
        if (json['message'] is List) {
          final List<String> messages =
              (json['message'] as List).map((e) => e.toString()).toList();
          throw ValidationException(messages: messages);
        }
        throw ValidationException(
          messages: [json['message'].toString() ?? 'Unknown error'],
        );
      }
    }
  }
}
