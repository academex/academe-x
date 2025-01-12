import 'package:academe_x/features/home/domain/entities/post/comment_entity.dart';
enum ReplyStatus { initial, loading, success, failure }

class ShowRepliesState{
  final bool show;
  final int? index;
  final String? error;
  final ReplyStatus status;
  final List<CommentEntity>? replies;

  ShowRepliesState({
    this.show = false,
    this.index,
    this.replies,
    this.error,
    this.status = ReplyStatus.initial,
  });

  ShowRepliesState copyWith({
    bool? show,
    int? index,
    List<CommentEntity>? replies,
    ReplyStatus? status,
    String? error,
  }) {
    return ShowRepliesState(
      show: show ?? this.show,
      index: index ?? this.index,
      replies: replies ?? this.replies,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
