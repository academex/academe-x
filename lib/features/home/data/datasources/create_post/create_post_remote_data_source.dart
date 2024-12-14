import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:academe_x/features/college_major/data/models/major_model.dart';
import 'package:academe_x/features/home/domain/entities/post/image_entity.dart';
import 'package:http_parser/http_parser.dart'; // Import this for MediaType

import 'package:academe_x/academeX_main.dart';
import 'package:academe_x/core/constants/cache_keys.dart';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/utils/network/base_response.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:academe_x/features/home/data/models/post/tag_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../core/utils/handle_http_error.dart';
import '../../../../../core/utils/network/api_controller.dart';
import '../../../../../core/utils/network/api_setting.dart';
import '../../../../../core/utils/storage/cache/hive_cache_manager.dart';
import '../../../presentation/controllers/states/create_post/create_post_icons_state.dart';

typedef PostBaseResponse = BaseResponse<PostModel>;
typedef TagBaseResponse = BaseResponse<List<MajorModel>>;

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
    final List<int> _bytes = [];

    if (post.tags!.isEmpty) {
      throw ValidationException(messages: ['يرجى اختيار tag']);
    }

    return await _postWithExceptions(
      func: () async {
        var url = Uri.parse(ApiSetting.createPost);
        var request = http.MultipartRequest('POST', url);
        request.fields['content'] = post.content!;
        for (int i = 0; i < post.tags!.length; i++) {
          request.fields['tagIds[$i]'] = post.tags![i].id.toString();
        }

        int totalRequestBytes = 0;

        // Add file if available and track upload progress
        if (post.file != null && post.file!.url != null) {
          var file = File(post.file!.url!);
          var totalBytes = await file.length();
          totalRequestBytes += totalBytes;

          var byteStream = file.openRead();
          var trackedStream = trackUploadProgress(byteStream, totalBytes, (progress) {
            print('File upload progress: ${progress.toStringAsFixed(2)}%');
          });

          var file1 = http.MultipartFile(
            'file',
            trackedStream,
            totalBytes,
            filename: file.uri.pathSegments.last,
            contentType: MediaType('application', 'pdf'),
          );

          request.files.add(file1);
        }

        // Add images with progress tracking
        for (ImageEntity image in post.images ?? []) {
          var file = File(image.url!);
          var totalBytes = await file.length();
          totalRequestBytes += totalBytes;

          var byteStream = file.openRead();
          var trackedStream = trackUploadProgress(byteStream, totalBytes, (progress) {
            print('Image upload progress: ${progress.toStringAsFixed(2)}%');
          });

          var imageFile = http.MultipartFile(
            'images',
            trackedStream,
            totalBytes,
            filename: image.url!.split('/').last,
            contentType: MediaType('image', 'jpeg'), // Adjust as needed
          );

          request.files.add(imageFile);
        }

        // Add headers
        request.headers.addAll({
          'Authorization':
          'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}',
          'Accept': 'application/json',
        });

        // Calculate total bytes of the request
        var totalBytes = await _calculateTotalBytes(request);

        // Send the request and track the upload progress.
        var sendResponse = await request.send();

        // Track download progress using a separate StreamController for the response.
        final responseBytes = <int>[];
        final responseStream = sendResponse.stream.transform<List<int>>(
          StreamTransformer.fromHandlers(
            handleData: (chunk, sink) {
              responseBytes.addAll(chunk);
              double downloadProgress = (responseBytes.length / totalBytes) * 100;
              print('Download progress: $downloadProgress%');
              sink.add(chunk);
            },
          ),
        );

        // Listen to the download progress stream and handle the response once the download is complete.
        responseStream.listen(
              (List<int> chunk) {},
          onDone: () {
            print('Download complete');
          },
        );

        // Get the response body as a string after the download is finished
        var responseBody = await sendResponse.stream.bytesToString();

        if (sendResponse.statusCode == 200) {
          var responseData = await http.Response.fromStream(sendResponse);
          print('Response: ${responseData.body}');
        } else {
          print('Error: ${sendResponse.statusCode}');
        }

        // Decode the response body
        final Map<String, dynamic> responseBodyDecoded = jsonDecode(responseBody);
        Logger().f(responseBodyDecoded.toString());

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        if (sendResponse.statusCode >= 400) {
          _handleHttpError(responseBodyDecoded);
        }

        // Parse the response to get the model
        final PostBaseResponse baseResponse = PostBaseResponse.fromJson(
          responseBodyDecoded,
              (json) => PostModel.fromJson(json),
        );

        return baseResponse.data!;
      },
    );
  }

