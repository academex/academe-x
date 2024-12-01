// import 'package:academe_x/lib.dart';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';

import 'package:flutter/material.dart';


class PostHeader extends StatelessWidget {
  final PostEntity post;

  const PostHeader({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        post.user!.photoUrl != null?  CircleAvatar(
          backgroundImage: NetworkImage(post.user!.photoUrl ?? ''),
          radius: 20   ,
        ) :Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200
          ),
        ),
        10.pw(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: '${post.user!.firstName}  ${post.user!.lastName}' ,
                color: Color(0xFF0F172A),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              AppText(
                text: '@${post.user!.username}',
                fontSize: 12  ,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w400,
              ),
              AppText(
                text: getTimeAgo(post.createdAt!),
                fontSize: 12  ,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w400,
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {
    //         => _showPostOptions(context),
    },
          icon: const Icon(Icons.more_horiz),
        )
      ],
    );
  }

  String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return 'منذ${difference.inDays} ${difference.inDays == 1 ? 'يوم' : 'أيام'}';
    } else if (difference.inHours > 0) {
      return 'منذ ${difference.inHours}  ${difference.inHours == 1 ? 'ساعة' : 'ساعات'}';
    } else if (difference.inMinutes > 0) {
      return 'منذ${difference.inMinutes} ${difference.inMinutes == 1 ? 'دقيقة' : 'دقايق'}';
    } else {
      return 'الان';
    }
  }
}