import 'package:academe_x/features/auth/data/models/response/college_model.dart';

class CollegeEntity {
  String? collegeAr;
  String? collegeEn;

  CollegeEntity({this.collegeAr, this.collegeEn});
  CollegeModel fromEntity() {
    return CollegeModel(collegeAr: collegeAr,collegeEn: collegeEn);
  }

}