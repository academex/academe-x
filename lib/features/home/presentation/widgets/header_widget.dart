
import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';

class HeaderWidget extends StatelessWidget {
  bool inScroll;
  String logoPath;
  String title;
  String subTitle;
  String? firstIconPath;
   String? secondIconPath;
   HeaderWidget({
     super.key,
     required this.inScroll,
     required this.logoPath,
     required this.title,
     required this.subTitle,
      this.firstIconPath,
      this.secondIconPath,
   });

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        inScroll?_buildLogoContainer(logoPath): _buildLogoContainer(logoPath),
        8.pw(),
        _buildTitleAndSubtitle(inScroll,title,subTitle),
        const Spacer(),
        firstIconPath != null ? _buildIconButton(firstIconPath!, inScroll) : 20.pw(), //'assets/icons/search.png'
        secondIconPath != null ?   _buildIconButton(
            secondIconPath!, inScroll) : 20.pw(),// 'assets/icons/notification.png'
      ],
    );
  }


  Widget _buildLogoContainer(String image) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: const BoxDecoration(
        color: Color(0xff007BFF),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Image.asset(
       image, //'assets/images/Frame.png'
        height: 28.h,
        width: 28.w,
      ),
    );
  }

  Widget _buildTitleAndSubtitle(bool inScroll,String title,String subTitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title, //
          fontSize: 16.sp,
          color: inScroll ? Colors.black : Colors.white,
          fontWeight: FontWeight.w500,

        ),
        if (!inScroll) ...[
          // 6.ph(),
          AppText(
            text:subTitle, // 'مجتمع مخصص لكل تساؤلاتك'
            fontSize: 10.sp,
            color: Colors.white,
          ),
        ],
      ],
    );
  }

  Widget _buildIconButton(String iconPath, bool inScroll) {
    return IconButton(
      onPressed: () {},
      icon: Image.asset(
        iconPath,
        height: 20.h,
        width: 20.w,
        color: inScroll ? Colors.black : Colors.white,
      ),
      padding: EdgeInsets.zero,
    );
  }
}
