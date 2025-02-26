import 'package:academe_x/features/auth/auth.dart';
import 'package:academe_x/features/auth/domain/entities/response/user_response_entity.dart';

class UpdatedUserEntity {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  String? password;
  String? resetPasswordToken;
  String? resetPasswordTokenExpires;
  String? photoUrl;
  String? bio;
  int? currentYear;
  String? gender;
  String? phoneNum;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  int? tagId;

  UpdatedUserEntity({this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.password,
    this.resetPasswordToken,
    this.resetPasswordTokenExpires,
    this.photoUrl,
    this.bio,
    this.currentYear,
    this.gender,
    this.phoneNum,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.tagId});


  AuthTokenEntity toUserEntity() {
    return AuthTokenEntity(user: UserResponseEntity(
      id: id ?? 0,
      username: username ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      photoUrl: photoUrl ?? '',
      bio: bio ?? '',
      currentYear: currentYear ?? 0,
      tagId: tagId ?? 0,
    ), accessToken: ''
    );
  }
}