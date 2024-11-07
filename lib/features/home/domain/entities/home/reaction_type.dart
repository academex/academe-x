enum ReactionType {
  celebrate,
  heart,
  question,
  insightful,
  like
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

  String get reactionText {
    switch (type) {
      case ReactionType.celebrate:
        return 'تصفيق';
      case ReactionType.heart:
        return 'قلب';
      case ReactionType.question:
        return 'سؤال';
      case ReactionType.insightful:
        return 'مدهش';
      case ReactionType.like:
        return 'إعجاب';
    }
  }


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
}