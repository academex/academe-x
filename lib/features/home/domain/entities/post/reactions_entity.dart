import 'package:academe_x/features/home/domain/entities/post/reaction_item_entity.dart';
import 'package:equatable/equatable.dart';

class ReactionsEntity extends Equatable {
  final int count;
  final List<ReactionItemEntity> items;

  const ReactionsEntity({
    required this.count,
    required this.items,
  });

  @override
  List<Object?> get props => [count, items];
}