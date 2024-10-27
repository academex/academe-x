class Comment {
  final String commenter;
  final String commentText;
  final int likes;
  final DateTime createdAt;
  final List<Comment> replies;

  Comment({
    required this.commenter,
    required this.commentText,
    required this.likes,
    required this.createdAt,
    this.replies = const [],
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commenter: json['commenter'],
      commentText: json['commentText'],
      likes: json['likes'],
      createdAt: DateTime.parse(json['createdAt']),
      replies: json['replies'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commenter': commenter,
      'commentText': commentText,
      'likes': likes,
      'createdAt': createdAt.toIso8601String(),
      'replies': replies,
    };
  }
}
