import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/core/widgets/app_text.dart';
import 'package:academe_x/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatePost {
  final TextEditingController _postController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void showCreatePostModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9, // Modal height factor
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 24.w,
              right: 24.w,
              top: 16.h,
            ), // Adjust for keyboard and padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top handle to indicate drag
                Center(
                  child: Container(
                    width: 56.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: Color(0xffE7E8EA),
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: 'الغاء',
                      fontSize: 14.sp,
                      color: Colors.green,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    AppText(
                      text: 'إنشاء بوست',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    // You can add another icon or widget here if needed
                    SizedBox(width: 50.w), // Placeholder for alignment
                  ],
                ),
               16.ph(),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                      radius: 20.w,
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: 'إبراهيم',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        AppText(
                          text: '#تطوير البرمجيات',
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  withBoarder: false,
                  maxLine: null,
                  controller: _postController,
                  hintText: 'قم بكتابة ما تريد الاستفسار عنه ..',
                  keyboardType: TextInputType.multiline,
                  focusNode: _focusNode,
                  suffix: GestureDetector(
                    onTap: () {
                      _postController.clear();
                    },
                    child: Icon(Icons.clear, color: Colors.grey),
                  ),
                ),
                // need if statment as : if(textController.isNotEmpty) do the loop
                // for loop for the hashes
                for (int i = 0; i < 1; i++)
                  AppText(
                    text: '   ' + '#تطوير برمجيات',
                    fontSize: 14.sp,
                    color: const Color(0xff0077FF),
                  ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    IconButton(
                      icon:
                          const ImageIcon(AssetImage('assets/icons/image.png')),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const ImageIcon(
                          AssetImage('assets/icons/document.png')),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon:
                          const ImageIcon(AssetImage('assets/icons/menu.png')),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon:
                          const ImageIcon(AssetImage('assets/icons/hash.png')),
                      onPressed: () {},
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // Handle post submission
                  },
                  child: Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color:
                          Color(0xFF007AFF), // Blue color for the post button
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Center(
                      child: AppText(
                        text: 'نشر',
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                20.ph(),
              ],
            ),
          ),
        );
      },
    );
  }
}
