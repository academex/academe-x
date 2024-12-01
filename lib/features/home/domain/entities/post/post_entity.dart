import 'package:academe_x/features/home/domain/entities/post/post_user_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/reactions_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/tag_entity.dart';
import 'package:equatable/equatable.dart';

import 'file_info_entity.dart';

class PostEntity extends Equatable {
  /**
   *

      {
      "id": 52,
      "content": "admin posting",
      "createdAt": "2024-11-28T15:57:05.558Z",
      "updatedAt": "2024-11-28T15:57:05.558Z",
      "file": {
      "url": null,
      "name": null
      },
      "images": [],
      "tags": [
      {
      "id": 1,
      "name": "it-sd"
      }
      ],
      "user": {
      "username": "admin",
      "id": 24,
      "photoUrl": null,
      "firstName": "admin",
      "lastName": "string"
      },
      "reactions": {
      "count": 1,
      "items": [
      {
      "id": 37,
      "type": "HEART",
      "user": {
      "id": 15,
      "username": "hussen",
      "photoUrl": null
      }
      }
      ]
      },
      "comments": 0,
      "isSaved": false,
      "isReacted": true,
      "reactionType": "HEART"
      "reactionType": "HEART"
      }
   */
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
  final bool? isSaved;
  final bool? isReacted;
  final String? reactionType;

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
    this.isSaved,
    this.isReacted,
    this.reactionType,
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
    bool? isSaved,
    bool? isReacted,
    String? reactionType

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
      isSaved: isSaved ?? this.isSaved,
      isReacted: isReacted?? this.isReacted
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
    isSaved,
    isReacted,
  ];
}