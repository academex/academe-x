import 'package:academe_x/features/home/data/models/post/post_user_model.dart';
import 'package:academe_x/features/home/domain/entities/post/reaction_item_entity.dart';

class ReactionItemModel extends ReactionItemEntity {
  const ReactionItemModel({
    required super.id,
    required super.type,
    required super.user,
  });

  factory ReactionItemModel.fromJson(Map<String, dynamic> json) {
    return ReactionItemModel(
      id: json['id'] as int,
      type: json['type'] as String,
      user: PostUserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'user': (user as PostUserModel).toJson(),
    };
  }
}