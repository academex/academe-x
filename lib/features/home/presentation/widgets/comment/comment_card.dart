// ignore_for_file: must_be_immutable

import 'package:academe_x/features/home/domain/entities/post/comment_entity.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/post/post_state.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';

class CommentCard extends StatelessWidget {
  final CommentEntity comment;

  // final String commenter;
  // final String commentText;
  // int likes;
  final int? commentIndex;
  final int postId;
  final bool isReply;
  final void Function() reply;
  final List<Comment>? replies;
  bool _showReplyVisibility = false;
  bool isEndReply;
  bool useNewDesign = true;
  late final String userName;

  // DateTime createdAt;

  CommentCard({
    required this.comment,
    // required this.commenter,
    required this.postId,
    // required this.commentText,
    // required this.likes,
    required this.reply,
    // required this.createdAt,
    // this.showReplies,
    this.commentIndex,
    this.isReply = false,
    this.replies = const [],
    this.isEndReply = false,
    this.useNewDesign = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (useNewDesign) isEndReply = false;
    userName = '${comment.user!.firstName} ${comment.user!.lastName}';
    return BlocProvider(
      create: (_) => FavoriteCubit(false),
      child: Padding(
        padding: EdgeInsets.only(top: isReply ? 0 : 9, right: 25, left: 15),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isReply)
                Padding(
                    padding: EdgeInsets.only(right: isEndReply ? 19 : 20),
                    child: !isEndReply
                        ? const VerticalDivider(
                            color: Colors.black26,
                            width: 0,
                          )
                        : null),
              if (isReply)
                Container(
                  width: 15,
                  height: 20,
                  decoration: useNewDesign
                      ? null
                      : BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15)),
                          border: Border(
                              bottom: const BorderSide(color: Colors.black26),
                              right: isEndReply
                                  ? const BorderSide(color: Colors.black26)
                                  : BorderSide.none),
                        ),
                ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Text(userName[0]),
                  ),
                  if (!isReply)
                    BlocBuilder<ShowRepliesCubit, ShowRepliesState>(
                      buildWhen: (previous, current) =>
                          current.index == commentIndex,
                      builder: (context, state) {
                        return Visibility(
                          visible: state.show,
                          child: const Expanded(
                              child: VerticalDivider(
                            color: Colors.black26,
                          )),
                        );
                      },
                    ),
                ],
              ), // Placeholder avatar
              9.pw(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: userName,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    5.ph(),
                    Text(comment.content!),
                    // if(withStatus == null || withStatus == false)

                    BlocBuilder<PostsCubit, PostsState>(
                      buildWhen: (previous, current) {
                        bool changedState = previous.createCommentStatus !=
                            current.createCommentStatus;
                        bool needStatus;

                        try{
                          needStatus = current.comments[commentIndex!].isSending??false;
                        }catch  (e){
                          needStatus = false;
                        }

                        return changedState && needStatus;
                      },
                      builder: (context, state) {
                        if (!(state.comments[commentIndex!].isSending ?? false))
                          return ReplyAndTime(
                              createdAt: comment.createdAt!, reply: reply);
                        if (state.createCommentStatus ==
                            CreateCommentStatus.success) {
                          state.comments[commentIndex!].isSending = false;
                          state.createCommentStatus = CreateCommentStatus.initial;
                          return ReplyAndTime(
                            createdAt: comment.createdAt!, reply: reply,);
                        } else if (state.createCommentStatus ==
                            CreateCommentStatus.loading) {
                          return AppText(
                              text: 'جار ارسال ردك...', fontSize: 10.sp);
                        } else if (state.createCommentStatus ==
                            CreateCommentStatus.failure) {
                          String retry = 'اعادة المحاولة';
                          if (state.failureComments.length == 2) {
                            retry = 'اعادة محاةلة ارسال التعليقين';
                          } else if (state.failureComments.length > 2) {
                            retry = 'اعادة محاولة ارسال جميع تعليقاتك';
                          }
                          return Row(
                            children: [
                              Expanded(
                                  child: AppText(
                                    text: state.createCommentError!,
                                    fontSize: 10.sp,
                                    color: Colors.red,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<PostsCubit>()
                                        .retrySendFailureComments();
                                  },
                                  icon: InkWell(
                                    child: AppText(
                                      text: retry,
                                      fontSize: 10.sp,
                                      color: Colors.blue,
                                    ),
                                  ))
                            ],
                          );
                        } else {
                          return ReplyAndTime(
                              createdAt: comment.createdAt!, reply: reply);
                        }
                      },
                    ),
                    BlocBuilder<PostsCubit, PostsState>(
                      buildWhen: (previous, current) {
                        return current.updateDeleteCommentStatus !=
                            previous.updateDeleteCommentStatus &&
                            current.actionCommentId == comment.id;
                      },
                      builder: (context, state) {
                        if (state.actionCommentId != comment.id)
                          return const SizedBox();
                        if (state.updateDeleteCommentStatus ==
                            UpdateDeleteCommentStatus.loading) {
                          if (state.commentAction == CommentAction.delete) {
                            /// deleting
                            // return const LinearProgressIndicator(
                            //   color: Colors.red,
                            //   backgroundColor: Colors.transparent,
                            // );
                          }
                          /// updating
                          // return const LinearProgressIndicator(
                          //   backgroundColor: Colors.transparent,
                          //   color: Colors.blue,
                          // );
                        } else if (state.updateDeleteCommentStatus ==
                            UpdateDeleteCommentStatus.failure) {
                          return AppText(
                            text: state.commentError??'un expected error',
                            fontSize: 12.sp,
                            color: Colors.red,
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    9.ph(),
                  ],
                ),
              ),
              BlocBuilder<FavoriteCubit, bool>(
                builder: (context, stateForFavor) => InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if (!stateForFavor) {
                      comment.likes = comment.likes! + 1;
                    } else {
                      comment.likes = comment.likes! - 1;
                    }
                    context.read<FavoriteCubit>().change();
                  },
                  child: SizedBox(
                    height: 40,
                    width: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!(stateForFavor as bool))
                          Image.asset(
                            'assets/icons/favourite.png',
                            height: 17,
                            width: 19,
                          ),
                        if (stateForFavor)
                          Image.asset(
                            'assets/icons/favourite_selected.png',
                            height: 17,
                            width: 19,
                          ),
                        2.pw(),
                        Text(comment.likes.toString()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

String getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 365) {
    final years = (difference.inDays / 365).floor();
    return '$years ${years == 1 ? 'year' : 'years'} ago';
  } else if (difference.inDays > 30) {
    final months = (difference.inDays / 30).floor();
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  } else if (difference.inDays > 0) {
    return 'منذ${difference.inDays} ${difference.inDays == 1 ? 'ي' : 'أي'}';
  } else if (difference.inHours > 0) {
    return 'منذ ${difference.inHours}  ${difference.inHours == 1 ? 'س' : 'س'}';
  } else if (difference.inMinutes > 0) {
    return 'منذ${difference.inMinutes} ${difference.inMinutes == 1 ? 'د' : 'د'}';
  } else {
    return 'الان';
  }
}

class ReplyAndTime extends StatelessWidget {
  DateTime createdAt;
  void Function()? reply;

  ReplyAndTime({super.key, required this.createdAt, required this.reply});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(
          text: getTimeAgo(createdAt),
          fontSize: 13,
          color: const Color(0xffA0A1AB),
        ),
        8.pw(),
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: reply,
          child: SizedBox(
            width: 30,
            height: 30,
            child: Center(
              child: AppText(
                text: "رد",
                fontSize: 13,
              ),
            ),
          ),
        ),
        // if (replies!.isNotEmpty)
        //   InkWell(
        //     borderRadius: BorderRadius.circular(20),
        //     onTap: () {
        //       _showReplyVisibility = !_showReplyVisibility;
        //       context.read<ShowRepliesCubit>().change(
        //           postIndex: commentIndex!,
        //           visibility: _showReplyVisibility);
        //     },
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(
        //           horizontal: 7, vertical: 5.h),
        //       child: BlocBuilder<ShowRepliesCubit,
        //           ShowRepliesState>(
        //         buildWhen: (previous, current) {
        //           return commentIndex == current.index;
        //         },
        //         builder: (context, state) => AppText(
        //           text: !_showReplyVisibility
        //               ? 'عرض الردور'
        //               : 'اخفاء الردور',
        //           fontSize: 12,
        //           color: Colors.black,
        //         ),
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}

class CommentCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 9, right: 25, left: 15),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 20,
            ),
            9.pw(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 15,
                      width: 100,
                      color: Colors.grey[300],
                    ),
                  ),
                  5.ph(),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 10,
                      width: 200,
                      color: Colors.grey[300],
                    ),
                  ),
                  5.ph(),
                  Container(
                    height: 10,
                    width: 150,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              width: 60,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
