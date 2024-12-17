import 'dart:async';

import 'package:academe_x/features/home/domain/entities/post/comment_entity.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/post/post_state.dart';
import 'package:academe_x/features/home/presentation/widgets/post/shimmer/post_widget_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

class CommentsList {


  final FocusNode _focusNode = FocusNode();
  TextEditingController comment = TextEditingController();

  // MockData mockData =MockData();
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
                        Logger().f(state.commentsStatus);
                        switch (state.commentsStatus) {
                          case CommentsStatus.initial:
                          case CommentsStatus.loading:
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Column(
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
                              Logger().d(notification.metrics.pixels);
                                if(notification.metrics.pixels == notification.metrics.maxScrollExtent) {
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
                                      commenter:
                                          '${comment.user!.firstName} ${comment.user!.lastName}',
                                      commentText: comment.content!,
                                      likes: comment.likes!,
                                      createdAt: comment.updatedAt!,
                                      // replies: comments[index].replies,
                                      reply: () {
                                        context.read<ReplyCubit>().reply(
                                            commenter:
                                                'رد على @${comment.user!.username}');
                                      },
                                      commentIndex: index,
                                    );
                                  }
                                  return Column(
                                    children: [
                                      CommentCard(
                                        commenter:
                                            '${comment.user!.firstName} ${comment.user!.lastName}',
                                        commentText: comment.content!,
                                        likes: comment.likes!,
                                        createdAt: comment.updatedAt!,
                                        // replies: comments[index].replies,
                                        reply: () {
                                          context.read<ReplyCubit>().reply(
                                              commenter:
                                                  'رد على @${comment.user!.username}');
                                        },
                                        commentIndex: index,
                                      ),
                                      CommentCardShimmer(),
                                    ],
                                  );
                                } else if (state.commentsStatus ==
                                    CommentsStatus.failure) {
                                  return Column(
                                    children: [
                                      CommentCard(
                                        commenter:
                                            '${comment.user!.firstName} ${comment.user!.lastName}',
                                        commentText: comment.content!,
                                        likes: comment.likes!,
                                        createdAt: comment.updatedAt!,
                                        // replies: comments[index].replies,
                                        reply: () {
                                          context.read<ReplyCubit>().reply(
                                              commenter:
                                                  'رد على @${comment.user!.username}');
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
                              return CommentCard(
                              commenter:
                                  '${comment.user!.firstName} ${comment.user!.lastName}',
                              commentText: comment.content!,
                              likes: comment.likes!,
                              createdAt:comment.updatedAt!,
                              // replies: comments[index].replies,
                              reply: () {
                                context.read<ReplyCubit>().reply(
                                    commenter:
                                        'رد على @${comment.user!.username}');
                              },
                              commentIndex: index,
                            );
                            },
                          ),
                        );
                      },
                    ),

                    // ListView.builder(
                    //   itemCount: comments.length,
                    //   itemBuilder: (context, index) {
                    //     return Column(
                    //       children: [
                    //
                    //
                    //         CommentCard(
                    //           commenter: comments[index].commenter,
                    //           commentText: comments[index].commentText,
                    //           likes: comments[index].likes,
                    //           replies: comments[index].replies,
                    //           reply: () {
                    //             context.read<ReplyCubit>().reply(
                    //                 commenter:
                    //                     'رد على @${comments[index].commenter}');
                    //           },
                    //           commentIndex: index,
                    //         ),
                    //
                    //
                    //         BlocBuilder<ShowRepliesCubit, ShowRepliesState>(
                    //             buildWhen: (previous, current) {
                    //           return current.index == index;
                    //         }, builder: (context, state) {
                    //           return Column(
                    //             children: [
                    //               for (int i = 0;
                    //                   i < comments[index].replies.length &&
                    //                       state.show &&
                    //                       state.index == index;
                    //                   i++)
                    //                 CommentCard(
                    //                   isReply: true,
                    //                   commenter:
                    //                       comments[index].replies[i].commenter,
                    //                   commentText: comments[index]
                    //                       .replies[i]
                    //                       .commentText,
                    //                   likes: comments[index].replies[i].likes,
                    //                   reply: () {
                    //                     context.read<ReplyCubit>().reply(
                    //                         commenter:
                    //                             'رد على @${comments[index].replies[i].commenter}');
                    //                   },
                    //                   isEndReply: i ==
                    //                       ((comments[index].replies.length) -
                    //                           1),
                    //                 ),
                    //             ],
                    //           );
                    //         }),
                    //       ],
                    //     );
                    //   },
                    // ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 5, left: 24, right: 24, top: 2.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<ReplyCubit, ReplyState>(
                            builder: (context, state) {
                              comment.text = state.commenter != ''
                                  ? '${state.commenter}: '
                                  : '';
                              return AppTextField(
                                autofocus: comment.text.isNotEmpty,
                                focusNode: _focusNode,
                                controller: comment,
                                hintText: 'اكتب تعليقك...',
                                keyboardType: TextInputType.multiline,
                                maxLine: 3,
                                minLine: 1,
                                withBoarder: true,
                                // prefixText: state.commenter,
                                suffix: GestureDetector(
                                  onTap: () {
                                    if (comment.text != '') {
                                      context
                                          .read<ReplyCubit>()
                                          .reply(commenter: '');
                                      comment.clear();
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                  child: const ImageIcon(
                                    AssetImage('assets/images/send.png'),
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        18.pw(),
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                              color: Colors
                                  .white, // Background color of the container
                              borderRadius:
                                  BorderRadius.circular(12), // Rounded corners
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12, // Shadow color
                                  blurRadius: 4, // Shadow blur
                                  offset: Offset(0, 2), // Shadow position
                                ),
                              ],
                              border: Border.all(color: Colors.black12)),
                          child: Center(
                            child: AppText(
                              text: '😍', // Emoji
                              fontSize: 20, // Size of the emoji
                            ),
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
