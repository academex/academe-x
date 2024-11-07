import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';
import 'build_icon_button.dart';
import 'build_logo_container.dart';
import 'build_title_and_subtitle.dart';

class BuildHeaderContent extends StatelessWidget {
  bool inScroll;
   BuildHeaderContent({required this.inScroll,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        inScroll ? 0.ph() : 40.ph(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BuildLogoContainer(),
                  8.pw(),
                  BuildTitleAndSubtitle(inScroll: inScroll),
                  const Spacer(),
                  BuildIconButton(iconPath: 'assets/icons/filter.png',inScroll:inScroll),
                ],
              ),
              16.ph(),
              AppText(
                text: 'المواد الخاصة بي',
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              20.ph(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 24.w),
          child: SizedBox(
            height: 40.h,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 70.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            // image:
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Center(
                            child: Text('data'),
                          ),
                        ),
                        onTap: () {
                          // context
                          //     .read<CategoryCubit>()
                          //     .selectCategory(index);
                        },
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return 10.pw();
                },
                itemCount: 5),
          ),
        ),
      ],
    );
  }
}
