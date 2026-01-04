import 'package:academe_x/core/pagination/pagination_params.dart';
import 'package:academe_x/features/home/data/models/post/comment_model.dart';
import 'package:academe_x/features/home/domain/entities/post/comment_entity.dart';
import 'package:academe_x/features/home/domain/usecases/post_use_case.dart';
import 'package:academe_x/features/home/presentation/controllers/states/comment/comments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/extensions/cached_user_extension.dart';
import '../../../../../../core/utils/logger.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final PostUseCase postUseCase;
  
  CommentsCubit({required this.postUseCase}) : super(const CommentsState());

  // ========== COMMENTS CRUD ==========
  
  /// Load comments for a post
  Future<void> loadComments({
    required int postId,
    bool refresh = false,
  }) async {
    if (state.status == CommentsStatus.loading && !refresh) return;
    if (state.hasReachedMax && !refresh) return;

    try {
      if (refresh) {
        emit(state.copyWith(
          status: CommentsStatus.loading,
          postId: postId,
          currentPage: 1,
          hasReachedMax: false,
          comments: [],
        ));
      } else {
        emit(state.copyWith(status: CommentsStatus.loading));
      }

      final page = refresh ? 1 : state.currentPage;
      final result = await postUseCase.getComments(
        PaginationParams(page: page),
        postId,
      );

      result.fold(
        (failure) {
          emit(state.copyWith(
            status: CommentsStatus.failure,
            error: failure.message,
          ));
        },
        (paginatedData) {
          final newComments = refresh
              ? paginatedData.items
              : [...state.comments, ...paginatedData.items];

          emit(state.copyWith(
            status: CommentsStatus.success,
            comments: newComments,
            currentPage: page + 1,
            hasReachedMax: !paginatedData.hasNextPage,
            error: null,
          ));
        },
      );
    } catch (e) {
      AppLogger.e('Error loading comments: $e');
      emit(state.copyWith(
        status: CommentsStatus.failure,
        error: e.toString(),
      ));
    }
  }

  /// Create a new comment
  Future<void> createComment({
    required int postId,
    required String content,
    required BuildContext context,
  }) async {
    if (content.trim().isEmpty) return;

    try {
      emit(state.copyWith(actionStatus: CommentActionStatus.loading));

      // Get current user
      final currentUser = await context.cachedUser;
      if (currentUser == null) {
        emit(state.copyWith(
          actionStatus: CommentActionStatus.failure,
          actionError: 'User not found',
        ));
        return;
      }

      // Add optimistic comment
      final optimisticComment = CommentModel(
        id: DateTime.now().millisecondsSinceEpoch,
        user: currentUser.user,
        content: content,
        postId: postId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSending: true,
        likes: 0,
      );

      emit(state.copyWith(
        comments: [...state.comments, optimisticComment],
      ));

      // Make API call
      final result = await postUseCase.createComment(
        postId: postId,
        content: content,
      );

      result.fold(
        (failure) {
          // Remove optimistic comment
          final updatedComments = state.comments
              .where((c) => c.id != optimisticComment.id)
              .toList();
          
          emit(state.copyWith(
            actionStatus: CommentActionStatus.failure,
            actionError: failure.message,
            comments: updatedComments,
          ));
        },
        (response) {
          // Replace optimistic with real comment
          final updatedComments = state.comments.map((c) {
            return c.id == optimisticComment.id ? response.data! : c;
          }).toList();

          emit(state.copyWith(
            actionStatus: CommentActionStatus.success,
            comments: updatedComments,
          ));
        },
      );
    } catch (e) {
      AppLogger.e('Error creating comment: $e');
      emit(state.copyWith(
        actionStatus: CommentActionStatus.failure,
        actionError: e.toString(),
      ));
    }
  }

  /// Update an existing comment
  Future<void> updateComment({
    required int postId,
    required int commentId,
    required String content,
  }) async {
    if (content.trim().isEmpty) return;

    try {
      emit(state.copyWith(actionStatus: CommentActionStatus.loading));

      final result = await postUseCase.updateComment(
        postId: postId,
        commentId: commentId,
        content: content,
      );

      result.fold(
        (failure) {
          emit(state.copyWith(
            actionStatus: CommentActionStatus.failure,
            actionError: failure.message,
          ));
        },
        (response) {
          final updatedComments = state.comments.map((comment) {
            return comment.id == commentId ? response.data! : comment;
          }).toList();

          emit(state.copyWith(
            actionStatus: CommentActionStatus.success,
            comments: updatedComments,
            isEditMode: false,
            editingComment: null,
          ));
        },
      );
    } catch (e) {
      AppLogger.e('Error updating comment: $e');
      emit(state.copyWith(
        actionStatus: CommentActionStatus.failure,
        actionError: e.toString(),
      ));
    }
  }

  /// Delete a comment
  Future<void> deleteComment({
    required int postId,
    required int commentId,
  }) async {
    try {
      emit(state.copyWith(actionStatus: CommentActionStatus.loading));

      final result = await postUseCase.deleteComment(
        postId: postId,
        commentId: commentId,
      );

      result.fold(
        (failure) {
          emit(state.copyWith(
            actionStatus: CommentActionStatus.failure,
            actionError: failure.message,
          ));
        },
        (_) {
          final updatedComments = state.comments
              .where((comment) => comment.id != commentId)
              .toList();

          emit(state.copyWith(
            actionStatus: CommentActionStatus.success,
            comments: updatedComments,
          ));
        },
      );
    } catch (e) {
      AppLogger.e('Error deleting comment: $e');
      emit(state.copyWith(
        actionStatus: CommentActionStatus.failure,
        actionError: e.toString(),
      ));
    }
  }

  /// Like/unlike a comment
  Future<void> toggleCommentLike({
    required int postId,
    required int commentId,
  }) async {
    try {
      // Optimistic update
      final updatedComments = state.comments.map((comment) {
        if (comment.id == commentId) {
          return comment.copyWith(
            likes: comment.likes! + (comment.isLiked! ? -1 : 1),
            isLiked: !comment.isLiked!,
          );
        }
        return comment;
      }).toList();

      emit(state.copyWith(comments: updatedComments));

      // Make API call
      final result = await postUseCase.likeOnCommentOrReply(
        commentId: commentId,
        postId: postId,
      );

      result.fold(
        (failure) {
          // Revert on failure
          emit(state.copyWith(comments: state.comments));
          AppLogger.e('Like failed: ${failure.message}');
        },
        (_) {
          AppLogger.success('Like successful');
        },
      );
    } catch (e) {
      AppLogger.e('Error toggling like: $e');
      // Revert on error
      emit(state.copyWith(comments: state.comments));
    }
  }

  // ========== REPLIES ==========
  
  /// Load replies for a comment
  Future<void> loadReplies({required int commentId}) async {
    if (state.loadingRepliesMap[commentId] == true) return;

    try {
      // Set loading state
      final updatedLoadingMap = Map<int, bool>.from(state.loadingRepliesMap);
      updatedLoadingMap[commentId] = true;
      emit(state.copyWith(loadingRepliesMap: updatedLoadingMap));

      final result = await postUseCase.getReplies(commentId: commentId);

      result.fold(
        (failure) {
          final updatedMap = Map<int, bool>.from(state.loadingRepliesMap);
          updatedMap[commentId] = false;
          emit(state.copyWith(loadingRepliesMap: updatedMap));
          AppLogger.e('Error loading replies: ${failure.message}');
        },
        (response) {
          final updatedRepliesMap = Map<int, List<CommentEntity>>.from(state.repliesMap);
          updatedRepliesMap[commentId] = response.data ?? [];

          final updatedLoadingMap = Map<int, bool>.from(state.loadingRepliesMap);
          updatedLoadingMap[commentId] = false;

          emit(state.copyWith(
            repliesMap: updatedRepliesMap,
            loadingRepliesMap: updatedLoadingMap,
          ));
        },
      );
    } catch (e) {
      AppLogger.e('Error loading replies: $e');
      final updatedMap = Map<int, bool>.from(state.loadingRepliesMap);
      updatedMap[commentId] = false;
      emit(state.copyWith(loadingRepliesMap: updatedMap));
    }
  }

  /// Create a reply
  Future<void> createReply({
    required int commentId,
    required String content,
    int? parentId,
    required BuildContext context,
  }) async {
    if (content.trim().isEmpty) return;

    try {
      emit(state.copyWith(actionStatus: CommentActionStatus.loading));

      final currentUser = await context.cachedUser;
      if (currentUser == null) return;

      // Optimistic update
      final optimisticReply = CommentModel(
        id: DateTime.now().millisecondsSinceEpoch,
        user: currentUser.user,
        content: content,
        postId: commentId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSending: true,
        likes: 0,
      );

      final updatedRepliesMap = Map<int, List<CommentEntity>>.from(state.repliesMap);
      updatedRepliesMap[commentId] = [
        ...?state.repliesMap[commentId],
        optimisticReply,
      ];

      emit(state.copyWith(repliesMap: updatedRepliesMap));

      // Make API call
      final result = await postUseCase.createReply(
        commentId: commentId,
        content: content,
        parentId: parentId,
      );

      result.fold(
        (failure) {
          // Remove optimistic reply
          final revertedMap = Map<int, List<CommentEntity>>.from(state.repliesMap);
          revertedMap[commentId] = state.repliesMap[commentId]!
              .where((r) => r.id != optimisticReply.id)
              .toList();

          emit(state.copyWith(
            actionStatus: CommentActionStatus.failure,
            actionError: failure.message,
            repliesMap: revertedMap,
          ));
        },
        (response) {
          // Replace optimistic with real reply
          final finalMap = Map<int, List<CommentEntity>>.from(state.repliesMap);
          finalMap[commentId] = state.repliesMap[commentId]!.map((r) {
            return r.id == optimisticReply.id ? response.data! : r;
          }).toList();

          // Increment reply count
          final updatedComments = state.comments.map((comment) {
            if (comment.id == commentId) {
              return comment.copyWith(
                replyCount: (comment.replyCount ?? 0) + 1,
              );
            }
            return comment;
          }).toList();

          emit(state.copyWith(
            actionStatus: CommentActionStatus.success,
            repliesMap: finalMap,
            comments: updatedComments,
            isReplyMode: false,
            replyingTo: null,
          ));
        },
      );
    } catch (e) {
      AppLogger.e('Error creating reply: $e');
      emit(state.copyWith(
        actionStatus: CommentActionStatus.failure,
        actionError: e.toString(),
      ));
    }
  }

  // ========== UI STATE MANAGEMENT ==========
  
  /// Enter reply mode
  void startReply(CommentEntity comment) {
    emit(state.copyWith(
      isReplyMode: true,
      replyingTo: comment,
      isEditMode: false,
      editingComment: null,
    ));
  }

  /// Cancel reply mode
  void cancelReply() {
    emit(state.cancelReply());
  }

  /// Enter edit mode
  void startEdit(CommentEntity comment) {
    emit(state.copyWith(
      isEditMode: true,
      editingComment: comment,
      isReplyMode: false,
      replyingTo: null,
    ));
  }

  /// Cancel edit mode
  void cancelEdit() {
    emit(state.cancelEdit());
  }

  /// Toggle replies visibility
  void toggleReplies(int commentId) {
    if (state.repliesMap.containsKey(commentId)) {
      // Already loaded, just toggle visibility by removing from map
      final updatedMap = Map<int, List<CommentEntity>>.from(state.repliesMap);
      updatedMap.remove(commentId);
      emit(state.copyWith(repliesMap: updatedMap));
    } else {
      // Load replies
      loadReplies(commentId: commentId);
    }
  }

  /// Reset state (useful when closing bottom sheet)
  void reset() {
    emit(const CommentsState());
  }
}