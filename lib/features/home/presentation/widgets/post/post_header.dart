// import 'package:academe_x/lib.dart';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/cubits/home/bottom_nav_cubit.dart';
import '../../controllers/cubits/post/posts_cubit.dart';


class PostHeader extends StatelessWidget {
  final PostEntity post;

  const PostHeader({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade200 ,
            backgroundImage: post.user!.photoUrl != null? NetworkImage(post.user!.photoUrl ?? '') :null,
            radius: 20   ,
            child: const Icon(Icons.person_outline,color: Colors.blue,),

          ),
          onTap: () async{
            final currentUser = await context.cachedUser ;
            final postUser = post.user;
            if(postUser!.username == currentUser!.user.username){
              context.read<BottomNavCubit>().changePage(NavigationIndex.profile);
            }else{
            await  context.pushNamed(
                  'profile',
                  extra: {'username': post.user!.username}
              );

            }

          },
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
              Row(
                children: [
                  AppText(
                    text: '@${post.user!.username}',
                    fontSize: 12  ,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w400,
                  ),
                  AppText(
                    text: ' | ',
                    fontSize: 16  ,
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
      return 'منذ${difference.inDays} ${difference.inDays == 1 ? 'ي' : 'أي'}';
    } else if (difference.inHours > 0) {
      return 'منذ ${difference.inHours}  ${difference.inHours == 1 ? 'س' : 'س'}';
    } else if (difference.inMinutes > 0) {
      return 'منذ${difference.inMinutes} ${difference.inMinutes == 1 ? 'د' : 'د'}';
    } else {
      return 'الان';
    }
  }
}