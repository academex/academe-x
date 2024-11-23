import 'package:academe_x/features/auth/data/models/response/college_model.dart';
import 'package:academe_x/features/auth/domain/entities/response/college_cache_response_entity.dart';
import 'package:academe_x/lib.dart';

class CollegeCacheResponseModel extends CollegeCacheResponseEntity {


  CollegeCacheResponseModel({
    required super.data,
    required super.expiry,
    required super.type
});

  factory CollegeCacheResponseModel.fromJson(Map<String, dynamic> json) {
    return CollegeCacheResponseModel(
      data: (json['data'] as List).map((x) => CollegeModel.fromJson(x)).toList(),
      expiry: json['expiry'] as int,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data.map((x) => x.fromEntity().toJson()).toList(),
    'expiry': expiry,
    'type': type,
  };
}