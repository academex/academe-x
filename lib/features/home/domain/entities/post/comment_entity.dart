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
  bool? isLiked;
  int? replyCount;
  UserResponseEntity? repliedTo;

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
    this.isLiked,
    this.replyCount,
    this.repliedTo,
  });

  // copyWith method for immutability
  CommentEntity copyWith({  
    int? id,
    String? content,
    int? likes,
    bool? isHidden,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? postId,
    UserResponseEntity? user,
    bool? isSending,
    bool? isLiked,
    int? replyCount,
    UserResponseEntity? repliedTo,
  }) {
    return CommentEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      likes: likes ?? this.likes,
      isHidden: isHidden ?? this.isHidden,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      postId: postId ?? this.postId,
      user: user ?? this.user,
      isSending: isSending ?? this.isSending,
      isLiked: isLiked ?? this.isLiked,
      replyCount: replyCount ?? this.replyCount,
      repliedTo: repliedTo ?? this.repliedTo,
    );
  } 
}
