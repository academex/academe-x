
import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';

import 'package:academe_x/features/home/presentation/widgets/post/post_actions.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_content.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_header.dart';
import 'package:flutter/material.dart';

import '../post_media.dart';

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
        PostContent(content: post.content!),
        // if (post.type != PostType.textOnly) 12.ph(),
        // PostMedia(post: post),
        10.ph(),
        PostActions(post: post),
      ],
    );
  }
}