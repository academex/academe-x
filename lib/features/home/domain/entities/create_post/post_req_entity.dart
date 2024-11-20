import 'package:academe_x/features/home/home.dart';

class PostReqEntity {
  String? content;
  List<int>? tagsId;
  int? id;
  bool? isPublished;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fileUrl;
  String? fileName;
  int? userId;
  List<dynamic>? postUploads;

  PostReqEntity({
    this.content,
    this.tagsId,
    this.createdAt,
    this.fileName,
    this.fileUrl,
    this.id,
    this.isPublished,
    this.postUploads,
    this.updatedAt,
    this.userId,
  });

  PostReqModel fromEntity() {
    return PostReqModel(content: content, tagsId: tagsId);
  }

  copyWith({String? content, List<int>? tagsId}) {
    this.content = content ?? this.content;
    this.tagsId = tagsId ?? this.tagsId;
  }
}
