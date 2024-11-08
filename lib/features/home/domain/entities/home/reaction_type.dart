import 'dart:ui';

enum ReactionType {
  heart,
  like,
  question,
  insightful,
  celebrate,
}

class ReactionEntity {
  final ReactionType type;
  final int count;
  final bool isSelected;

  const ReactionEntity({
    required this.type,
    required this.count,
    this.isSelected = false,
  });




}

extension ReactionTypeExtension on ReactionType {
  String get assetPath {
    switch (this) {
      case ReactionType.heart:
        return 'assets/icons/reactions/heart.png';
      case ReactionType.like:
        return 'assets/icons/reactions/like.png';
      case ReactionType.question:
        return 'assets/icons/reactions/question.png';
      case ReactionType.insightful:
        return 'assets/icons/reactions/insightful.png';
      case ReactionType.celebrate:
        return 'assets/icons/reactions/celebrate.png';
    }
  }

  String get reactionText {
    switch (this) {
      case ReactionType.celebrate:
        return 'تصفيق';
      case ReactionType.heart:
        return 'قلب';
      case ReactionType.question:
        return 'سؤال';
      case ReactionType.insightful:
        return 'مذهل';
      case ReactionType.like:
        return 'إعجاب';
    }
  }

  Color get reactionColor {
    switch (this) {
      case ReactionType.celebrate:
        return Color(0xffFFDCD4);
      case ReactionType.heart:
        return Color(0xffFF5D5D);
      case ReactionType.question:
        return Color(0xff0EC2B4);
      case ReactionType.insightful:
        return Color(0xffFF7D99);
      case ReactionType.like:
        return Color(0xff6582FD);
    }
  }
}

