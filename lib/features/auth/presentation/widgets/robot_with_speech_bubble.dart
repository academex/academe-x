import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RobotWithSpeechBubble extends StatelessWidget {
  final String svgString;
  final String speechText;

  const RobotWithSpeechBubble({
    Key? key,
    required this.svgString,
    required this.speechText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        SvgPicture.string(
          svgString,
          height: 150.h,
          width: 150.w,
        ),
        SpeechBubble(text: speechText),
      ],
    );
  }
}

class SpeechBubble extends StatelessWidget {
  final String text;

  const SpeechBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SpeechBubblePainter(),
      child: Container(
        width: 74.w,
        height: 58.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF474CA8),
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final borderPaint = Paint()
      ..color = const Color(0xFF474CA8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..moveTo(10, 0)
      ..lineTo(size.width - 10, 0)
      ..quadraticBezierTo(size.width, 0, size.width, 10)
      ..lineTo(size.width, size.height - 20)
      ..quadraticBezierTo(size.width, size.height - 10, size.width - 10, size.height - 10)
      ..lineTo(size.width - 30, size.height - 10)
      ..lineTo(size.width - 20, size.height + 10) // Speech bubble tail
      ..lineTo(size.width - 40, size.height - 10)
      ..lineTo(10, size.height - 10)
      ..quadraticBezierTo(0, size.height - 10, 0, size.height - 20)
      ..lineTo(0, 10)
      ..quadraticBezierTo(0, 0, 10, 0)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
