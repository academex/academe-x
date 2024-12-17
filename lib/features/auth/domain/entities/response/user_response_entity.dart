class UserResponseEntity {
  int id;
  String username;
  String firstName;
  String lastName;
  String? email;
  String? role;
  String? photoUrl;
  String? bio;
  int? currentYear;
  String? gender;
  String? phoneNum;
  int? tagId;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserResponseEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
     this.email,
    this.role,
    this.photoUrl,
    this.bio,
    this.currentYear,
    this.gender,
    this.phoneNum,
    this.tagId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });


}


