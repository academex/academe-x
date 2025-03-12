import 'package:flutter/material.dart';

class SuccessCard extends StatelessWidget {
  final String fileUrl;

  const SuccessCard({
    Key? key,
    required this.fileUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'File Uploaded Successfully',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}