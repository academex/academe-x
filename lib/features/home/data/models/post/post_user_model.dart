// lib/features/posts/data/models/post_user_model.dart

import 'package:academe_x/features/home/domain/entities/post/post_user_entity.dart';

class PostUserModel extends PostUserEntity {
  const PostUserModel({
    required super.id,
    required super.username,
    super.photoUrl,
  });

  factory PostUserModel.fromJson(Map<String, dynamic> json) {
    return PostUserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'photoUrl': photoUrl,
    };
  }
}