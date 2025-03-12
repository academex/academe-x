import 'package:flutter/material.dart';

class FileSelectionCard extends StatelessWidget {
  final String fileName;
  final bool isUploading;
  final VoidCallback onPickFile;

  const FileSelectionCard({
    Key? key,
    required this.fileName,
    required this.isUploading,
    required this.onPickFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select File',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    fileName,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: isUploading ? null : onPickFile,
                  icon: const Icon(Icons.file_upload),
                  label: const Text('Browse'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}