import 'package:academe_x/features/auth/domain/entities/response/updated_user_entity.dart';
import 'package:academe_x/lib.dart';

class UpdatedUserModel extends UpdatedUserEntity{

  UpdatedUserModel({
    required super.id,
    required super.bio,
    required super.currentYear,
    required super.createdAt,
    required super.email,
    required super.isActive,
    required super.firstName,
    required super.gender,
    required super.lastName,
    required super.password,
    required super.phoneNum,
    required super.photoUrl,
    required super.resetPasswordToken,
    required super.resetPasswordTokenExpires,
    required super.role,
    required super.tagId,
    required super.updatedAt,
    required super.username,
  });
  UpdatedUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    role = json['role'];
    password = json['password'];
    resetPasswordToken = json['resetPasswordToken'];
    resetPasswordTokenExpires = json['resetPasswordTokenExpires'];
    photoUrl = json['photoUrl'];
    bio = json['bio'];
    currentYear = json['currentYear'];
    gender = json['gender'];
    phoneNum = json['phoneNum'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isActive = json['isActive'];
    tagId = json['tagId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['role'] = this.role;
    data['password'] = this.password;
    data['resetPasswordToken'] = this.resetPasswordToken;
    data['resetPasswordTokenExpires'] = this.resetPasswordTokenExpires;
    data['photoUrl'] = this.photoUrl;
    data['bio'] = this.bio;
    data['currentYear'] = this.currentYear;
    data['gender'] = this.gender;
    data['phoneNum'] = this.phoneNum;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isActive'] = this.isActive;
    data['tagId'] = this.tagId;
    return data;
  }
}