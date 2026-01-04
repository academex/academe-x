import 'package:academe_x/features/home/domain/entities/post/comment_entity.dart';
import 'package:equatable/equatable.dart';

enum CommentsStatus { initial, loading, success, failure }
enum CommentActionStatus { idle, loading, success, failure }

class CommentsState extends Equatable {
  // Comments data
  final List<CommentEntity> comments;
  final CommentsStatus status;
  final String? error;
  
  // Pagination
  final int currentPage;
  final bool hasReachedMax;
  
  // Current post
  final int? postId;
  
  // Replies
  final Map<int, List<CommentEntity>> repliesMap; // commentId -> replies
  final Map<int, bool> loadingRepliesMap; // commentId -> isLoading
  
  // Action states
  final CommentActionStatus actionStatus;
  final String? actionError;
  
  // Reply mode
  final bool isReplyMode;
  final CommentEntity? replyingTo;
  
  // Edit mode
  final bool isEditMode;
  final CommentEntity? editingComment;

  const CommentsState({
    this.comments = const [],
    this.status = CommentsStatus.initial,
    this.error,
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.postId,
    this.repliesMap = const {},
    this.loadingRepliesMap = const {},
    this.actionStatus = CommentActionStatus.idle,
    this.actionError,
    this.isReplyMode = false,
    this.replyingTo,
    this.isEditMode = false,
    this.editingComment,
  });

  CommentsState copyWith({
    List<CommentEntity>? comments,
    CommentsStatus? status,
    String? error,
    int? currentPage,
    bool? hasReachedMax,
    int? postId,
    Map<int, List<CommentEntity>>? repliesMap,
    Map<int, bool>? loadingRepliesMap,
    CommentActionStatus? actionStatus,
    String? actionError,
    bool? isReplyMode,
    CommentEntity? replyingTo,
    bool? isEditMode,
    CommentEntity? editingComment,
  }) {
    return CommentsState(
      comments: comments ?? this.comments,
      status: status ?? this.status,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      postId: postId ?? this.postId,
      repliesMap: repliesMap ?? this.repliesMap,
      loadingRepliesMap: loadingRepliesMap ?? this.loadingRepliesMap,
      actionStatus: actionStatus ?? this.actionStatus,
      actionError: actionError,
      isReplyMode: isReplyMode ?? this.isReplyMode,
      replyingTo: replyingTo,
      isEditMode: isEditMode ?? this.isEditMode,
      editingComment: editingComment,
    );
  }
  
  // Reset reply mode
  CommentsState cancelReply() {
    return copyWith(
      isReplyMode: false,
      replyingTo: null,
    );
  }
  
  // Reset edit mode
  CommentsState cancelEdit() {
    return copyWith(
      isEditMode: false,
      editingComment: null,
    );
  }

  @override
  List<Object?> get props => [
        comments,
        status,
        error,
        currentPage,
        hasReachedMax,
        postId,
        repliesMap,
        loadingRepliesMap,
        actionStatus,
        actionError,
        isReplyMode,
        replyingTo,
        isEditMode,
        editingComment,
      ];
}