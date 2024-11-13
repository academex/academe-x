import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';


class ProgressBarWithCloseButton extends StatelessWidget {
  final VoidCallback onClose;
  final double progressValue;

  const ProgressBarWithCloseButton({
    super.key,
    required this.onClose,
     this.progressValue=0.0
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 24,
          height: 24,
          child: Icon(Icons.close, size: 24   , color: Colors.black),
        ),
        19.pw(),
        Stack(
          children: [
            Container(
              width: 284,
              height: 16,
              decoration: ShapeDecoration(
                color: Color(0xFFEDEDED),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Container(
              width:progressValue== 0.5? 142 : 284,
              height: 16,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-0.96, 0.28),
                  end: Alignment(0.96, -0.28),
                  colors: [Color(0xFF5DCA14), Color(0xFF66E60F)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(86.74),
                ),
              ),
            )
          ],
        )

      ],
    );
  }
}
