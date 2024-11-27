import 'package:academe_x/lib.dart';

enum PostType {
  textOnly,
  textWithImage,
  textWithPoll,
  textWithFile,
}

class PostEntityS {
  final String userId;
  final String username;
  final String userAvatar;
  final String timeAgo;
  final String content;
  final List<String>? images;
  final Map<String, int>? pollOptions;
  final String? fileUrl;
  final String? fileName;
  final PostType type;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final List<ReactionUser>? reactionUsers;

  PostEntityS({
    required this.userId,
    required this.username,
    required this.userAvatar,
    required this.timeAgo,
    required this.content,
    this.images,
    this.pollOptions,
    this.fileUrl,
    this.fileName,
    required this.type,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    this.reactionUsers,
  });
}