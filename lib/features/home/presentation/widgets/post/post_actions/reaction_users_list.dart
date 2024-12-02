import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/utils/reaction_type_utils.dart';
import '../../../../../../core/widgets/app_text.dart';
import '../../../../domain/entities/post/reaction_item_entity.dart';

class ReactionUsersList extends StatelessWidget {
  final List<ReactionItemEntity> reactions;

  const ReactionUsersList({
    required this.reactions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: reactions.length,
      itemBuilder: (context, index) {
        final reaction = reactions[index];
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
    );
  }
}