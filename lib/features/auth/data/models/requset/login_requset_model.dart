import 'package:academe_x/lib.dart';

class LoginRequsetModel extends LoginRequsetEntity{
  LoginRequsetModel({super.username, super.password});

  LoginRequsetModel.fromJson(Map<String, dynamic> json) {
  username = json['username'];
  password = json['password'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['username'] = username;
  data['password'] = password;
  return data;
}

  factory LoginRequsetModel.fromEntity(LoginRequsetEntity entity) {
    return LoginRequsetModel(
      username: entity.username,
      password: entity.password,
    );
  }
}