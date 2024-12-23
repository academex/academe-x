import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/image_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/post_user_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/reactions_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/tag_entity.dart';
import 'package:equatable/equatable.dart';

import 'file_info_entity.dart';

class PostEntity extends Equatable {

  final int? id;
  final int? savedPostId;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final FileInfo? file;
  final List<ImageEntity>? images;
  final List<MajorEntity>? tags;
  final PostUserEntity? user;
  final ReactionsEntity? reactions;
   int? commentsCount;
  final bool? isSaved;
  final bool? isReacted;
  final String? reactionType;

   PostEntity({
    this.id,
    this.savedPostId,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.file,
    this.images,
    this.tags,
    this.user,
    this.reactions,
    this.commentsCount,
    this.isSaved,
    this.isReacted,
    this.reactionType,
  });

  PostEntity copyWith({
    int? id,
    int? savedPostId,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    FileInfo? file,
    List<ImageEntity>? images,
    List<MajorEntity>? tags,
    PostUserEntity? user,
    ReactionsEntity? reactions,
    int? commentsCount,
    bool? isSaved,
    bool? isReacted,
    String? reactionType

  }) {
    return PostEntity(
      id: id ?? this.id,
        savedPostId: id ?? this.savedPostId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      file: file ?? this.file,
      images: images ?? this.images,
      tags: tags ?? this.tags,
      user: user ?? this.user,
      reactions: reactions ?? this.reactions,
      commentsCount: commentsCount ?? this.commentsCount,
      isSaved: isSaved ?? this.isSaved,
      isReacted: isReacted?? this.isReacted
    );
  }


  @override
  List<Object?> get props => [
    id,
    savedPostId,
    content,
    createdAt,
    updatedAt,
    file,
    images,
    tags,
    user,
    reactions,
    commentsCount,
    isSaved,
    isReacted,
  ];
}