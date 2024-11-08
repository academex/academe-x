import 'package:academe_x/lib.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PostContent extends StatelessWidget {
  final String content;

  const PostContent({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  //   return ExpandableText(
  //     text: content,
  //   );

    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit,bool>(
        builder: (context, isExpanded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                maxLines: isExpanded ? null : 2,
                overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,  ),
              ),
         content.length>50 ?     GestureDetector(
                onTap: () => context.read<HomeCubit>().expandText(!isExpanded),
                child: Text(
                  isExpanded ? 'عرض أقل' : 'عرض المزيد',
                  style: const TextStyle(color: Colors.blue),
                ),
              ) : 0.ph(),
            ],
          );
        },
      ),
    );
  }
}