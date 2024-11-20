import 'dart:convert';

import 'package:academe_x/lib.dart';

class PostReqModel extends PostReqEntity {
  PostReqModel({
    required super.content,
    super.tagsId,
    super.id,
    super.isPublished,
    super.createdAt,
    super.fileName,
    super.fileUrl,
    super.postUploads,
    super.updatedAt,
    super.userId,
  });
  toJson() {
    return jsonEncode({
      'content': content,
      'tagIds': tagsId,
    });
  }

  factory PostReqModel.fromJson(Map<String, dynamic> json) {
    return PostReqModel(
      content: json['content'],
      id: json['id'],
      isPublished: json['isPublished'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      fileUrl: json['fileUrl'],
      fileName: json['fileName'],
      userId: json['userId'],
      postUploads: json['postUploads'],
    );
  }
}