// Helper function to track upload progress for a stream.
  Stream<List<int>> trackUploadProgress(
      Stream<List<int>> stream,
      int totalBytes,
      Function(double progress) onProgress,
      ) {
    int uploadedBytes = 0;

    return stream.transform<List<int>>(StreamTransformer.fromHandlers(
      handleData: (chunk, sink) {
        uploadedBytes += chunk.length;
        double progress = (uploadedBytes / totalBytes) * 100;
        onProgress(progress);
        sink.add(chunk);
      },
    ));
  }

// Helper function to calculate the total bytes of the request (upload + form data).
  Future<int> _calculateTotalBytes(http.MultipartRequest request) async {
    int totalBytes = 0;

    // Calculate total bytes for the request fields (form data)
    request.fields.forEach((key, value) {
      totalBytes += value.length;
    });

    // Calculate total bytes for files
    for (var file in request.files) {
      totalBytes += file.length;
    }

    return totalBytes;
  }



  Future<List<MajorModel>> getTags() async {
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
        HandleHttpError.handleHttpError(responseBody);
      }
      final TagBaseResponse baseResponse = TagBaseResponse.fromJson(
        responseBody,
        (json) => (json as List)
            .map(
              (e) => MajorModel.fromJson(e),
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
      List<MajorModel> tags = majorCached!
          .map(
            (e) => MajorModel.fromJson(e.toJson()),
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
  //
  // void _handleHttpError(Map<String, dynamic> json) {
  //   // Handle error response format with statusCode field
  //   if (json.containsKey('statusCode')) {
  //     final errorResponse = ErrorResponseModel.fromJson(json);
  //
  //     switch (errorResponse.statusCode) {
  //       case 400:
  //         final messages =
  //             errorResponse.messages ?? [errorResponse.message ?? ''];
  //         throw ValidationException(messages: messages);
  //       case 401:
  //         throw UnauthorizedException(
  //           message: errorResponse.message ?? 'Unauthorized',
  //         );
  //       case 500:
  //       case 502:
  //       case 503:
  //       case 504:
  //         throw ServerException(
  //           message: errorResponse.message ??
  //               'Server error (${errorResponse.statusCode})',
  //         );
  //       default:
  //         throw ServerException(
  //           message: errorResponse.message ?? 'Server error',
  //         );
  //     }
  //   } else {
  //     if (json['status'] == 'error') {
  //       AppLogger.e('Login Error: ${json['status']}');
  //       if (json['message'] is List) {
  //         final List<String> messages =
  //             (json['message'] as List).map((e) => e.toString()).toList();
  //         throw ValidationException(messages: messages);
  //       }
  //       throw ValidationException(
  //         messages: [json['message'].toString() ?? 'Unknown error'],
  //       );
  //     }
  //   }
  // }
}
class MultipartRequest extends http.MultipartRequest {
  MultipartRequest(
      String method,
      Uri url, {
         required this.onProgress,
      }) : super(method, url);

  final void Function(int bytes, int totalBytes) onProgress;

  /// Freezes all mutable fields and returns a single-subscription [ByteStream]
  /// that will emit the request body.
  http.ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;

    final total = this.contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress(bytes, total);
        if(total >= bytes) {
          sink.add(data);
        }
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}
