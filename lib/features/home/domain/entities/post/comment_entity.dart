import 'package:academe_x/features/auth/auth.dart';

class CommentEntity {
  int? id;
  String? comment;
  int? likes;
  bool? isHidden;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  int? postId;
  UserResponseEntity? user;

  CommentEntity({
    this.id,
    this.comment,
    this.likes,
    this.isHidden,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.postId,
    this.user,
  });
}