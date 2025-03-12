import 'package:flutter/material.dart';

class UploadProgressWidget extends StatelessWidget {
  final double progress;

  const UploadProgressWidget({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Uploading file...'),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: progress),
        Text('${(progress * 100).toStringAsFixed(1)}%'),
      ],
    );
  }
}