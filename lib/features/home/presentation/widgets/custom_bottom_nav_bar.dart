import 'package:academe_x/lib.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../college_major/controller/cubit/college_major_cubit.dart';
import '../controllers/cubits/post/posts_cubit.dart';
import 'create_post_widgets/create_post.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16   ,
              vertical: 8
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              NavigationItems.items.length,
                  (index) => _buildNavItem(
                context,
                NavigationItems.items[index],
                index,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context,
      NavigationItem item,
      int index,
      // int currentIndex,
      ) {

    return item.label=='create' ?  FloatingActionButton(
      onPressed: () {
        CreatePost().showCreatePostModal(context);
      },
      backgroundColor: Colors.blue,
      child: const Icon(Icons.add, size: 32.0),
    ): InkWell(
      onTap: () async{
        if(index == 0){
          context.read<PostsCubit>().goToTop();
        await  context.read<PostsCubit>().refreshPosts(context.read<CollegeMajorsCubit>().state.selectedMajor!.id!);
        }
        // index == 0? :null;

        context.read<BottomNavCubit>().changePage(index);
      },
      child: BlocBuilder<BottomNavCubit,int>(builder: (context, currentIndex) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              item.icon,
              width: 24   ,
              height: 24,
              color: index== currentIndex ? AppColors.primary : Colors.grey,
            ),
            4.ph(),
            AppText(
              text: item.label,
              fontSize: 12  ,
              color:  index== currentIndex ? AppColors.primary : Colors.grey,
            ),
          ],
        );
      },),
    );
  }
}