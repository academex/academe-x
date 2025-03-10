import 'package:academe_x/features/auth/auth.dart';

class LibraryEntity {
  int? id;
  String? name;
  String? type;
  String? description;
  String? url;
  int? size;
  String? mimeType;
  int? stars;
  int? yearNum;
  String? subject;
  String? createdAt;
  String? updatedAt;
  List<MajorEntity>? tags;
  UserResponseEntity? user;
  List<int>? star;
  bool? isStared;

  LibraryEntity({this.id,
    this.name,
    this.type,
    this.description,
    this.url,
    this.size,
    this.mimeType,
    this.stars,
    this.yearNum,
    this.subject,
    this.createdAt,
    this.updatedAt,
    this.tags,
    this.user,
    this.star,
    this.isStared});
}