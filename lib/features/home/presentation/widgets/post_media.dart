import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'package:academe_x/lib.dart';

class PostMedia extends StatelessWidget {
  final PostEntityS post;

  const PostMedia({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (post.type) {
      case PostType.textWithImage:
        return _buildImageGrid(post.images!);
      case PostType.textWithPoll:
        return _buildPoll(post.pollOptions!);
      case PostType.textWithFile:
        return _buildFileAttachment();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildImageGrid(List<String> images) {
    if (images.isEmpty) return const SizedBox.shrink();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: images.length == 1 ? 1 : 2,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: images.length == 1 ? 16 / 9 : 1,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          images[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPoll(Map<String, int> options) {
    return Column(
      children: options.entries.map((option) {
        final percentage = option.value /
            options.values.reduce((sum, value) => sum + value) *
            100;

        return Container(
          margin: EdgeInsets.only(bottom: 8),
          child: _PollOption(
            text: option.key,
            percentage: percentage,
            votes: option.value,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFileAttachment() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.file_present, size: 24),
          8.pw(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: post.fileName ?? 'File',
                  fontSize: 14,
                ),
                4.ph(),
                AppText(
                  text: 'Tap to download',
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              //   => _downloadFile(post.fileUrl!)
            },
          ),
        ],
      ),
    );
  }

// ... Include the _buildImageGrid, _buildPoll, and _buildFileAttachment methods
}

class _PollOption extends StatelessWidget {
  final String text;
  final double percentage;
  final int votes;

  const _PollOption({
    required this.text,
    required this.percentage,
    required this.votes,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: percentage / 100,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue.withOpacity(0.2),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: AppText(text: text, fontSize: 14),
              ),
              AppText(
                text: '${percentage.toStringAsFixed(1)}% ($votes)',
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
