import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_post_widgets/create_post.dart';

// class CustomBottomNavBar extends StatelessWidget {
//   const CustomBottomNavBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       shape: const CircularNotchedRectangle(),
//       notchMargin: 8.0,
//       child: SizedBox(
//         height: kBottomNavBarHeight
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             _buildNavItem(
//               iconPath: 'assets/icons/community.png',
//               label: 'مجتمعي',
//               onTap: () {
//                 context.read<BottomNavCubit>().changePage(0);
//               },
//               index: 0,
//             ),
//             _buildNavItem(
//               iconPath: 'assets/icons/library.png',
//               label: 'مكتبتي',
//               onTap: () {
//                 context.read<BottomNavCubit>().changePage(1);
//               },
//               index: 1,
//             ),
//             FloatingActionButton(
//               onPressed: () {
//                 CreatePost().showCreatePostModal(context);
//               },
//               backgroundColor: Colors.blue,
//               child: const Icon(Icons.add, size: 32.0),
//             ),
//             // SizedBox(width: 40   ),
//             _buildNavItem(
//               iconPath: 'assets/icons/chatbot.png',
//               label: 'شات بوت',
//               onTap: () {
//                 context.read<BottomNavCubit>().changePage(2);
//                 print(context.read<BottomNavCubit>().state);
//               },
//               index: 2,
//             ),
//             _buildNavItem(
//               iconPath: 'assets/icons/setting.png',
//               label: 'الاعدادات',
//               onTap: () {
//                 context.read<BottomNavCubit>().changePage(3);
//               },
//               index: 3,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem({
//     required String iconPath,
//     required String label,
//     required int index,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//         onTap: onTap,
//         child: BlocBuilder<BottomNavCubit, int>(
//           builder: (context, currentIndex) {
//             final isSelected = index == currentIndex;
//
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   iconPath,
//                   color: isSelected ? Colors.black : Colors.grey,
//                   height: 24
//                   width: 24   ,
//                 ),
//                 AppText(
//                   text: label,
//                   color: isSelected ? Colors.blue : Colors.grey,
//                   fontSize: 12  ,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ],
//             );
//           },
//         ));
//   }
// }



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
      onTap: () => context.read<BottomNavCubit>().changePage(index),
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