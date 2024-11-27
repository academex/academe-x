import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:academe_x/lib.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
// import 'package:reaction_button/reaction_button.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';

import '../../controllers/cubits/post/action_post_cubit.dart';
import '../../controllers/states/action_post_states.dart';
import '../lib/flutter_reaction_button.dart';
import '../test_build_reactions/fb_reaction_box.dart';

class PostActions extends StatelessWidget {
  final PostEntity post;

  const PostActions({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActionPostCubit(),
      child: Column(
        children: [
          // _buildReactionsBar(),
          8.ph(),
          SizedBox(
            // width: 326,
            height: 50,
            // child:
            child: Row(
              children: [
              FbReactionBox(),
                10.pw(),
                // _buildCommentButton(context),
                // 10.pw(),
                // _buildShareButton(context),
                const Spacer(),
                _buildSaveButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildReactionsBar() {
  //   return BlocBuilder<ActionPostCubit, ActionPostState>(
  //     builder: (context, state) {
  //       if (post.likesCount == 0 && post.commentsCount == 0)
  //         return const SizedBox();
  //
  //       return Row(
  //         children: [
  //           // Stacked Avatars with Reactions
  //           if (post.reactionUsers != null && post.reactionUsers!.isNotEmpty)
  //             SizedBox(
  //               height: 24,
  //               width: post.reactionUsers!.length > 1 ? 53 : 24,
  //               child: Stack(
  //                 children: List.generate(
  //                   post.reactionUsers!.length > 3
  //                       ? 3
  //                       : post.reactionUsers!.length,
  //                   (index) => Positioned(
  //                     right: index * 15, // For RTL support
  //                     child: _buildReactionAvatar(post.reactionUsers![index]),
  //                   ),
  //                 ).reversed.toList(),
  //               ),
  //             ),
  //           7.pw(),
  //           Expanded(
  //             child: GestureDetector(
  //               onTap: () => _showReactionsSheet(context),
  //               child: Text.rich(
  //                 TextSpan(
  //                   children: [
  //                     if (post.reactionUsers != null &&
  //                         post.reactionUsers!.isNotEmpty)
  //                       TextSpan(
  //                         text: _getReactionsText(),
  //                         style: TextStyle(
  //                           color: Colors.grey[600],
  //                           fontSize: 13,
  //                         ),
  //                       ),
  //                   ],
  //                 ),
  //                 maxLines: 1,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _buildReactionsButton() {
    return SizedBox(
      width: 100,
      child: FbReactionBox(
        // onReactionSelected: (reaction) {
        //   // context.read<ActionPostCubit>().selectReaction(reaction);
        // },
      ),
    );
  }
  // Widget _buildReactionsButton() {
  //   return BlocBuilder<ActionPostCubit, ActionPostState>(
  //     builder: (context, state) {
  //       return Container(
  //         width: 100, // Match FbReactionBox button width
  //         child: Directionality(
  //           textDirection: TextDirection.ltr,
  //           child: FbReactionBox(
  //             onReactionSelected: (reaction) {
  //               // Handle reaction selection
  //               // context.read<ActionPostCubit>().selectReaction(reaction);
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _showReactionPicker(BuildContext context, TapDownDetails details) {
  //   final RenderBox button = context.findRenderObject() as RenderBox;
  //   final Offset position = button.localToGlobal(Offset.zero);
  //   showMenu(
  //     context: context,
  //     position: RelativeRect.fromLTRB(
  //       position.dx,
  //       position.dy - 60,
  //       position.dx + button.size.width,
  //       position.dy,
  //     ),
  //     elevation: 0,
  //     color: Colors.transparent,
  //     items: [
  //       PopupMenuItem(
  //         padding: EdgeInsets.zero,
  //         child: _ReactionPickerWidget(
  //           onReactionSelected: (reaction) {
  //             context.read<ActionPostCubit>().selectReaction(reaction);
  //             Navigator.pop(context);
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildCommentButton(BuildContext context) {
  //   return ActionButton(
  //     iconPath: 'assets/icons/comment.png',
  //     count: post.commentsCount.toString(),
  //     onTap: () => CommentsList(postId: post.userId, context: context),
  //   );
  // }

//
//
//   Widget _buildShareButton(BuildContext context) {
//     return ActionButton(
//       iconPath: 'assets/icons/share.png',
//       count: post.sharesCount.toString(),
//       onTap: () {},
//     );
//   }

  Widget _buildSaveButton() {
    return BlocBuilder<ActionPostCubit, ActionPostState>(
      builder: (context, state) {
        return IconButton(
          icon: Image.asset(
            state.isSaved
                ? 'assets/icons/bookMark_selected.png'
                : 'assets/icons/Bookmark.png',
            height: 17,
            width: 19,
          ),
          padding: EdgeInsets.zero,
          onPressed: () {
            context.read<ActionPostCubit>().performSaveAction(!state.isSaved);
          },
        );
      },
    );
  }

  // Widget _buildReactionAvatar(ReactionUser user) {
  //   return Container(
  //     height: 24,
  //     width: 24,
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       border: Border.all(color: Colors.white, width: 2),
  //     ),
  //     child: Stack(
  //       clipBehavior: Clip.none,
  //       children: [
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(12),
  //           child: Image.network(
  //             user.avatarUrl,
  //             fit: BoxFit.cover,
  //             height: 24,
  //             width: 24,
  //           ),
  //         ),
  //         // Small reaction emoji
  //         Positioned(
  //           right: -2,
  //           bottom: -2,
  //           child: Container(
  //             height: 12,
  //             width: 12,
  //             decoration: const BoxDecoration(
  //               color: Colors.white,
  //               shape: BoxShape.circle,
  //             ),
  //             child: Center(
  //               child: Image.asset(
  //                 user.reactionType.assetPath,
  //                 height: 10,
  //                 width: 10,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // String _getReactionsText() {
  //   if (post.reactionUsers == null || post.reactionUsers!.isEmpty) return '';
  //
  //   if (post.reactionUsers!.length == 1) {
  //     return post.reactionUsers![0].name;
  //   }
  //
  //   if (post.reactionUsers!.length == 2) {
  //     return '${post.reactionUsers![0].name} و ${post.reactionUsers![1].name}';
  //   }
  //
  //   return '${post.reactionUsers![0].name} و ${post.likesCount - 1} آخرين';
  // }

  // void _showReactionsSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (context) =>
  //         _ReactionsBottomSheet(reactions: post.reactionUsers ?? []),
  //   );
  // }
}

// class _ReactionPickerWidget extends StatefulWidget {
//   _ReactionPickerWidget({super.key, required this.onReactionSelected});
//
//   final Function(ReactionType) onReactionSelected;
//   double height = 40;
//   double width = 40;
//
//   late OverlayEntry overlayEntry;
//   @override
//   State<_ReactionPickerWidget> createState() => _ReactionPickerWidgetState();
// }
//
// class _ReactionPickerWidgetState extends State<_ReactionPickerWidget> {
//   Map<ReactionType, double> reactionIconSizes = {
//     for (final type in ReactionType.values) type: 35.0,
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.black, strokeAlign: 0.74),
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(9.12),
//             topLeft: Radius.circular(9.12),
//             topRight: Radius.circular(9.12),
//           )),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: ReactionType.values.map((type) {
//           return InkWell(
//             onTap: () {
//               widget.onReactionSelected(type);
//               widget.overlayEntry.remove();
//             },
//             onTapDown: (details) {
//               setState(() {
//                 reactionIconSizes[type] = 55.0;
//               });
//               final RenderBox button = context.findRenderObject() as RenderBox;
//               final Offset position = button.localToGlobal(Offset.zero);
//               widget.overlayEntry = OverlayEntry(
//                 builder: (context) {
//                   return Positioned(
//                     top: position.dy - 30, // Position above the icon
//                     left: details.globalPosition.dx - 20,
//                     child: Material(
//                       color: Colors.transparent,
//                       child: Container(
//                         width: 38.90,
//                         height: 22.54,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 5.45, vertical: 3.27),
//                         decoration: ShapeDecoration(
//                           color: type.reactionColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(7.78),
//                           ),
//                         ),
//                         child: Center(
//                           child: AppText(
//                             text: type.reactionText,
//                             color: type.reactionText != 'تصفيق'
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontSize: 8.72,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//               AppLogger.success(type.index.toString());
//
//               // Show the overlay
//               Overlay.of(context).insert(widget.overlayEntry);
//             },
//             child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 4),
//                 child: SvgPicture.asset(
//                   fit: BoxFit.contain,
//                   width: reactionIconSizes[type]!,
//                   height: reactionIconSizes[type]!,
//                   type.assetPath,
//                 )),
//             //   child: Image.asset(
//             //   fit: BoxFit.contain,
//             //   width:reactionIconSizes[type]!,
//             //   height:reactionIconSizes[type]!,
//             //   type.assetPath,
//             // ),),
//             onTapCancel: () {
//               widget.overlayEntry.remove();
//               setState(() {
//                 reactionIconSizes.updateAll((_, size) => 35.0);
//               });
//             },
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// class SelectedReactionButton extends StatelessWidget {
//   final ReactionType reaction;
//   final VoidCallback onTap;
//
//   const SelectedReactionButton({
//     required this.reaction,
//     required this.onTap,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           color: _getReactionColor(reaction),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(reaction.assetPath, width: 16, height: 16),
//             4.pw(),
//             Text(
//               _getReactionText(reaction),
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Color _getReactionColor(ReactionType type) {
//     switch (type) {
//       case ReactionType.heart:
//         return const Color(0xFFFF597B); // Pink
//       case ReactionType.celebrate:
//         return const Color(0xFF37B4AA); // Teal
//       case ReactionType.question:
//         return const Color(0xFF6C5CE7); // Purple
//       case ReactionType.insightful:
//         return const Color(0xFFFF8F3C); // Orange
//       case ReactionType.like:
//         return const Color(0xFF2196F3); // Blue
//     }
//   }
//
//   String _getReactionText(ReactionType type) {
//     switch (type) {
//       case ReactionType.heart:
//         return 'قلب';
//       case ReactionType.celebrate:
//         return 'ابتسامة';
//       case ReactionType.question:
//         return 'سؤال';
//       case ReactionType.insightful:
//         return 'قهوة';
//       case ReactionType.like:
//         return 'إعجاب';
//     }
//   }
// }

// class _ReactionsBottomSheet extends StatelessWidget {
//   final List<ReactionUser> reactions;
//
//   const _ReactionsBottomSheet({
//     required this.reactions,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 400,
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               AppText(
//                 text: 'التفاعلات',
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//               const Spacer(),
//               IconButton(
//                 icon: const Icon(Icons.close),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ],
//           ),
//           12.ph(),
//           Expanded(
//             child: ListView.builder(
//               itemCount: reactions.length,
//               itemBuilder: (context, index) {
//                 final user = reactions[index];
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(user.avatarUrl),
//                   ),
//                   title: AppText(
//                     text: user.name,
//                     fontSize: 12,
//                   ),
//                   trailing: Container(
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: user.reactionType.reactionColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Image.asset(
//                       user.reactionType.assetPath,
//                       height: 20,
//                       width: 20,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
