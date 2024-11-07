import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/features/home/domain/entities/home/post_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'post_header.dart';
import 'post_content.dart';
import 'post_media.dart';
import 'post_actions.dart';

class PostWidget extends StatelessWidget {
  final PostEntity post;

  const PostWidget({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(post: post),
          10.ph(),
          PostContent(content: post.content),
          if (post.type != PostType.textOnly) 12.ph(),
          PostMedia(post: post),
          10.ph(),
          PostActions(post: post),
        ],
      ),
    );
  }
}