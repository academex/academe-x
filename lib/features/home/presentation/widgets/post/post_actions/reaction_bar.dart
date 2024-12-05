import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_actions/reaction_avatars.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/post/post_entity.dart';

class ReactionBar extends StatelessWidget {
  final PostEntity post;
  final VoidCallback onTap;

  const ReactionBar({
    required this.post,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (post.reactions == null || post.reactions!.items.isEmpty) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          ReactionAvatars(reactions: post.reactions!.items),
          7.pw(),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: _buildReactionText(),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  String _buildReactionText() {
    final items = post.reactions!.items;
    if (items.isEmpty) return '';
    if (items.length == 1) return items[0].user.username;
    if (items.length == 2) {
      return '${items[0].user.username} و ${items[1].user.username}';
    }
    return '${items[0].user.username} و ${post.reactions!.count - 1} آخرين';
  }
}