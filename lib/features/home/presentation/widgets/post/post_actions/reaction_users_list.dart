import 'dart:async';

import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/presentation/widgets/post/shimmer/reactions_list_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/utils/reaction_type_utils.dart';
import '../../../../domain/entities/post/reaction_item_entity.dart';
import '../../../controllers/cubits/post/posts_cubit.dart';
import '../../../controllers/states/post/post_state.dart';

// class ReactionUsersList extends StatelessWidget {
//   final List<ReactionItemEntity> reactions;
//
//   const ReactionUsersList({
//     required this.reactions,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(child: ListView.builder(
//       padding: EdgeInsets.zero,
//       itemCount: reactions.length,
//       itemBuilder: (context, index) {
//         final reaction = reactions[index];
//         return ListTile(
//           leading: const CircleAvatar(
//             child: Icon(Icons.person),
//           ),
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AppText(
//                 text: '${reaction.user.firstName} ${reaction.user.lastName}',
//                 fontSize: 12,
//               ),
//               AppText(
//                 text: reaction.user.username,
//                 fontSize: 12,
//               ),
//             ],
//           ),
//           trailing: SvgPicture.asset(
//             ReactionTypeUtils.getIconPath(reaction.type),
//             height: 20,
//             width: 20,
//           ),
//         );
//       },
//     ));
//   }
// }

class ReactionUsersList extends StatefulWidget {
  final int postId;
   const ReactionUsersList({super.key, required this.postId,required this.state});
  final PostsState state;

  @override
  State<ReactionUsersList> createState() => _ReactionsUsersListState();
}

class _ReactionsUsersListState extends State<ReactionUsersList> {
  final _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (_isBottom) {
        context.read<PostsCubit>().getReactions(reactType: context.read<PostsCubit>().state.selectedType!, postId: widget.postId,fromScroll: true);
      }
    });
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(child: ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      itemCount: widget.state.reactionItems!.length,
      itemBuilder: (context, index) {

        switch (widget.state.reactionStatus) {
          case ReactionStatus.initial:
          case ReactionStatus.loading:
            if (widget.state.reactionItems!.isEmpty) {
              return  const ReactionShimmer();
            }
            break;

          case ReactionStatus.failure:
            if (widget.state.posts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.state.errorMessage ?? 'Failed to fetch reactions'),
                    16.ph(),
                    ElevatedButton(
                      onPressed: () async{
                        // return  await context.read<PostsCubit>().loadPosts();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            break;

          case ReactionStatus.success:
            if (widget.state.reactionItems!.isEmpty) {
              return const  Center(child: Text('No reactions found'),
              );
            }
            break;
        }

        if (index >= widget.state.reactionItems!.length) {

          if (widget.state.hasReactionsReachedMax) {
            return null;
          }
          return const ReactionShimmer();
        }

        final reaction = widget.state.reactionItems![index];
        return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: '${reaction.user.firstName} ${reaction.user.lastName}',
                fontSize: 12,
              ),
              AppText(
                text: reaction.user.username,
                fontSize: 12,
              ),
            ],
          ),
          trailing: SvgPicture.asset(
            ReactionTypeUtils.getIconPath(reaction.type),
            height: 20,
            width: 20,
          ),
        );
      },
    ));
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          switch (state.reactionStatus) {
            case ReactionStatus.initial:
            case ReactionStatus.loading:
              if (state.reactionItems!.isEmpty) {
                return  const SliverFillRemaining(
                    child: ReactionShimmer(),
                  //
                );
              }
              break;

            case ReactionStatus.failure:
              if (state.posts.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.errorMessage ?? 'Failed to fetch reactions'),
                        16.ph(),
                        ElevatedButton(
                          onPressed: () async{
                            // return  await context.read<PostsCubit>().loadPosts();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }
              break;

            case ReactionStatus.success:
              if (state.reactionItems!.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text('No reactions found')),
                );
              }
              break;
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                if (index >= state.reactionItems!.length) {

                  if (state.hasReactionsReachedMax) {
                    return null;
                  }
                  return const ReactionShimmer();
                }

                final reaction = state.reactionItems![index];
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: '${reaction.user.firstName} ${reaction.user.lastName}',
                            fontSize: 12,
                          ),
                          AppText(
                            text: reaction.user.username,
                            fontSize: 12,
                          ),
                        ],
                      ),
                      trailing: SvgPicture.asset(
                        ReactionTypeUtils.getIconPath(reaction.type),
                        height: 20,
                        width: 20,
                      ),
                    );
                return Column(
                  children: [
                    20.ph(),
                    // PostWidget(post: post),
                    if (index < state.reactionItems!.length - 1) ...[
                      16.ph(),
                      Divider(
                        color: Colors.grey.shade300,
                        endIndent: 25,
                        indent: 25,
                      ),
                      16.ph(),
                    ],
                  ],
                );},
              childCount: state.hasReactionsReachedMax
                  ? state.reactionItems!.length
                  : state.reactionItems!.length + 1,
            ),
          );
        },

      ),
    );
  }
}
