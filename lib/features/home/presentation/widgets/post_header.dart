import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/core/utils/logger.dart';
import 'package:academe_x/features/home/domain/entities/home/post_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';

class PostHeader extends StatelessWidget {
  final PostEntity post;

  const PostHeader({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(post.userAvatar),
          radius: 20.w,
        ),
        10.pw(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: post.username,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              4.ph(),
              AppText(
                text: post.timeAgo,
                fontSize: 12.sp,
                color: const Color(0xff64748B),
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {
    //         => _showPostOptions(context),
    },
          icon: const Icon(Icons.more_horiz),
        )
      ],
    );
  }
}