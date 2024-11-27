import 'package:academe_x/features/home/domain/entities/post/post_user_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/reactions_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/tag_entity.dart';
import 'package:equatable/equatable.dart';

import 'file_info_entity.dart';

class PostEntity extends Equatable {
  final int id;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final FileInfo? file;
  final List<String> images;
  final List<TagEntity> tags;
  final PostUserEntity user;
  final ReactionsEntity reactions;
  final int commentsCount;

  const PostEntity({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.file,
    required this.images,
    required this.tags,
    required this.user,
    required this.reactions,
    required this.commentsCount,
  });

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