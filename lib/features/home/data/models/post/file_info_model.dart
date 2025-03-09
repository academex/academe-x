import 'package:academe_x/features/home/domain/entities/post/file_info_entity.dart';

class FileInfoModel extends FileInfo {
  const FileInfoModel({
    super.url,
    super.name,
  });

  factory FileInfoModel.fromJson(Map<String, dynamic> json) {
    return FileInfoModel(
      url: json['url'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
    };
  }
}