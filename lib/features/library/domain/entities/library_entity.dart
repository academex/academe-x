import 'package:academe_x/features/auth/auth.dart';
import 'package:equatable/equatable.dart';

class LibraryEntity extends Equatable{
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
  // List<int>? star;
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
    // this.star,
    this.isStared});


  LibraryEntity copyWith({
    int? id,
    String? name,
    String? type,
    String? description,
    String? url,
    int? size,
    String? mimeType,
    int? stars,
    int? yearNum,
    String? subject,
    String? createdAt,
    String? updatedAt,
    List<MajorEntity>? tags,
    UserResponseEntity? user,
    // List<int>? star,
    bool? isStared,
  }) {
    return LibraryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      url: url ?? this.url,
      size: size ?? this.size,
      mimeType: mimeType ?? this.mimeType,
      stars: stars ?? this.stars,
      yearNum: yearNum ?? this.yearNum,
      subject: subject ?? this.subject,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      user: user ?? this.user,
      // star: star ?? this.star,
      isStared: isStared ?? this.isStared,
    );


  }

  @override
  List<Object?> get props => [
    id,
    name,
    type,
    description,
    url,
    size,
    mimeType,
    stars,
    yearNum,
    subject,
    createdAt,
    updatedAt,
    tags,
    user,
    isStared,
  ];

}