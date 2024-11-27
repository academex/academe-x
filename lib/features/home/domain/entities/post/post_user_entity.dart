import 'package:equatable/equatable.dart';

import '../../../../auth/domain/entities/response/user_response_entity.dart';

class PostUserEntity extends Equatable {
  final int id;
  final String username;
  final String? photoUrl;

  const PostUserEntity({
    required this.id,
    required this.username,
    this.photoUrl,
  });

  // Factory constructor to create a PostUserEntity from UserResponseEntity
  factory PostUserEntity.fromUserResponse(UserResponseEntity user) {
    return PostUserEntity(
      id: user.id,
      username: user.username,
      photoUrl: user.photoUrl,
    );
  }

  @override
  List<Object?> get props => [id, username, photoUrl];
}