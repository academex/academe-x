import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';

class CommentCard extends StatelessWidget {
  final String commenter;
  final String commentText;
  final int likes;
  final VoidCallback reply;

  const CommentCard({
    required this.commenter,
    required this.commentText,
    required this.likes,
    required this.reply,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9.h,horizontal: 27.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    AppText(text: 'قبل ساعتين', fontSize: 13.sp, color: const Color(0xffA0A1AB),),
                    8.pw(),
                    GestureDetector(
                      onTap:reply,
                      child: AppText(text: "رد",fontSize: 13.sp,)),
                  ],
                ),
              ],
            ),
          ),
          _buildLikeButton(likes),
        ],
      ),
    );
  }

  Widget _buildLikeButton(int likeCount) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/favourite.png',
          height: 17.h,
          width: 19.w,
        ),
        2.pw(),
        Text(likeCount.toString()),
      ],
    );
  }
}
