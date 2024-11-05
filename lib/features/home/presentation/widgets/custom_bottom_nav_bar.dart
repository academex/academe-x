import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/app_size.dart';
import '../../../../core/widgets/app_text.dart';
import 'create_post_widgets/create_post.dart';

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
            _buildNavItem('assets/icons/community.png', 'مجتمعي',
                isSelected: true),
            _buildNavItem('assets/icons/library.png', 'مكتبتي'),
            FloatingActionButton(
              onPressed: () {
                CreatePost().showCreatePostModal(context);
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add, size: 32.0),
            ),
            // SizedBox(width: 40.w),
            _buildNavItem('assets/icons/chatbot.png', 'شات بوت'),
            _buildNavItem('assets/icons/setting.png', 'الاعدادات'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, {bool isSelected = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon),
        // Icon(icon, color: isSelected ? Colors.blue : Colors.grey, size: 24.0),
        AppText(
            text: label,
            color: isSelected ? Colors.blue : Colors.grey,
            fontSize: 12.sp)
      ],
    );
  }
}
