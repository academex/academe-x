import 'package:academe_x/lib.dart';

class SignupRequestModel extends SignupRequestEntity{
  SignupRequestModel({
    super.username,
    super.firstName,
    super.lastName,
    super.email,
    super.phoneNum,
    super.gender,
    super.currentYear,
    super.password,
    super.tagId

  });

  SignupRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    currentYear = json['currentYear'];
    gender = json['gender'];
    phoneNum = json['phoneNum'];
    tagId = json['tagId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = this.username;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['currentYear'] = this.currentYear;
    data['gender'] = this.gender;
    data['phoneNum'] = this.phoneNum;
    data['tagId'] = this.tagId;
    return data;
  }

  factory SignupRequestModel.fromEntity(SignupRequestEntity entity) {
    return SignupRequestModel(
      username: entity.username,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phoneNum: entity.phoneNum,
      email: entity.email,
      gender: entity.gender,
      password: entity.password,
      currentYear: entity.currentYear,
      tagId: entity.tagId
    );
  }

  bool isValid() {
    return username!.length >= 3 &&
        firstName!.isNotEmpty &&
        email!.isNotEmpty &&
        password!.length >= 6 &&
        phoneNum!.length >= 10 &&
        ['MALE', 'FEMALE'].contains(gender);
  }
}