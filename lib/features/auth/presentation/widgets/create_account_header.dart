import 'package:flutter/material.dart';

class CreateAccountHeader extends StatelessWidget {
  final int step;
  final bool isEdit;

  const CreateAccountHeader({
    super.key,
    required this.step,
    required this.isEdit
  });

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.centerRight,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: !isEdit?'انشاء حسابي': 'تحديث حسابي',
              style: const TextStyle(
                color: Color(0xFF001A27),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(text: ' '),
            TextSpan(
              text: '(${step}- البيانات الشخصية)',
              style:const TextStyle(
                color: Color(0xFF001A27),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}