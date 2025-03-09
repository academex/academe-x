
import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';

import 'package:academe_x/features/home/presentation/widgets/post/post_actions.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_content.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_header.dart';
import 'package:academe_x/features/home/presentation/widgets/post/shimmer/post_actions_shimmer.dart';
import 'package:academe_x/features/home/presentation/widgets/post/shimmer/post_content_shimmer.dart';
import 'package:academe_x/features/home/presentation/widgets/post/shimmer/post_header_shimmer.dart';
import 'package:flutter/material.dart';

import '../post_media.dart';

class PostWidgetShimmer extends StatelessWidget {

  const PostWidgetShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostHeaderShimmer(),
        10.ph(),
        PostContentShimmer(),
        // if (post.type != PostType.textOnly) 12.ph(),
        // PostMedia(post: post),
        10.ph(),
        PostActionsShimmer(),
      ],
    );
  }
}