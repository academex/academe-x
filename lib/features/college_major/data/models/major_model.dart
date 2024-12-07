
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';

class MajorModel extends MajorEntity{

  MajorModel({
    required super.id,
    required super.collegeAr,
    required super.collegeEn,
    required super.createdAt,
    required super.description,
    required super.isActive,
    required super.majorAr,
    required super.majorEn,
    required super.name,
    required super.updatedAt,
    required super.yearsNum,
});
  MajorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    collegeAr = json['collegeAr'];
    majorAr = json['majorAr'];
    collegeEn = json['collegeEn'];
    majorEn = json['majorEn'];
    description = json['description'];
    yearsNum = json['yearsNum'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['collegeAr'] = this.collegeAr;
    data['majorAr'] = this.majorAr;
    data['collegeEn'] = this.collegeEn;
    data['majorEn'] = this.majorEn;
    data['description'] = this.description;
    data['yearsNum'] = this.yearsNum;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}