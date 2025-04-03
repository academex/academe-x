
import 'package:academe_x/lib.dart';

class UserResponseModel extends UserResponseEntity {


  UserResponseModel({
    required super.id ,
  required super.username,
  required super.firstName,
  required super.lastName,
   super.email,
  super.role,
  super.photoUrl,
  super.bio,
    super.isActive,
   super.currentYear,
   super.gender,
   super.phoneNum,
   super.tagId,
     super.createdAt,
   super.updatedAt,
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
      createdAt: json['createdAt'] != null?DateTime.parse(json['createdAt']):null,
      updatedAt: json['updatedAt'] != null? DateTime.parse(json['updatedAt']):null,
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


