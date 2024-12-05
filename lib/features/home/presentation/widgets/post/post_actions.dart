import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/domain/entities/post/reaction_item_entity.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_actions/post_action_buttons.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_actions/reaction_bar.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_actions/reactions_bottom_sheet.dart';
import 'package:academe_x/features/home/presentation/widgets/post/shimmer/reactions_list_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:academe_x/lib.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
// import 'package:reaction_button/reaction_button.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';

import '../../../domain/entities/home/reaction_user.dart';
import '../../controllers/cubits/post/action_post_cubit.dart';
import '../../controllers/cubits/post/posts_cubit.dart';
import '../../controllers/states/action_post_states.dart';
import '../../controllers/states/post/post_state.dart';
import '../action_button.dart';
import '../comment/comments_list.dart';
import '../lib/flutter_reaction_button.dart';
import '../test_build_reactions/fb_reaction_box.dart';

class PostActions extends StatelessWidget {
  final PostEntity post;

  const PostActions({required this.post, super.key});

  Future<void> _handleReaction(String reactType, BuildContext context) async {
    try {
      await context.read<PostsCubit>().reactToPost(
        context: context,
        reactType: reactType.toUpperCase(),
        postId: post.id!,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update reaction')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit,PostsState>(
      buildWhen: (previous, current) => previous!=current,
      builder: (context, state) {
                final updatedPost = state.posts.firstWhere((p) => p.id == post.id);
        return   Column(
          children: [
            ReactionBar(post: updatedPost, onTap: () => _showReactionsSheet(context,state)),
            8.ph(),
            PostActionButtons(post: post,),
          ],
        );
      },
    );
  }

  void _showReactionsSheet(BuildContext context,PostsState state) async {





    if (!context.mounted) return;
     showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => ReactionsBottomSheet(
        numberOfReactions: post.reactions!.count,
        postId: post.id!,
      ),
    );

    if (!context.mounted) return;
    await context.read<PostsCubit>().getReactions(
      reactType: post.reactions!.items[0].type,
      postId: post.id!,
    );


  }
}

