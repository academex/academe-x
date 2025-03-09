import 'package:academe_x/academeX_main.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/lib.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PostContent extends StatelessWidget {
  final PostEntity post;

  const PostContent({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit,bool>(
        builder: (context, isExpanded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.content!,
                maxLines: isExpanded ? null : 2,
                overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,  ),
              ),
              post.content!.length>50 ?     GestureDetector(
                onTap: () => context.read<HomeCubit>().expandText(!isExpanded),
                child: Text(
                  isExpanded ? 'عرض أقل' : 'عرض المزيد',
                  style: const TextStyle(color: Colors.blue),
                ),
              ) : 0.ph(),
              10.ph(),
              // I want to add a tags if there's tags in the post

              if(post.tags != null)
                Wrap(
                  spacing: 5,
                  children: post.tags!.map((tag) => AppText(text: '#${tag.name!}', fontSize: 16,color: Colors.blueAccent,)).toList(),
                ),


              //

            ],
          );
        },
      ),
    );
  }
}