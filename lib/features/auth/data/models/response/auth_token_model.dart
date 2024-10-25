
import 'package:academe_x/features/auth/data/models/response/user_response_model.dart';
import 'package:academe_x/features/auth/domain/entities/response/auth_token_entity.dart';

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