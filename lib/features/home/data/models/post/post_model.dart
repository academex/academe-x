
import 'package:academe_x/features/home/data/models/post/post_user_model.dart';
import 'package:academe_x/features/home/data/models/post/reactions_model.dart';
import 'package:academe_x/features/home/data/models/post/tag_model.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';

import 'file_info_model.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.content,
    required super.createdAt,
    required super.updatedAt,
    super.file,
    required super.images,
    required super.tags,
    required super.user,
    required super.reactions,
    required super.commentsCount,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      file: json['file'] != null ? FileInfoModel.fromJson(json['file']) : null,
      images: List<String>.from(json['images'] ?? []),
      tags: (json['tags'] as List).map((tag) => TagModel.fromJson(tag)).toList(),
      user: PostUserModel.fromJson(json['user']),
      reactions: ReactionsModel.fromJson(json['reactions']),
      commentsCount: json['comments'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'file': file != null ? (file as FileInfoModel).toJson() : null,
      'images': images,
      'tags': tags.map((tag) => (tag as TagModel).toJson()).toList(),
      'user': (user as PostUserModel).toJson(),
      'reactions': (reactions as ReactionsModel).toJson(),
      'comments': commentsCount,
    };
  }
}