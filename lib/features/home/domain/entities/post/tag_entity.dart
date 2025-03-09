import 'package:equatable/equatable.dart';

class TagEntity extends Equatable {
  final int id;
  final String name;
  final String? collegeAr;
  final String? majorAr;
  final String? collegeEn;
  final String? majorEn;
  final String? description;
  final int? yearsNum;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TagEntity(
      { this.collegeAr, this.majorAr, this.collegeEn, this.majorEn, this.description, this.yearsNum, this.isActive, this.createdAt, this.updatedAt,
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}