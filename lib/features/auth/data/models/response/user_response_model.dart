
import 'package:academe_x/lib.dart';

class UserResponseModel extends UserResponseEntity {


  UserResponseModel({
    required super.id ,
  required super.username,
  required super.firstName,
  required super.lastName,
  required super.email,
  required super.role,
  required super.photoUrl,
  required super.bio,
  required super.isActive,
  required super.currentYear,
  required super.gender,
  required super.phoneNum,
  required super.tagId,
    required super.createdAt,
  required super.updatedAt,
  });


  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      id: json['id'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'],
      photoUrl: json['photoUrl'],
      bio: json['bio'],
      isActive: json['isActive'],
      currentYear: json['currentYear'],
      gender: json['gender'],
      phoneNum: json['phoneNum'],
      tagId: json['tagId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'photoUrl': photoUrl,
      'bio': bio,
      'currentYear': currentYear,
      'gender': gender,
      'phoneNum': phoneNum,
      'tagId': tagId,
      'isActive': isActive,
      'createdAt':  createdAt!.toIso8601String() ,
      'updatedAt': updatedAt!.toIso8601String(),
    };
  }
}


