import 'dart:async';
import 'dart:convert';
import 'package:academe_x/core/network/base_response.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:academe_x/lib.dart';

typedef AuthResponse = BaseResponse<AuthTokenModel>;
typedef CollegesResponse  = BaseResponse<List<CollegeModel>>;
typedef MajorsResponse  = BaseResponse<List<MajorModel>>;

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

        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
           _handleHttpError(responseBody);
        }
        final AuthResponse baseResponse = AuthResponse.fromJson(
          responseBody,
              (json) => AuthTokenModel.fromJson(json),
        );

        return baseResponse.data!;
      } on ValidationException {
        rethrow;
      } on UnauthorizedException {
        rethrow;
      } on TimeOutExeption {
        rethrow;
      } catch (e,stack) {
        AppLogger.e('An error occurred: $e  ${stack}');
        throw ServerException(message: 'An error occurred: $e  ${stack}');
      }
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


  Future<AuthTokenModel> signup(SignupRequestModel user) async {

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(ApiSetting.signup),
          headers: {
            'Content-Type': 'application/json',
          },
          body:user.toJson(),
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          _handleHttpError(responseBody);
        }


        final AuthResponse baseResponse = AuthResponse.fromJson(
          responseBody,
              (json) => AuthTokenModel.fromJson(json),
        );

        return baseResponse.data!;
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

  Future<List<CollegeModel>> getColleges() async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(ApiSetting.colleges),
          headers: {
            'Content-Type': 'application/json',
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if(response.statusCode>=400){
          _handleHttpError(responseBody);
        }

          final CollegesResponse baseResponse = CollegesResponse.fromJson(
            responseBody,
                (dynamic json) => (json as List)
                .map((item) => CollegeModel.fromJson(item as Map<String, dynamic>))
                .toList(),
          );
          return baseResponse.data!;


      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }


  Future<List<MajorModel>> getMajorsByCollege(String majorName) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse('${ApiSetting.majors}?collegeEn=$majorName') ,
          headers: {
            'Content-Type': 'application/json',
          },
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if(response.statusCode>=400){
          _handleHttpError(responseBody);
        }

        final MajorsResponse baseResponse = MajorsResponse.fromJson(
          responseBody,
              (dynamic json) => (json as List)
              .map((item) => MajorModel.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
        return baseResponse.data!;
        //
        // if (response.statusCode == 200) {
        //   final List<dynamic> jsonData = jsonDecode(response.body);
        //   return jsonData.map((major) => MajorModel.fromJson(major as Map<String, dynamic>)).toList();
        // }
        //
        // // Handle error responses
        // final errorResponse = ErrorResponseModel.fromJson(jsonDecode(response.body));
        //
        // switch (errorResponse.statusCode) {
        //   case 400:
        //     final messages = errorResponse.messages ?? [errorResponse.message ?? ''];
        //     throw ValidationException(messages: messages);
        //   case 401:
        //     throw UnauthorizedException(message: errorResponse.message ?? 'Unauthorized access');
        //   case 404:
        //     throw NotFoundException(message: errorResponse.message ?? 'Resource not found');
        //   case 429:
        //     throw TooManyRequestsException(message: errorResponse.message ?? 'Too many requests');
        //   case 500:
        //   case 502:
        //   case 503:
        //   case 504:
        //     throw ServerException(
        //       message: errorResponse.message ?? 'Server error (${response.statusCode})',
        //     );
        //   default:
        //     throw ServerException(
        //       message: errorResponse.message ?? 'Unexpected error (${response.statusCode})',
        //     );
        // }
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

}

