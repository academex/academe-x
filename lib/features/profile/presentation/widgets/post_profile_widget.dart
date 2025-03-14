
import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';

import 'package:academe_x/features/home/presentation/widgets/post/post_actions.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_content.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_header.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_media.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class PostProfileWidget extends StatelessWidget {
  final PostEntity post;

  const PostProfileWidget({
    required this.post,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(

      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(post: post),
          10.ph(),
          PostContent(post: post,),

          PostMedia(post: post),
          10.ph(),
          PostActions(post: post),
        ],
      ),
    );
  }
}