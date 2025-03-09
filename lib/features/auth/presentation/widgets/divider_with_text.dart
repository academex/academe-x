import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Expanded(
          child: Divider(
            color: Colors.grey[400],
            thickness: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AppText(
            text: text,
            fontSize: 14  ,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
         Expanded(
          child: Divider(
            color: Colors.grey[400],
            thickness: 1.0,
          ),
        ),
      ],
    );
  }
}
