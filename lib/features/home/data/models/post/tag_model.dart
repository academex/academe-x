import 'package:academe_x/features/home/domain/entities/post/tag_entity.dart';

class   TagModel extends TagEntity {
  const TagModel({
    super.collegeAr,
    super.majorAr,
    super.collegeEn,
    super.majorEn,
    super.description,
    super.yearsNum,
    super.isActive,
    super.createdAt,
    super.updatedAt,
    required super.id,
    required super.name,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'] as int,
      name: json['name'] as String,
      collegeAr: json['collegeAr'] as String?,
      majorAr: json['majorAr'] as String?,
      collegeEn: json['collegeEn'] as String?,
      majorEn: json['majorEn'] as String?,
      description: json['description'] as String?,
      yearsNum: json['yearsNum'] as int?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['createdAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'collegeAr': collegeAr,
      'majorAr': majorAr,
      'collegeEn': collegeEn,
      'majorEn': majorEn,
      'description': description,
      'yearsNum': yearsNum,
      'isActive': isActive,
      'createdAt': createdAt!.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
    };
  }
}
