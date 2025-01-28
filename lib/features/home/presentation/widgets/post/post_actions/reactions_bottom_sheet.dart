import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_actions/reaction_type_list.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_actions/reaction_users_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/post/reaction_item_entity.dart';
import '../../../controllers/cubits/post/posts_cubit.dart';
import '../../../controllers/states/post/post_state.dart';
import '../shimmer/reactions_list_shimmer.dart';

class ReactionsBottomSheet extends StatelessWidget {
  final int numberOfReactions;
  final int postId;

  const ReactionsBottomSheet({
    required this.numberOfReactions,
    required this.postId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return state.reactionStatus == ReactionStatus.loading?  const ReactionShimmer(): Container(
          // height: 800,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(context),
              20.ph(),
              ReactionTypesList(
                reactions: state.statisticsEntity!.statistics,
                postId: postId,
                selectedType: state.selectedType,
              ),
              20.ph(),
              _buildReactionsList(context,state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        AppText(
          text: 'التفاعلات($numberOfReactions)',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildReactionsList(BuildContext context,PostsState state) {
    return ReactionUsersList(postId: postId,state: state,);
  }
}