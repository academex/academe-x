import 'package:academe_x/features/college_major/data/models/major_model.dart';
import 'package:equatable/equatable.dart';

class MajorEntity extends Equatable{
  int? id;
  String? name;
  String? collegeAr;
  String? majorAr;
  String? collegeEn;
  String? majorEn;
  String? description;
  String? photoUrl;
  int? yearsNum;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  MajorEntity({this.id,
    this.name,
    this.collegeAr,
    this.majorAr,
    this.collegeEn,
    this.majorEn,
    this.description,
    this.photoUrl,
    this.yearsNum,
    this.isActive,
    this.createdAt,
    this.updatedAt});
  
  
  MajorModel entityToModel(MajorEntity entity){
    return MajorModel(id: id, collegeAr: collegeAr, collegeEn: collegeEn,photoUrl: photoUrl, createdAt: createdAt, description: description, isActive: isActive, majorAr: majorAr, majorEn: majorEn, name: name, updatedAt: updatedAt, yearsNum: yearsNum);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,photoUrl];

}