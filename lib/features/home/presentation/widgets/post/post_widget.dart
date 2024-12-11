
import 'package:academe_x/core/constants/app_navigation.dart';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';

import 'package:academe_x/features/home/presentation/widgets/post/post_actions.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_content.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_header.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


class PostWidget extends StatelessWidget {
  final PostEntity post;
  final bool fromHome;

  const PostWidget({
    required this.post,
     this.fromHome=false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>fromHome? context.go('/post/${post.id}') : null,
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(post: post),
          10.ph(),
          PostContent(content: post.content!),
          // if (post.type != PostType.textOnly) 12.ph(),
          PostMedia(post: post),
          10.ph(),
          PostActions(post: post),
        ],
      ),
    );
  }
}