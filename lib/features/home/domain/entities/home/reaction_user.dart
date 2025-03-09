import 'package:academe_x/lib.dart';

class ReactionUser {
  final String userId;
  final String name;
  final String avatarUrl;
  final ReactionType reactionType;

  ReactionUser({
    required this.userId,
    required this.name,
    required this.avatarUrl,
    required this.reactionType,
  });
}