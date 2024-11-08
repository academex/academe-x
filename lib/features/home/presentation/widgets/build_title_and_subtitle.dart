import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class BuildTitleAndSubtitle extends StatelessWidget {
  bool inScroll;
   BuildTitleAndSubtitle({required this.inScroll,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'مكتبتي',
          fontSize: 16  ,
          color: inScroll ? Colors.black : Colors.white,
          fontWeight: FontWeight.w600,
        ),
        if (!inScroll) ...[
          // 6.ph(),
          AppText(
            text: 'كل ما تحتاجه من كتب وملخصات وشباتر',
            fontSize: 10  ,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ],
      ],
    );
  }
}
