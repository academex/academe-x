import 'package:flutter/material.dart';

import 'package:academe_x/lib.dart';

class BuildCategoryTab extends StatelessWidget {
  late String title;

  late bool isSelected;
   BuildCategoryTab({required this.title, this.isSelected=false});

  @override
  Widget build(BuildContext context) {
  return Expanded(
  child: Container(
  alignment: AlignmentDirectional.center,
  height: 43,
  decoration: BoxDecoration(
  color: isSelected ? const Color(0xff2769F2) : Colors.white,
  borderRadius: BorderRadius.circular(10 ),
  ),
  child: AppText(
  text: title,
  fontSize: 14  ,
  color: isSelected ? Colors.white : Colors.grey,
  ),
  ),
  );
  }
}
