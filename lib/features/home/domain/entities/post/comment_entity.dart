import 'package:academe_x/features/auth/auth.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';

class CommentEntity {
  int? id;
  String? content;
  int? likes;
  bool? isHidden;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? postId;
  UserResponseEntity? user;
  bool? isSending;
  int? replyCount;

  CommentEntity({
    this.id,
    this.content,
    this.likes,
    this.isHidden,
    this.createdAt,
    this.updatedAt,
    this.postId,
    this.user,
    this.isSending,
    int? replyCount,

  });
}