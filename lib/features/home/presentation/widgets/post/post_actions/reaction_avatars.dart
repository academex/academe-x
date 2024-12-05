import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/utils/reaction_type_utils.dart';
import '../../../../domain/entities/post/reaction_item_entity.dart';

class ReactionAvatars extends StatelessWidget {
  final List<ReactionItemEntity> reactions;

  const ReactionAvatars({required this.reactions, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: reactions.length > 1 ? (reactions.length > 2 ? 56 : 40) : 23,
      child: Stack(
        children: List.generate(
          reactions.length > 3 ? 3 : reactions.length,
              (index) => Positioned(
            right: index * 15,
            child: _buildAvatar(reactions[index]),
          ),
        ).reversed.toList(),
      ),
    );
  }

  Widget _buildAvatar(ReactionItemEntity reaction) {
    return SizedBox(
      height: 24,
      width: 24,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(2),
                child: SvgPicture.asset(ReactionTypeUtils.getIconPath(reaction.type)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}