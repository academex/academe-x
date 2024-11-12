// ignore_for_file: must_be_immutable

import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';


class ActionButton extends StatelessWidget {
  late String iconPath;
  late String count;
  // late bool isLike;
  late VoidCallback onTap;

  ActionButton({
    super.key,
    required this.iconPath,
    required this.count,
    required this.onTap,
     // this.isLike=false
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      // focusColor: const Color(0xffF7F7F8),
      borderRadius: BorderRadius.circular(10),
      // highlightColor: const Color(0xffF7F7F8),

      child: Container(
       decoration: BoxDecoration(
         color: const Color(0xffF7F7F8),
         borderRadius: BorderRadius.all(Radius.circular(10)),
       ),
        padding: EdgeInsets.symmetric(horizontal: 8   ,vertical: 12),
        // alignment: AlignmentDirectional.center,
        child:Row(
          children: [
            Image.asset(
         iconPath,
              height: 25,
              width: 25   ,
            ),
            4.pw(),
            AppText(
              text: count,
              fontSize: 14  ,

              color: const Color(0xff707281),
            )
          ],
        ),
      ),
    );
  }
}