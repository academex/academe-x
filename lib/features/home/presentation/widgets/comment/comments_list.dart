import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/post/post_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:logger/logger.dart';

class CommentsList {


  FocusNode _focusNode = FocusNode();
  TextEditingController commentController = TextEditingController();

  var comments = MockData.comments;

  CommentsList({required postId, required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This allows the modal to take more space

      builder: (context) {

        return MultiBlocProvider(
          providers: [
            BlocProvider<ReplyCubit>(
              create: (context) => ReplyCubit(ReplyState(commenter: '')),
            ),
            BlocProvider<ShowRepliesCubit>(
              create: (context) => ShowRepliesCubit(ShowRepliesState(index: 0)),
            ),
          ],
          child: FractionallySizedBox(
            heightFactor: 0.9, // Modal height
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom), // Adjust for keyboard
              child: Column(
                children: [
                  20.ph(),
                  const SizedBox(
                    width: 56, // Custom width for the divider
                    child: Divider(
                      thickness: 5, // Thickness of the divider
                      color: const Color(0xffE7E8EA), // Color of the divider
                    ),
                  ),
                  16.ph(),
                  AppText(
                    text: 'التعليقات',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  20.ph(),
                  // Use Expanded to make the list scrollable
                  Expanded(
                    child: BlocBuilder<PostsCubit, PostsState>(

                      builder: (context, state) {
                        switch (state.commentsStatus) {
                          case CommentsStatus.initial:
                          case CommentsStatus.loading:
                            if(state.comments.isEmpty) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    Column(
                                      children: [
                                        CommentCardShimmer(),
                                        Divider(
                                          color: Colors.grey.shade300,
                                          endIndent: 25,
                                          indent: 25,
                                        ),
                                      ],
                                    ),
                              );
                            }

                          case CommentsStatus.failure:
                            if (state.comments.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(state.errorMessage ??
                                        'Failed to fetch Comments'),
                                    16.ph(),
                                    ElevatedButton(
                                      onPressed: () async {
                                        return await context
                                            .read<PostsCubit>()
                                            .getComments(
                                                postId: postId, refresh: true);
                                      },
                                      child: const Text('Retry'),
                                    ),
                                  ],
                                ),
                              );
                            }
                            break;

                          case CommentsStatus.success:
                            if (state.comments.isEmpty) {
                              return const Center(child: Text('No Comment found'));
                            }
                            break;
                        }
                        return NotificationListener(
                          onNotification: (notification) {
                            if (notification is ScrollEndNotification){
                                if(notification.metrics.pixels/notification.metrics.maxScrollExtent > 0.7) {
                                  context.read<PostsCubit>().getComments(
                                      postId: postId);
                                }
                            }
                            return true;
                          },

                          child: ListView.builder(
                            controller: context.read<PostsCubit>().commentScrollController,
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(), // Add this to enable refresh when at top
                            ),
                            shrinkWrap: true,
                            itemCount: state.comments.length,
                            itemBuilder: (context, index) {
                              final comment = state.comments[index];

                              if (index == state.comments.length-1) {
                                if (state.commentsStatus ==
                                    CommentsStatus.loading) {
                                  if (state.hasCommentReachedMax) {
                                    return CommentCard(
                                        postId: postId,
                                      comment: comment,
                                      // commenter:
                                      //     '${comment.user!.firstName} ${comment.user!.lastName}',
                                      // commentText: comment.content!,
                                      // likes: comment.likes!,
                                      // createdAt: comment.updatedAt!,
                                      // replies: comments[index].replies,
                                      reply: () {
                                        context.read<ReplyCubit>().reply(
                                            commenter:
                                                '@${comment.user!.username}');
                                      },
                                      commentIndex: index,
                                    );
                                  }
                                  return Column(
                                    children: [
                                      CommentCard(
                                        postId: postId,
                                        reply: () {
                                          context.read<ReplyCubit>().reply(
                                              commenter:
                                                  '@${comment.user!.username}');
                                        },
                                        commentIndex: index, comment: comment,
                                      ),
                                      CommentCardShimmer(),
                                    ],
                                  );
                                } else if (state.commentsStatus ==
                                    CommentsStatus.failure) {
                                  return Column(
                                    children: [
                                      CommentCard(
                                        postId: postId,
                                        comment: comment,
                                        // commenter:
                                        //     '${comment.user!.firstName} ${comment.user!.lastName}',
                                        // commentText: comment.content!,
                                        // likes: comment.likes!,
                                        // createdAt: comment.updatedAt!,
                                        // replies: comments[index].replies,
                                        reply: () {
                                          context.read<ReplyCubit>().reply(
                                              commenter:
                                                  '@${comment.user!.username}');
                                        },
                                        commentIndex: index,
                                      ),
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(state.errorMessage ??
                                                'Failed to fetch Comments'),
                                            16.ph(),
                                            ElevatedButton(
                                              onPressed: () async {
                                                return await context
                                                    .read<PostsCubit>()
                                                    .getComments(
                                                        postId: postId,
                                                        refresh: true);
                                              },
                                              child: const Text('Retry'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      AppText(
                                          text: state.commentError ??
                                              'I Dont know what hapen!!',
                                          fontSize: 14.sp),
                                    ],
                                  );
                                }
                              }
                              return Slidable(
                                endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        state.actionCommentId = comment.id!;
                                        state.commentAction = CommentAction.delete;
                                        context.read<PostsCubit>().actionsOnComment(postId: postId);
                                      },
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'حذف',
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {
                                        FocusScope.of(context).requestFocus(_focusNode);
                                        commentController.text = comment.content!;
                                        state.actionCommentId = comment.id!;
                                        state.commentAction = CommentAction.update;

                                      },
                                      backgroundColor: const Color(0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: 'تعديل',
                                    ),
                                  ],
                                ),
                                child: CommentCard(
                                  comment: comment,
                                  postId: postId,
                                  // commenter:
                                  //     '${comment.user!.firstName} ${comment.user!.lastName}',
                                  // commentText: comment.content!,
                                  // likes: comment.likes!,
                                  // createdAt: comment.updatedAt!,
                                  // replies: comments[index].replies,
                                  reply: () {
                                    context.read<ReplyCubit>().reply(
                                        commenter:
                                            '@${comment.user!.username}');
                                  },
                                    commentIndex: index,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),

                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 5.h, left: 24.w, right: 24.w, top: 2.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<ReplyCubit, ReplyState>(
                            builder: (context, state) {
                              commentController.text = state.commenter != ''
                                  ? '${state.commenter}: '
                                  : '';
                              // return TextField(
                              //   autofocus: true,
                              //   focusNode: _focusNode,
                              //   controller: commentController,
                              //   decoration: InputDecoration(
                              //     hintText: 'اكتب تعليقك...',
                              //     border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(5),
                              //       borderSide: BorderSide(color: Colors.grey),
                              //     ),
                              //     suffixIcon: InkWell(
                              //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                              //       onTap: () {
                              //         if (commentController.text.isNotEmpty) {
                              //           // Trigger the post comment action.
                              //           context
                              //               .read<PostsCubit>()
                              //               .createComment(postId: postId, content: commentController.text);
                              //
                              //           // Trigger reply logic if needed.
                              //           context.read<ReplyCubit>().reply(commenter: '');
                              //
                              //           // Clear the input field and unfocus.
                              //           commentController.clear();
                              //           FocusScope.of(context).unfocus();
                              //         }
                              //       },
                              //       child: Container(
                              //         padding: EdgeInsets.zero,
                              //         margin: const EdgeInsets.all(2),
                              //         child: const ImageIcon(
                              //           AssetImage('assets/images/send.png'),
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              //   keyboardType: TextInputType.multiline,
                              //   maxLines: 3,
                              //   minLines: 1,
                              // );
                              return AppTextField(
                                autofocus: true,
                                focusNode: _focusNode,
                                controller: commentController,
                                hintText: 'اكتب تعليقك...',
                                keyboardType: TextInputType.multiline,
                                maxLine: 3,
                                minLine: 1,
                                withBoarder: true,
                                // prefixText: state.commenter,
                                suffixIcon: InkWell(

                                  borderRadius: BorderRadius.all(Radius.circular(5)),

                                  onTap: () {
                                    if (commentController.text != '') {
                                      context.read<PostsCubit>().actionsOnComment(postId: postId, content: commentController.text);                                      context
                                          .read<ReplyCubit>()
                                          .reply(commenter: '');
                                      // commentController.clear();
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(15),
                                    child: const ImageIcon(

                                      AssetImage('assets/images/send.png',),
                                      color: Colors.black45,
                                      // size: 24,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
