import 'package:academe_x/features/auth/presentation/controllers/cubits/authentication_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/home/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/app_size.dart';
import '../../../../core/widgets/app_text.dart';
import 'create_post.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: SizedBox(
        height: kBottomNavBarHeight.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(
              iconPath: 'assets/icons/community.png',
              label: 'مجتمعي',
              onTap: () {
                context.read<BottomNavCubit>().changePage(0);
              },
              index: 0,
            ),
            _buildNavItem(
              iconPath: 'assets/icons/library.png',
              label: 'مكتبتي',
              onTap: () {
                context.read<BottomNavCubit>().changePage(1);
              },
              index: 1,
            ),
            FloatingActionButton(
              onPressed: () {
                CreatePost().showCreatePostModal(context);
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add, size: 32.0),
            ),
            // SizedBox(width: 40.w),
            _buildNavItem(
              iconPath: 'assets/icons/chatbot.png',
              label: 'شات بوت',
              onTap: () {
                context.read<BottomNavCubit>().changePage(2);
                print(context.read<BottomNavCubit>().state);
              },
              index: 2,
            ),
            _buildNavItem(
              iconPath: 'assets/icons/setting.png',
              label: 'الاعدادات',
              onTap: () {
                context.read<BottomNavCubit>().changePage(3);
              },
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String iconPath,
    required String label,
    required int index,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: BlocBuilder<BottomNavCubit, int>(
          builder: (context, currentIndex) {
            final isSelected = index == currentIndex;

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconPath,
                  color: isSelected ? Colors.black : Colors.grey,
                  height: 24.h,
                  width: 24.w,
                ),
                AppText(
                  text: label,
                  color: isSelected ? Colors.blue : Colors.grey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            );
          },
        ));
  }
}
