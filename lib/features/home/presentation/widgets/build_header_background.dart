import 'package:academe_x/lib.dart';

import 'package:flutter/material.dart';

class BuildHeaderBackground extends StatelessWidget {
  bool inScroll;
   BuildHeaderBackground({required this.inScroll,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.81,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background_library.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: BuildHeaderContent(inScroll: inScroll),
    );
  }
}
