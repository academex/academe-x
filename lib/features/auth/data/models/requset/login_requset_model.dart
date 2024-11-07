import 'package:academe_x/features/auth/domain/entities/request/login_requset_entity.dart';

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
}