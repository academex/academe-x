// ignore_for_file: must_be_immutable

import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/features/home/presentation/model/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';
import '../controllers/cubits/comment/favorite_cubit.dart';
import '../controllers/cubits/comment/show_replies_cubit.dart';
import '../controllers/states/comment/show_replyes_state.dart';

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

  CommentCard({
    required this.commenter,
    required this.commentText,
    required this.likes,
    required this.reply,
    // this.showReplies,
    this.commentIndex,
    this.isReply = false,
    this.replies = const [],
    this.isEndReply = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteCubit(false),
      child: Padding(
        padding: EdgeInsets.only(top: isReply?0:9.h,right: 25.w,left: 15.w),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(isReply) Padding(padding: EdgeInsets.only(right: isEndReply?19.w:20.w),child: !isEndReply? const VerticalDivider(color: Colors.black26,width: 0,):null),
              if(isReply) Container(
                width: 15.w,
                height: 20.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(15.r)),
                  border: Border(bottom: const BorderSide(color: Colors.black26),right: isEndReply? const BorderSide(color: Colors.black26):BorderSide.none),
                ),

              ),
              Column(
                children: [
                  CircleAvatar(child: Text(commenter[0]),radius: 20,),
                  if(!isReply)
                  BlocBuilder<ShowRepliesCubit,ShowReplyesState>(
                    buildWhen: (previous, current) => current.index == commentIndex,
                    builder: (context, state) {
                      return Visibility(
                        visible: state.show,
                          child: const Expanded(child: VerticalDivider(color: Colors.black26, )),
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
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    5.ph(),
                    Text(commentText),
                    Row(
                      children: [
                        AppText(
                          text: 'قبل ساعتين',
                          fontSize: 13.sp,
                          color: const Color(0xffA0A1AB),
                        ),
                        8.pw(),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: reply,
                          child: SizedBox(
                            width: 30.w,
                            height: 30.h,
                            child: Center(
                              child: AppText(
                                text: "رد",
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ),
                        if(replies!.isNotEmpty)
                        InkWell(
                          borderRadius: BorderRadius.circular(20.r),
                          onTap: () {
                            _showReplyVisibility = !_showReplyVisibility;
                            context.read<ShowRepliesCubit>().change(postIndex: commentIndex!,visibility: _showReplyVisibility);
                          },
                          child:Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w,vertical: 5.h),
                            child: BlocBuilder<ShowRepliesCubit,ShowReplyesState>(
                              buildWhen: (previous, current) {
                                return commentIndex==current.index;
                              },
                              builder:(context, state) =>  AppText(
                                text: !_showReplyVisibility? 'عرض الردور':'اخفاء الردور',
                                fontSize: 12.sp,
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
              BlocBuilder<FavoriteCubit,bool>(
                
                builder:(context, state) =>  InkWell(
                  borderRadius:  BorderRadius.circular(10.r),
                  onTap: () {
                    if (!state){
                      likes++;
                    }else{
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
                            height: 17.h,
                            width: 19.w,
                          ),
                        if (state)
                          Image.asset(
                            'assets/icons/favourite_selected.png',
                            height: 17.h,
                            width: 19.w,
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
