import 'package:academe_x/features/auth/domain/entities/request/login_requset_entity.dart';

class LoginRequsetModel extends LoginRequsetEntity{
  LoginRequsetModel({super.username, super.password});

  LoginRequsetModel.fromJson(Map<String, dynamic> json) {
  username = json['username'];
  password = json['password'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['username'] = this.username;
  data['password'] = this.password;
  return data;
}
}