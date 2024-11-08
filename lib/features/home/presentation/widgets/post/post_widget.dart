import 'package:academe_x/lib.dart';

import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final PostEntity post;

  const PostWidget({
    required this.post,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}