import 'package:academe_x/features/home/domain/entities/post/tag_entity.dart';

class TagModel extends TagEntity {
  const TagModel({
    required super.id,
    required super.name,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
