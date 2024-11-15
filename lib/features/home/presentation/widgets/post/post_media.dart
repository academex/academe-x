import 'package:academe_x/features/home/presentation/widgets/create_post_widgets/file_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:academe_x/lib.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostMedia extends StatelessWidget {
  final PostEntity post;

  const PostMedia({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (post.type) {
      case PostType.textWithImage:
        return _buildPostImage(context, post.images!);
      case PostType.textWithPoll:
        return _buildPoll(post.pollOptions!);
      case PostType.textWithFile:
        return FileContainer(fileName: post.fileName, fileUrl: post.fileUrl);
      default:
        return const SizedBox.shrink();
    }
  }

  // Widget _buildImageGrid(List<String> images) {
  //   if (images.isEmpty) return const SizedBox.shrink();
  //
  //   return GridView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: images.length == 1 ? 1 : 2,
  //       crossAxisSpacing: 8   ,
  //       mainAxisSpacing: 8,
  //       childAspectRatio: images.length == 1 ? 16/9 : 1,
  //     ),
  //     itemCount: images.length,
  //     itemBuilder: (context, index) => ClipRRect(
  //       borderRadius: BorderRadius.circular(8),
  //       child: Image.network(
  //         images[index],
  //         fit: BoxFit.cover,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPostImage(BuildContext ctx, List<String> images) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
                // borderRadius: BorderRadius.circular(8.0),
                child: SizedBox(
              height: 292,
              child: PageView(
                children: List.generate(
                  images.length,
                  (index) {
                    return Container(
                      // width: 326,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(images[index]),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.54),
                        ),
                      ),
                    );
                  },
                ),
                onPageChanged: (value) {
                  ctx.read<PostImageCubit>().changeImageIndex(value);
                },
              ),
            )),
            _buildImageCounter(images),
          ],
        ),
        9.5.ph(),
        _buildDotsIndicator(images)
      ],
    );
  }

  Widget _buildImageCounter(List<String> images) {
    if (images.length > 1) {
      return BlocBuilder<PostImageCubit, int>(
        builder: (context, currentIndex) {
          return Positioned(
            top: 8.0,
            left: 8.0,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: AppText(
                  text: '${currentIndex + 1}/${images.length}',
                  fontSize: 10,
                  color: Colors.white,
                )),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildDotsIndicator(List<String> images) {
    if (images.length > 1) {
      return BlocBuilder<PostImageCubit, int>(
        builder: (context, currentIndex) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.25),
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == currentIndex
                        ? Color(0xFF0077FF)
                        : Color(0xFFEEEEEE),
                  ),
                );
              }));
        },
      );
    }
    return const SizedBox.shrink();
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
