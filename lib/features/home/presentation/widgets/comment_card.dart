import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/features/home/presentaion/controllers/cubits/comment/favorite_cubit.dart';
import 'package:academe_x/features/home/presentaion/controllers/cubits/comment/show_replies_cubit.dart';
import 'package:academe_x/features/home/presentaion/controllers/states/comment/show_replyes_state.dart';
import 'package:academe_x/features/home/presentaion/widgets/comments_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';

class CommentCard extends StatelessWidget {
  final String commenter;
  final String commentText;
  int likes;
  final int? commentIndex;
  final bool isReply;
  final void Function() reply;
  final void Function()? showReplies;

  CommentCard({
    required this.commenter,
    required this.commentText,
    required this.likes,
    required this.reply,
    this.showReplies,
    this.commentIndex,
    this.isReply = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteCubit(false),
      child: Padding(
        padding: EdgeInsets.only(top: isReply?0:9.h,right: !isReply? 25.w : 50.w,left: 15.w),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(isReply) const VerticalDivider(color: Colors.black26,width: 1, ),
              CircleAvatar(child: Text(commenter[0])), // Placeholder avatar
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
                        if(showReplies != null)
                        InkWell(
                          borderRadius: BorderRadius.circular(20.r),
                          onTap: showReplies,
                          child:Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w,vertical: 5.h),
                            child: BlocBuilder<ShowRepliesCubit,ShowReplyesState>(
                              builder:(context, state) =>  AppText(
                                text: !state.show && state.index == commentIndex? 'عرض الردور':'اخفاء الردور',
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

  Widget _buildLikeButton(
      {required int likeCount, required BuildContext context}) {
    return InkWell(
      onTap: () {
        context.read<FavoriteCubit>().change();
      },
      child: BlocBuilder(
        builder: (context, state) => Row(
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
            Text(likeCount.toString()),
          ],
        ),
      ),
    );
  }
}
