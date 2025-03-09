import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';


class BuildCategoryTabs extends StatelessWidget {
  const BuildCategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5,     horizontal: 8   ),
      height: 55,
      width: 327    ,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10 ),
      ),
      child: Row(
        children: [
          BuildCategoryTab(title: 'تطوير البرمجيات', isSelected: true),
          15.pw(),
          BuildCategoryTab(title: 'جامعتي'),
        ],
      ),
    );
  }
}
