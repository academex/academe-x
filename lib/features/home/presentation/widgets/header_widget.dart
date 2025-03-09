
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import 'package:flutter/material.dart';

import 'package:academe_x/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        _buildLogoContainer(logoPath,inScroll,context) ,
        // inScroll?: _buildLogoContainer(logoPath),
        8.pw(),
        _buildTitleAndSubtitle(inScroll,title,subTitle),
        const Spacer(),
        firstIconPath != null ? _buildIconButton(firstIconPath!, inScroll) : 20.pw(), //'assets/icons/search.png'
        secondIconPath != null ?   _buildIconButton(
            secondIconPath!, inScroll) : 20.pw(),// 'assets/icons/notification.png'
      ],
    );
  }


  Widget _buildLogoContainer(String image,bool inScroll,BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: inScroll ? 20: 0),
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Color(0xff1F02E8),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Image.asset(
          image, //'assets/images/Frame.png'
          height: 28,
          width: 28,
        ),
      ),
      onTap: () => context.read<PostsCubit>().goToTop(),
    );
  }

  Widget _buildTitleAndSubtitle(bool inScroll,String title,String subTitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title, //
          fontSize: 16  ,
          color: inScroll ? Colors.black : Colors.white,
          fontWeight: FontWeight.w600,

        ),
        if (!inScroll) ...[
          6.ph(),
          AppText(
            text:subTitle,
            fontSize: 12,
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
        height: 20,
        width: 20,
        color: inScroll ? Colors.black : Colors.white,
      ),
      padding: EdgeInsets.zero,
    );
  }
}
