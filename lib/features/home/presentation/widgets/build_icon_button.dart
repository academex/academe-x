import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';

class BuildIconButton extends StatelessWidget {
  String iconPath; bool inScroll;
   BuildIconButton({required this.iconPath,required this.inScroll});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Image.asset(
        iconPath,
        height: 20,
        width: 20    ,
        color: inScroll ? Colors.black : Colors.white,
      ),
      padding: EdgeInsets.zero,
    );
  }
}
