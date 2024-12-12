import 'package:academe_x/features/auth/auth.dart';
import 'package:academe_x/features/home/domain/entities/post/comment_entity.dart'; // Assuming UserResponseEntity is here

class CommentModel extends CommentEntity {
  CommentModel({
    super.id,
    super.comment,
    super.likes,
    super.isHidden,
    super.createdAt,
    super.updatedAt,
    super.userId,
    super.postId,
    super.user,
  });

  // fromJson method to convert JSON to CommentModel
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      comment: json['comment'],
      likes: json['likes'],
      isHidden: json['isHidden'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      userId: json['userId'],
      postId: json['postId'],
      user: json['user'] != null ? UserResponseModel.fromJson(json['user']) : null,
    );
  }

  // toJson method to convert CommentModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'comment': comment,
      'likes': likes,
      'isHidden': isHidden,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'userId': userId,
      'postId': postId,
      'user': (user as UserResponseModel).toJson(),
    };
  }
}
