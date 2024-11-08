import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';

class BuildLogoContainer extends StatelessWidget {
  const BuildLogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50    ,
      height: 50,
      decoration: const BoxDecoration(
        color: Color(0xff007BFF),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Image.asset(
        'assets/icons/logo_library.png',
        height: 28,
        width: 28    ,
      ),
    );
  }
}
