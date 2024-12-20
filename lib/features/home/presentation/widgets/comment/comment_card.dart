// ignore_for_file: must_be_immutable

import 'package:academe_x/lib.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CommentCard extends StatelessWidget {
  final String commenter;
  final String commentText;
  int likes;
  final int? commentIndex;
  final bool isReply;
  final void Function() reply;
  final List<Comment>? replies;
  bool _showReplyVisibility = false;
  bool isEndReply;
  bool useNewDesign = true;
  DateTime createdAt;

  CommentCard({
    required this.commenter,
    required this.commentText,
    required this.likes,
    required this.reply,
    required this.createdAt,
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
                    child: Text(commenter[0]),
                    radius: 20,
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
                      text: commenter,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    5.ph(),
                    Text(commentText),
                    Row(
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
                        if (replies!.isNotEmpty)
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              _showReplyVisibility = !_showReplyVisibility;
                              context.read<ShowRepliesCubit>().change(
                                  postIndex: commentIndex!,
                                  visibility: _showReplyVisibility);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 5.h),
                              child: BlocBuilder<ShowRepliesCubit,
                                  ShowRepliesState>(
                                buildWhen: (previous, current) {
                                  return commentIndex == current.index;
                                },
                                builder: (context, state) => AppText(
                                  text: !_showReplyVisibility
                                      ? 'عرض الردور'
                                      : 'اخفاء الردور',
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    9.ph(),
                  ],
                ),
              ),
              BlocBuilder<FavoriteCubit, bool>(
                builder: (context, state) => InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if (!state) {
                      likes++;
                    } else {
                      likes--;
                    }
                    context.read<FavoriteCubit>().change();
                  },
                  child: SizedBox(
                    height: 40,
                    width: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!(state as bool))
                          Image.asset(
                            'assets/icons/favourite.png',
                            height: 17,
                            width: 19,
                          ),
                        if (state)
                          Image.asset(
                            'assets/icons/favourite_selected.png',
                            height: 17,
                            width: 19,
                          ),
                        2.pw(),
                        Text(likes.toString()),
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

  // Widget _buildLikeButton(
  //     {required int likeCount, required BuildContext context}) {
  //   return InkWell(
  //     onTap: () {
  //       context.read<FavoriteCubit>().change();
  //     },
  //     child: BlocBuilder(
  //       builder: (context, state) => Row(
  //         children: [
  //           if (!(state as bool))
  //             Image.asset(
  //               'assets/icons/favourite.png',
  //               height: 17.h,
  //               width: 19.w,
  //             ),
  //           if (state)
  //             Image.asset(
  //               'assets/icons/favourite_selected.png',
  //               height: 17.h,
  //               width: 19.w,
  //             ),
  //           2.pw(),
  //           Text(likeCount.toString()),
  //         ],
  //       ),
  //     ),
  //   );
  // }
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
                  Container(
                    height: 15,
                    width: 100,
                    color: Colors.grey[300],
                  ),
                  5.ph(),
                  Container(
                    height: 10,
                    width: 200,
                    color: Colors.grey[300],
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
            BlocBuilder<FavoriteCubit, bool>(
              builder: (context, state) => SizedBox(
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
            ),
          ],
        ),
      ),
    );
  }
}
