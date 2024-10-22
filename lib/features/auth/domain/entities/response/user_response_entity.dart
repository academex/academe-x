class UserResponseEntity {
  int id;
  String username;
  String firstName;
  String lastName;
  String email;
  String role;
  String? photoUrl;
  String? bio;
  int currentYear;
  String gender;
  String phoneNum;
  int tagId;
  DateTime createdAt;
  DateTime updatedAt;

  UserResponseEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    this.photoUrl,
    this.bio,
    required this.currentYear,
    required this.gender,
    required this.phoneNum,
    required this.tagId,
    required this.createdAt,
    required this.updatedAt,
  });


}


