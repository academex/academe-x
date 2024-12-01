import 'package:academe_x/features/home/domain/entities/post/file_info_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/image_entity.dart';

class ImageModel extends ImageEntity {
  const ImageModel({
    required super.id,
    super.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] as int,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': url,
    };
  }
}