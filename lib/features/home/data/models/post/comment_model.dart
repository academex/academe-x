import 'package:academe_x/features/auth/auth.dart';
import 'package:academe_x/features/home/domain/entities/post/comment_entity.dart';
import 'package:logger/logger.dart'; // Assuming UserResponseEntity is here

class CommentModel extends CommentEntity {
  CommentModel({
    super.id,
    super.content,
    super.likes,
    super.isHidden,
    super.createdAt,
    super.updatedAt,
    super.postId,
    super.user,
    super.isSending,
    super.isLiked,
    super.replyCount,
    super.repliedTo,
  });

  // fromJson method to convert JSON to CommentModel
  factory CommentModel.fromJson(Map<String, dynamic> json,{UserResponseEntity? user}) {
    return CommentModel(
      id: json['id'],
      content: json['content'],
      likes: json['likes'],
      replyCount: json['repliesCount'],
      isHidden: json['isHidden'],
      isLiked: json['isLiked'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      postId: json['post']?['id'],
      user: json['user'] != null ? UserResponseModel.fromJson(json['user']) : user,
      repliedTo: json['repliedTo'] != null?(json['repliedTo']['user'] != null ? UserResponseModel.fromJson(json['repliedTo']['user']) : user):null,
    );
  }

  // toJson method to convert CommentModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'likes': likes,
      'isHidden': isHidden,
      'isLiked': isLiked,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'postId': postId,
      'repliesCount': replyCount,
      'repliedTo': repliedTo,
      'user': (user as UserResponseModel).toJson(),
    };
  }
}
