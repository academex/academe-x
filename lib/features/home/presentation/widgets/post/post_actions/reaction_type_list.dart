import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_actions/reaction_type_item.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/post/reaction_item_entity.dart';
import '../../../controllers/cubits/post/posts_cubit.dart';

class ReactionTypesList extends StatelessWidget {
  final List<ReactionItemEntity> reactions;
  final int postId;
  final String? selectedType;

  const ReactionTypesList({
    required this.reactions,
    required this.postId,
    this.selectedType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupedReactions = _groupReactionsByType();

    return Container(
      height: 48,
      decoration: ShapeDecoration(
        color: const Color(0xFFF9F9F9),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.80,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0x38E1E1E1),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: groupedReactions.length,
        separatorBuilder: (_, __) => 8.pw(),
        itemBuilder: (context, index) {
          final type = groupedReactions.keys.elementAt(index);
          final count = groupedReactions[type]!.length;

          return ReactionTypeItem(
            type: type,
            count: count,
            isSelected: type == selectedType,
            onTap: () => _handleTypeSelection(context, type),
          );
        },
      ),
    );
  }

  Map<String, List<ReactionItemEntity>> _groupReactionsByType() {
    return groupBy(reactions, (reaction) => reaction.type);
  }

  Future<void> _handleTypeSelection(BuildContext context, String type) async {
    await context.read<PostsCubit>().getUsersByReactionType(
      reactType: type,
      postId: postId,
    );
  }
}