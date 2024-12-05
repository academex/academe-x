import 'package:academe_x/features/home/domain/entities/post/file_info_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/save_response_entity.dart';

class SaveResponseModel extends SaveResponseEntity {
  const SaveResponseModel({
    super.id,
    super.postId,
    super.userId,
  });

  factory SaveResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SaveResponseModel();

    return SaveResponseModel(
      id: json['id'] as int?,
      postId: json['postId'] as int?,
      userId: json['userId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'userId': userId,
    };
  }
}