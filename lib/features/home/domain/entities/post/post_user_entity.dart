import 'package:equatable/equatable.dart';

import '../../../../auth/domain/entities/response/user_response_entity.dart';

class PostUserEntity extends Equatable {
  final int id;
  final String username;
  final String? firstName;
  final String? lastName;
  final String? photoUrl;

  const PostUserEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.photoUrl,
  });

  // Factory constructor to create a PostUserEntity from UserResponseEntity
  factory PostUserEntity.fromUserResponse(UserResponseEntity user) {
    return PostUserEntity(
      id: user.id,
      username: user.username,
      photoUrl: user.photoUrl,
      firstName: user.firstName,
      lastName: user.lastName,

    );
  }

  @override
  List<Object?> get props => [id, username, photoUrl];
}