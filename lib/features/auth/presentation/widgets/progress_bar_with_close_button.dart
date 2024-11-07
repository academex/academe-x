import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return SizedBox(
      height: 50.h,
      child: Stack(
        children: [
          Positioned.fill(
            right: 40,
            child: Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 10.h,
                  width: 284.w,
                  child: LinearProgressIndicator(
                    value: progressValue,
                    minHeight: 16.h,
                    backgroundColor: Colors.grey[200],
                    color: const Color(0xff5DCA14),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(Icons.close, size: 24.w, color: Colors.black),
              onPressed: onClose,
            ),
          ),
        ],
      ),
    );
  }
}
