import 'package:academe_x/features/home/domain/entities/post/post_user_entity.dart';
import 'package:equatable/equatable.dart';

class ReactionItemEntity extends Equatable {
  final int id;
  final String type;
  final PostUserEntity user;

  const ReactionItemEntity({
    required this.id,
    required this.type,
    required this.user,
  });

  @override
  List<Object?> get props => [id, type, user];
}