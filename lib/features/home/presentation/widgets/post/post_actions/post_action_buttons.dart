import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_actions/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/post/post_entity.dart';
import '../../../controllers/cubits/post/posts_cubit.dart';
import '../../action_button.dart';
import '../../comment/comments_list.dart';
import '../../test_build_reactions/fb_reaction_box.dart';

class PostActionButtons extends StatelessWidget {
  final PostEntity post;

  const PostActionButtons({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          FbReactionBox(
            post: post,
            onReact: (reactType) => _handleReaction(reactType, context),
          ),
          10.pw(),
          ActionButton(
            iconPath: 'assets/icons/comment.png',
            count: post.commentsCount.toString(),
            onTap: () => CommentsList(postId: post.id, context: context),
          ),
          10.pw(),
          ActionButton(
            iconPath: 'assets/icons/share.png',
            count: '0',
            onTap: () {},
          ),
          const Spacer(),
          SaveButton(
            postId: post.id!,
            isSaved: post.isSaved??false,
            onSave: () => context.read<PostsCubit>().savePost(
              postId: post.id!,
              isSaved: post.isSaved!,
            ),
          ),
        ],
      ),
    );
  }
  void _handleReaction(String reactType, BuildContext context) async {
    try {
      await context.read<PostsCubit>().reactToPost(
        context: context,
        reactType: reactType.toUpperCase(),
        postId: post.id!,
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update reaction')),
      );
    }
  }
}
