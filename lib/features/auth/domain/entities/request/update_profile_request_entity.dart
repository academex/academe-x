import 'package:academe_x/core/core.dart';

import '../../../presentation/controllers/states/auth_state.dart';

class UpdateProfileRequestEntity {
  String? username;
  String? firstName;
  String? lastName;
  String? photoUrl;
  String? email;
  String? bio;
  int? currentYear;
  int? tagId;

  UpdateProfileRequestEntity({
    this.username,
    this.firstName,
    this.lastName,
    this.photoUrl,
    this.email,
    this.bio,
    this.currentYear,
    this.tagId,
  });

  // Create a copy with potential changes
  UpdateProfileRequestEntity copyWith({
    String? username,
    String? firstName,
    String? lastName,
    String? photoUrl,
    String? email,
    String? bio,
    int? currentYear,
    int? tagId,
  }) {
    return UpdateProfileRequestEntity(
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      currentYear: currentYear ?? this.currentYear,
      tagId: tagId ?? this.tagId,
    );
  }

  // Convert to map with only changed fields
  Map<String, dynamic> toChangedFieldsMap(AuthState originalUser) {
    final Map<String, dynamic> changes = {};

    if (username != originalUser.userNameController?.text && username != null) changes['username'] = originalUser.userNameController?.text ;
    if (firstName != originalUser.firstNameController?.text && firstName != null) changes['firstName'] = originalUser.firstNameController?.text ;
    if (lastName != originalUser.lastNameController?.text && lastName != null) changes['lastName'] = originalUser.lastNameController?.text ;
    if (photoUrl != originalUser.photoUrl && photoUrl != null) changes['photoUrl'] = originalUser.photoUrl ;
    if (email != originalUser.emailController?.text && email != null) changes['email'] = originalUser.emailController?.text ;
    if (bio != originalUser.bioController?.text && bio != null) changes['bio'] = originalUser.bioController?.text;
    if (currentYear != (originalUser.selectedSemesterIndex!+1)&& currentYear != null) changes['currentYear'] = (originalUser.selectedSemesterIndex!+1);
    if (tagId != originalUser.selectedTagId && tagId != null) changes['tagId'] = originalUser.selectedTagId;

    return changes;
  }
}