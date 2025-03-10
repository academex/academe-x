import 'package:academe_x/features/auth/auth.dart';
import 'package:academe_x/features/library/domain/entities/library_entity.dart';

class LibraryModel extends LibraryEntity {

  LibraryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    url = json['url'];
    size = json['size'];
    mimeType = json['mimeType'];
    stars = json['stars'];
    yearNum = json['yearNum'];
    subject = json['subject'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['tags'] != null) {
      tags = <MajorModel>[];
      json['tags'].forEach((v) {
        tags!.add(new MajorModel.fromJson(v));
      });
    }
    user = json['user'] != null ? new UserResponseModel.fromJson(json['user']) : null;
    if (json['star'] != null) {
      star = <int>[];
      json['star'].forEach((v) {
        star!.add(
            v is int ? v : int.parse(v.toString())
        );
      });
    }
    isStared = json['isStared'];
  }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['type'] = this.type;
  //   data['description'] = this.description;
  //   data['url'] = this.url;
  //   data['size'] = this.size;
  //   data['mimeType'] = this.mimeType;
  //   data['stars'] = this.stars;
  //   data['yearNum'] = this.yearNum;
  //   data['subject'] = this.subject;
  //   data['createdAt'] = this.createdAt;
  //   data['updatedAt'] = this.updatedAt;
  //   if (this.tags != null) {
  //     data['tags'] = this.tags!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.user != null) {
  //     data['user'] = this.user!.toJson();
  //   }
  //   if (this.star != null) {
  //     data['star'] = this.star!.map((v) => v.toJson()).toList();
  //   }
  //   data['isStared'] = this.isStared;
  //   return data;
  // }
}
