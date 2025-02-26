import 'package:academe_x/features/auth/auth.dart';

class UserResponseEntity {
  int id;
  String username;
  String firstName;
  String lastName;
  String? email;
  String? role;
  String? photoUrl;
  String? bio;
  int? currentYear;
  String? gender;
  String? phoneNum;
  int? tagId;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserResponseEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
     this.email,
    this.role,
    this.photoUrl,
    this.bio,
    this.currentYear,
    this.gender,
    this.phoneNum,
    this.tagId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });
  UserResponseModel fromEntity() {
    return UserResponseModel(
      id: id,
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      role: role,
      photoUrl: photoUrl,
      bio: bio,
      currentYear: currentYear,
      tagId: tagId,
      isActive: isActive,
      gender: gender,
      createdAt: createdAt,
      updatedAt: updatedAt,
      phoneNum: phoneNum,
    );
  }

  UserResponseEntity copyWith({
    int? id,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? role,
    String? photoUrl,
    String? bio,
    int? currentYear,
    String? gender,
    String? phoneNum,
    int? tagId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserResponseEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role ?? this.role,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      currentYear: currentYear ?? this.currentYear,
      tagId: tagId ?? this.tagId,
      phoneNum: phoneNum ?? this.phoneNum,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      gender: gender ?? this.gender,
      isActive: isActive ?? this.isActive
    );
  }


}


