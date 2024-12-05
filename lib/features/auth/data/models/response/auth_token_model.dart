
import 'dart:convert';

import 'package:academe_x/lib.dart';

class AuthTokenModel extends AuthTokenEntity{
  //
  AuthTokenModel({required super.user,required  super.accessToken});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      user: UserResponseModel.fromJson(json['user']),
      accessToken:json['accessToken'],
    );
  }

  static AuthTokenEntity toEntity(AuthTokenModel authToken){
    return AuthTokenEntity(user: authToken.user, accessToken: authToken.accessToken);
  }

  Map<String, dynamic> toJson() {
    return {
      'user': (user as UserResponseModel).toJson(),
      'accessToken': accessToken,
    };
  }


}