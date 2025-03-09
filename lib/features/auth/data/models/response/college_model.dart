import 'package:academe_x/lib.dart';

class CollegeModel extends CollegeEntity{

  CollegeModel({
    required super.collegeAr,
    required super.collegeEn,
});

  factory CollegeModel.fromJson(Map<String, dynamic> json) {
    return CollegeModel(
      collegeAr: json['collegeAr'],
      collegeEn: json['collegeEn'],
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collegeAr'] = collegeAr;
    data['collegeEn'] = collegeEn;
    return data;
  }
}