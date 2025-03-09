import 'package:academe_x/features/home/data/models/post/reaction_item_model.dart';
import 'package:academe_x/features/home/domain/entities/post/reactions_entity.dart';

class ReactionsModel extends ReactionsEntity {
  const ReactionsModel({
    required super.count,
    required super.items,
  });

  factory ReactionsModel.fromJson(Map<String, dynamic> json) {
    return ReactionsModel(
      count: json['count'] as int,
      items: (json['items'] as List)
          .map((item) => ReactionItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'items': items.map((item) => (item as ReactionItemModel).toJson()).toList(),
    };
  }
}