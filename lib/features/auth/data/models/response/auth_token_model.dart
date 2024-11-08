
import 'package:academe_x/lib.dart';

class AuthTokenModel extends AuthTokenEntity{
  //
  AuthTokenModel({required super.user,required  super.accessToken});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      user: UserResponseModel.fromJson(json['user']),
      accessToken: json['accessToken'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'user': UserModel().toJson(),
  //     'accessToken': accessToken,
  //   };
  // }
}