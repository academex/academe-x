import 'package:academe_x/features/home/domain/entities/post/post_user_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/reactions_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/tag_entity.dart';
import 'package:equatable/equatable.dart';

import 'file_info_entity.dart';

class PostEntity extends Equatable {
  final int? id;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final FileInfo? file;
  final List<String>? images;
  final List<TagEntity>? tags;
  final PostUserEntity? user;
  final ReactionsEntity? reactions;
  final int? commentsCount;

  const PostEntity({
    this.id,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.file,
    this.images,
    this.tags,
    this.user,
    this.reactions,
    this.commentsCount,
  });

  PostEntity copyWith({
    int? id,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    FileInfo? file,
    List<String>? images,
    List<TagEntity>? tags,
    PostUserEntity? user,
    ReactionsEntity? reactions,
    int? commentsCount,
  }) {
    return PostEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      file: file ?? this.file,
      images: images ?? this.images,
      tags: tags ?? this.tags,
      user: user ?? this.user,
      reactions: reactions ?? this.reactions,
      commentsCount: commentsCount ?? this.commentsCount,
    );
  }


  @override
  List<Object?> get props => [
    id,
    content,
    createdAt,
    updatedAt,
    file,
    images,
    tags,
    user,
    reactions,
    commentsCount,
  ];
}