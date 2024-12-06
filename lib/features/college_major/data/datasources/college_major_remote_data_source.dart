import 'dart:async';
import 'dart:convert';
import 'package:academe_x/core/network/api_controller.dart';
import 'package:academe_x/core/network/base_response.dart';
import 'package:academe_x/features/college_major/data/models/college_model.dart';
import 'package:academe_x/features/college_major/data/models/major_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/api_setting.dart';
import '../../../../core/utils/handle_http_error.dart';
typedef CollegesResponse  = BaseResponse<List<CollegeModel>>;
typedef MajorsResponse  = BaseResponse<List<MajorModel>>;



class CollegeMajorRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;


  CollegeMajorRemoteDataSource({required this.apiController,required this.internetConnectionChecker});


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
          HandleHttpError.handleHttpError(responseBody);
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
          HandleHttpError.handleHttpError(responseBody);
        }

        final MajorsResponse baseResponse = MajorsResponse.fromJson(
          responseBody,
              (dynamic json) => (json as List)
              .map((item) => MajorModel.fromJson(item as Map<String, dynamic>))
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

}

