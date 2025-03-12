import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/utils/network/api_controller.dart';
import 'package:academe_x/core/utils/network/api_setting.dart';
import 'package:academe_x/features/auth/auth.dart';
import 'package:academe_x/features/auth/data/models/response/updated_user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/academeX_main.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/utils/handle_http_error.dart';
import '../../../../core/utils/network/base_response.dart';
import '../../../auth/domain/entities/response/updated_user_entity.dart';
import '../../../home/data/models/post/post_model.dart';
import '../../domain/entities/file_entity.dart';
import '../library_model.dart';
class LibraryRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  LibraryRemoteDataSource({
    required this.apiController,
    required this.internetConnectionChecker,
  });

  Future<List<LibraryModel>> loadLibrary(
      PaginationParams paginationParams) async {
    String url =
        '${ApiSetting.getLibrary}?tagId=${paginationParams.tagId}&yearNum=${paginationParams.yearNum}'; // ${paginationParams.yearNum}';
    // if(paginationParams.userName != null){
    //   url = ApiSetting.getUserPosts+paginationParams.userName!;
    // }

    AppLogger.success(url);
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
            'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}'
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final baseResponse =
        BaseResponse<List<LibraryModel>>.fromJson(
          responseBody,
              (json) {
            return List<LibraryModel>.from(
              json.map(
                    (p0) => LibraryModel.fromJson(p0),
              ),
            );
          },
        );
        return baseResponse.data!;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<void> starFile(
      int fileId) async {
    String url =
        '${ApiSetting.getLibrary}/$fileId/star';

    AppLogger.success(url);
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
            'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}'
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }


  Future<LibraryModel?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      return LibraryModel.fromFile(file);
    }

    return null;
  }



  // Future<String> uploadFile(LibraryModel fileModel, void Function(double) progressCallback) async {
  //
  //   final uri = Uri.parse(ApiSetting.getLibrary);
  //
  //
  //   final request = http.MultipartRequest('POST', uri);
  //
  //   // Add authorization headers
  //   request.headers.addAll({
  //     'Content-Type': 'application/json',
  //     'Authorization':
  //     'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}'
  //   });
  //
  //   final file = File(fileModel.url!);
  //   final fileBytes = await file.readAsBytes(); // Read entire file
  //   final fileLength = fileBytes.length;
  //   request.fields['name'] = fileModel.name!;
  //   request.fields['subject'] = 'fileModel.subject!';
  //   request.fields['tagIds[0]'] ='1';
  //   request.fields['yearNum'] ='4';
  //   request.fields['description'] ='TEST FROM PHONE';
  //   request.fields['type'] ='SUMMARY';
  //
  //   AppLogger.success('test ${fileModel.name!}');
  //
  //
  //   final multipartFile = http.MultipartFile.fromBytes(
  //     'file',
  //     fileBytes,
  //     filename: fileModel.name,
  //   );
  //
  //
  //
  //   request.files.add(multipartFile);
  //
  //
  //
  //   // Track upload progress
  //   final streamedResponse = await request.send();
  //
  //   int received = 0;
  //   final completer = Completer<String>();
  //
  //   streamedResponse.stream.listen(
  //         (List<int> bytes) {
  //           received += bytes.length;
  //           final progress = received / fileLength;
  //           progressCallback(progress);
  //         },
  //     onDone: () async {
  //       if (streamedResponse.statusCode == 200 || streamedResponse.statusCode == 201) {
  //         final response = await http.Response.fromStream(streamedResponse);
  //         final responseData = json.decode(response.body);
  //         completer.complete(responseData['data']['url']);
  //         AppLogger.success('test ${responseData['data']['url']}');
  //       } else {
  //         completer.completeError(
  //             Exception('Failed to upload file with status: ${streamedResponse.statusCode}')
  //         );
  //       }
  //     },
  //     onError: (error) {
  //       completer.completeError(error);
  //     },
  //   );
  //
  //   return completer.future;
  // }


  Future<String> uploadFile(FileEntity fileInfo,LibraryModel fileModel, void Function(double) progressCallback) async {
    final uri = Uri.parse(ApiSetting.getLibrary);
    final request = http.MultipartRequest('POST', uri);

    // Add authorization headers
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}'
    });

    // Add form fields
    request.fields['name'] = fileInfo.name!;
    request.fields['subject'] = fileInfo.subject!;
    request.fields['tagIds[0]'] = fileInfo.tagId!.toString();
    request.fields['yearNum'] = fileInfo.yearNum!.toString();
    request.fields['description'] = fileInfo.description!;
    request.fields['type'] =fileInfo.type!;

    AppLogger.success('Starting upload for ${request.fields}');

    // Create a custom progress tracking http client
    final client = _MyHttpClient(onProgress: progressCallback);

    // Add the file
    final file = File(fileModel.url!);
    final fileStream = file.openRead();
    final fileLength = await file.length();

    request.files.add(
      http.MultipartFile(
        'file',
        fileStream,
        fileLength,
        filename: fileModel.name,
      ),
    );

    // Use the custom client to send the request
    final streamedResponse = await client.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);
      AppLogger.success('Upload successful: ${responseData['data']['url']}');
      return responseData['data']['url'];
    } else {
      throw Exception('Failed to upload file with status: ${response.statusCode}');
    }
  }
}

class _MyHttpClient extends http.BaseClient {
  final http.Client _client = http.Client();
  final void Function(double) onProgress;

  _MyHttpClient({required this.onProgress});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final totalBytes = request.contentLength;
    int sentBytes = 0;

    if (totalBytes == null) {
      // Cannot track progress without knowing the total size
      return _client.send(request);
    }

    // Create a stream that reports progress as data is written
    Stream<List<int>> streamUpload = request.finalize().transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sentBytes += data.length;
          onProgress(sentBytes / totalBytes); // Report progress
          sink.add(data); // Forward the data
        },
      ),
    );

    // Create a new request to send
    final streamedRequest = http.StreamedRequest(request.method, request.url);

    // Copy all the fields from the original request
    request.headers.forEach((key, value) {
      streamedRequest.headers[key] = value;
    });

    // Add the body with progress tracking
    streamedRequest.contentLength = totalBytes;
    streamUpload.listen(
      streamedRequest.sink.add,
      onDone: streamedRequest.sink.close,
      onError: streamedRequest.sink.addError,
    );

    return _client.send(streamedRequest);
  }

  @override
  void close() {
    _client.close();
  }
}