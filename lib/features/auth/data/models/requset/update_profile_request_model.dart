import 'package:academe_x/features/auth/domain/entities/request/update_profile_request_entity.dart';
import 'package:academe_x/lib.dart';

class UpdateProfileRequestModel extends UpdateProfileRequestEntity{
  UpdateProfileRequestModel({
    super.username,
    super.firstName,
    super.lastName,
    super.email,
    super.bio,
    super.currentYear,
    super.tagId

  });

  UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    bio = json['bio'];
    currentYear = json['currentYear'];
    tagId = json['tagId'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = this.username;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['bio'] = this.bio;
    data['currentYear'] = this.currentYear;
    data['tagId'] = this.tagId;
    return data;
  }

  factory UpdateProfileRequestModel.fromEntity(UpdateProfileRequestEntity entity) {
    return UpdateProfileRequestModel(
        username: entity.username,
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email,
        bio: entity.bio,
        currentYear: entity.currentYear,
        tagId: entity.tagId
    );
  }
}