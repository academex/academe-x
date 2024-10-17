import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/features/auth/presentation/screens/login_screen.dart';
import 'package:academe_x/features/home/presentaion/controllers/cubits/home/action_post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';

class ActionButton extends StatelessWidget {
  late String iconPath;
  late String count;
  late bool isLike;
  ActionButton({
    super.key,
    required this.iconPath,
    required this.count,
     this.isLike=false
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ActionPostCubit>().performAction(!isLike);

      },
      // focusColor: const Color(0xffF7F7F8),
      borderRadius: BorderRadius.circular(10.r),
      highlightColor: const Color(0xffF7F7F8),


      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.h),
        // alignment: AlignmentDirectional.center,

        child:Row(
          children: [
            Image.asset(
            isLike? 'assets/images/liked_button.png':  iconPath,
              height: 17.h,
              width: 19.w,
            ),
            4.pw(),
            AppText(
              text: count,
              fontSize: 14.sp,

              color: const Color(0xff707281),
            )
          ],
        ),
      ),
    );
  }
}