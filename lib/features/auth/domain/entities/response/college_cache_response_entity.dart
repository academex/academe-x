import 'package:academe_x/features/auth/data/models/response/college_response_model.dart';
import 'package:academe_x/lib.dart';

class CollegeCacheResponseEntity {
  final List<CollegeEntity> data;
  final int expiry;
  final String type;

  CollegeCacheResponseEntity({
    required this.data,
    required this.expiry,
    required this.type,
  });

  // factory CollegeResponseModel.fromJson(Map<String, dynamic> json) {
  //   return CollegeResponse(
  //     data: (json['data'] as List).map((x) => CollegeEntity.fromJson(x)).toList(),
  //     expiry: json['expiry'] as int,
  //     type: json['type'] as String,
  //   );
  // }
  //
  // Map<String, dynamic> toJson() => {
  //   'data': data.map((x) => x.fromEntity().toJson()).toList(),
  //   'expiry': expiry,
  //   'type': type,
  // };
}