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
    return Column(
      children: [
        BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {
            final updatedPost = state.posts.firstWhere((p) => p.id == post.id);
            return ReactionBar(post: updatedPost, onTap: () => _showReactionsSheet(context));
          },
        ),
        8.ph(),
        PostActionButtons(post: post,),
      ],
    );
  }

  void _showReactionsSheet(BuildContext context) async {


    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => ReactionsBottomSheet(
        reactions: post.reactions!.items,
        postId: post.id!,
      ),
    );

    await context.read<PostsCubit>().getUsersByReactionType(
      reactType: post.reactions!.items[0].type,
      postId: post.id!,
    );
  }
}
//
// class PostActions extends StatelessWidget {
//   final PostEntity post;
//
//   const PostActions({required this.post, super.key});
//
//   void _handleReaction(String reactType, BuildContext context) async {
//     try {
//       await context.read<PostsCubit>().reactToPost(
//         context: context,
//         reactType: reactType.toUpperCase(),
//         postId: post.id!,
//       );
//     } catch (e) {
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update reaction')),
//       );
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         BlocBuilder<PostsCubit, PostsState>(
//     builder: (context, state) {
//       // Find the updated post from state
//       final updatedPost = state.posts.firstWhere(
//             (p) => p.id == post.id,
//       );
//
//       return _buildReactionsBar(updatedPost,context);
//     },
//     ),
//         8.ph(),
//         SizedBox(
//           // width: 326,
//           height: 50,
//           // child:
//           child: Row(
//             children: [
//               FbReactionBox(post: post,onReact:(reactType) => _handleReaction(reactType, context),),
//               10.pw(),
//               _buildCommentButton(context),
//               10.pw(),
//               _buildShareButton(context),
//               const Spacer(),
//               _buildSaveButton(context,post.id!),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildReactionsBar(PostEntity currentPost,BuildContext context) {
//     if (currentPost.reactions == null || currentPost.reactions!.items.isEmpty) {
//       return const SizedBox.shrink(); // Return empty widget if no reactions
//     }
//     return GestureDetector(
//       onTap: () async{
//         return _showReactionsSheet(context);
//       },
//       child: Row(
//         children: [
//           if (currentPost.reactions != null && currentPost.reactions!.items.isNotEmpty)
//             SizedBox(
//               height: 24,
//               width: currentPost.reactions!.items.length > 1 ? currentPost.reactions!.items.length > 2 ?56 :40 : 23,
//               child: Stack(
//                 children: List.generate(
//                   currentPost.reactions!.items.length > 3
//                       ? 3
//                       : currentPost.reactions!.items.length,
//                       (index) => Positioned(
//                     right: index * 15,
//                     child: _buildReactionAvatar(currentPost.reactions!.items[index]),
//                   ),
//                 ).reversed.toList(),
//               ),
//             ),
//           7.pw(),
//           Expanded(
//             child:Text.rich(
//               TextSpan(
//                 children: [
//                   if (currentPost.reactions!.items.isNotEmpty)
//                     TextSpan(
//                       text: _getReactionsText(currentPost),
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 13,
//                       ),
//                     ),
//                 ],
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _buildCommentButton(BuildContext context) {
//     return ActionButton(
//       iconPath: 'assets/icons/comment.png',
//       count: post.commentsCount.toString(),
//       onTap: () => CommentsList(postId: post.id, context: context),
//     );
//   }
//
//   Widget _buildShareButton(BuildContext context) {
//     return ActionButton(
//       iconPath: 'assets/icons/share.png',
//       count: '0',
//       onTap: () {},
//     );
//   }
//
//   Widget _buildSaveButton(BuildContext context,int postId) {
//
//     return IconButton(
//       icon: Image.asset(
//       post.isSaved!
//             ? 'assets/icons/bookMark_selected.png'
//             :'assets/icons/Bookmark.png',
//         height: 17,
//         width: 19,
//       ),
//       padding: EdgeInsets.zero,
//       onPressed: () {
//
//         context.read<PostsCubit>().savePost(postId: postId,isSaved:post.isSaved!);
//       },
//     );
//   }
//
//   Widget _buildReactionAvatar(ReactionItemEntity reaction) {
//
//     return SizedBox(
//       height: 24,
//       width: 24,
//
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Center(
//               child: Container(
//                 margin: const EdgeInsets.all(2),
//                 child: SvgPicture.asset(_getReactionsIcon(reaction.type)),
//               ),
//             ),
//             ),
//     ]
//           ),
//
//       );
//   }
//
//
//
//
//
//   String _getReactionsText(PostEntity post) {
//     if (post.reactions == null || post.reactions!.items.isEmpty) return '';
//
//     if (post.reactions!.items.length == 1) {
//       return post.reactions!.items[0].user.username;
//     }
//
//     if (post.reactions!.items.length == 2) {
//       return '${post.reactions!.items[0].user.username} و ${post.reactions!.items[1].user.username}';
//     }
//
//     return '${post.reactions!.items[0].user.username} و ${post.reactions!.count - 1} آخرين';
//   }
//
//   void _showReactionsSheet(BuildContext ctx) async{
//     await  ctx.read<PostsCubit>().getUsersByReactionType(reactType: post.reactions!.items[0].type,postId: post.id!);
//
//     showModalBottomSheet(
//       context: ctx,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) =>
//           _ReactionsBottomSheet(reactions: post.reactions!.items ?? [],postId: post.id!,ctx: ctx,),
//     );
//   }
// }
//
// String _getReactionsIcon(String type) {
//   switch (type.toUpperCase()){
//     case 'QUESTION':
//       return 'assets/icons/reactions/question.svg';
//     case 'HEART':
//       return 'assets/icons/reactions/heart.svg';
//     case 'INSIGHTFUL':
//       return 'assets/icons/reactions/insightful.svg';
//     case 'FUNNY':
//       return 'assets/icons/reactions/funny.svg';
//     case 'CELEBRATE':
//       return 'assets/icons/reactions/celebrate.svg';
//     default:
//       return '';
//
//
//   }
// }
//
// class _ReactionsBottomSheet extends StatelessWidget {
//   final List<ReactionItemEntity> reactions;
//   final int postId;
//   final BuildContext ctx;
//
//
//   const _ReactionsBottomSheet({
//     required this.reactions,
//     required this.postId,
//     required this.ctx,
//     Key? key,
//   }) : super(key: key);
//
//   Map<String, List<ReactionItemEntity>> _groupReactionsByType() {
//     final groupedReactions = <String, List<ReactionItemEntity>>{};
//
//     for (var reaction in reactions) {
//       if (!groupedReactions.containsKey(reaction.type)) {
//         groupedReactions[reaction.type] = [];
//       }
//       groupedReactions[reaction.type]!.add(reaction);
//     }
//
//     return groupedReactions;
//   }
//
//   Widget _buildReactionItem(String type, int count,PostsState state) {
//     final isSelected= type== state.selectedType!;
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration:isSelected? BoxDecoration(
//         color:Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: const Color(0xFFE8E8E8)),
//       ):null,
//       child: Row(
//         // mainAxisSize: MainAxisSize.min,
//         children: [
//           SvgPicture.asset(
//             width: 22,
//             height: 22,
//             _getReactionsIcon(type),
//             // height: 16,
//             // width: 16,
//           ),
//           8.pw(),
//           AppText(
//             text: count.toString(),
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final groupedReactions = _groupReactionsByType();
//
//
//     return BlocBuilder<PostsCubit,PostsState>(
//       builder: (context, state) => Container(
//         height: 400,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 AppText(
//                   text: 'التفاعلات(${reactions.length})',
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ],
//             ),
//             20.ph(),
//             Container(
//               // width: 327.32,
//               height: 48,
//               decoration: ShapeDecoration(
//                 color: const Color(0xFFF9F9F9),
//                 shape: RoundedRectangleBorder(
//                   side: const BorderSide(
//                     width: 0.80,
//                     strokeAlign: BorderSide.strokeAlignCenter,
//                     color: Color(0x38E1E1E1),
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: ListView.separated(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: groupedReactions.length,
//                 separatorBuilder: (context, index) => 8.pw(),
//                 itemBuilder: (context, index) {
//                   final type = groupedReactions.keys.elementAt(index);
//
//                   final count = groupedReactions[type]!.length;
//                   return GestureDetector(
//                     onTap: () async{
//                       await   ctx.read<PostsCubit>().getUsersByReactionType(reactType: type, postId: postId);
//                       // Here you can handle the tap to show users for this reaction type
//                       // final usersForThisReaction = groupedReactions[type]!;
//                       // TODO: Show users list or make API call
//                     },
//                     child: _buildReactionItem(type, count,state),
//                   );
//                 },
//               ),
//             ),
//             20.ph(),
//             Expanded(
//               child:  context.read<PostsCubit>().state.reactionStatus == ReactionStatus.loading?
//               const ReactionsListShimmer(): ListView.builder(
//                 padding: EdgeInsets.zero,
//                 itemCount: context.read<PostsCubit>().state.reactionItems!.length,
//                 itemBuilder: (context, index) {
//                   final reaction = context.read<PostsCubit>().state.reactionItems![index];
//                   return ListTile(
//                     leading: const CircleAvatar(
//                       child: Icon(Icons.person),
//                     ),
//                     title: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         AppText(
//                           text: '${reaction.user.firstName} ${reaction.user.lastName}',
//                           fontSize: 12,
//                         ),
//                         AppText(
//                           text: reaction.user.username,
//                           fontSize: 12,
//                         ),
//                       ],
//                     ),
//                     trailing: SvgPicture.asset(
//                       _getReactionsIcon(reaction.type),
//                       height: 20,
//                       width: 20,
//                     ),
//                   );
//                 },
//               ),
//             )
//
//           ],
//         ),
//       ),
//       buildWhen: (previous, current) => previous!=current,
//     );
//   }
//
//   String _getReactionsIcon(String type) {
//     switch (type.toUpperCase()) {
//       case 'HEART':
//         return 'assets/icons/reactions/heart.svg';
//       case 'FUNNY':
//         return 'assets/icons/reactions/funny.svg';
//     // Add other reaction types here
//       default:
//         return 'assets/icons/reactions/heart.svg';
//     }
//   }
// }
