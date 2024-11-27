import 'package:academe_x/lib.dart';

import 'package:flutter/material.dart';


class PostHeader extends StatelessWidget {
  final PostEntityS post;

  const PostHeader({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(post.userAvatar),
          radius: 20   ,
        ),
        10.pw(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: post.username,
                color: Color(0xFF0F172A),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              4.ph(),
              AppText(
                text: post.timeAgo,
                fontSize: 12  ,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w400,
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