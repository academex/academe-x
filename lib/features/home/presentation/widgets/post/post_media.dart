import 'package:academe_x/features/home/domain/entities/post/image_entity.dart';
import 'package:academe_x/features/home/presentation/widgets/create_post_widgets/file_container.dart';
import 'package:academe_x/features/home/presentation/widgets/post/poll_post_widget.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_media/post_image_with_file.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:academe_x/lib.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';

import '../../../domain/entities/post/poll/poll.dart';
import '../../../domain/entities/post/poll/poll_option.dart';
import '../../../domain/entities/post/post_entity.dart';

class PostMedia extends StatelessWidget {
  final PostEntity post;

  const PostMedia({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    if (post.images?.isNotEmpty ?? false) {
      if (post.file?.url != null) {
        return _buildPostImageWithFile(
            fileName: post.file!.name!,
            fileUrl: post.file!.url!
        );
      }
      return _buildPostImage(context, post.images!);
    }

    if (post.file?.url != null) {
      return FileContainer(
          fileName: post.file!.name,
          fileUrl: post.file!.url
      );
    }

    if (post.poll != null) {
      return PollWidget(options: post.poll!.pollOptions!, title: post.poll!.question, totalVotes: 0, totalViews: 0);
    }

    return const SizedBox.shrink();

  }


  Widget _buildPostImage(BuildContext ctx, List<ImageEntity> images) {

    return Column(
      children: [
        12.ph(),
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
                    return CachedNetworkImage(
                      imageUrl: images[index].url!,
                      imageBuilder: (context, imageProvider) => PhotoView(
                        imageProvider: NetworkImage(images[index].url!),
                        filterQuality: FilterQuality.high,
                        enableRotation: true,
                      ),
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff0077ff),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    );
                    // return PhotoView(
                    //   imageProvider: NetworkImage(images[index].url!),
                    //   filterQuality: FilterQuality.high,
                    //
                    // );

                    // return Container(
                    //     child: ;
                    // return Container(
                    //   // width: 326,
                    //   decoration: ShapeDecoration(
                    //     image: DecorationImage(
                    //       image: NetworkImage(images[index].url!),
                    //       fit: BoxFit.contain,
                    //     ),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(11.54),
                    //     ),
                    //   ),
                    // );
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

  Widget _buildImageCounter(List<dynamic> images) {
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

  Widget _buildDotsIndicator(List<dynamic> images) {
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

  Widget _buildPoll(Poll options) {
    return Column(
      children: options.pollOptions!.map((option) {
        return Container(
          margin: EdgeInsets.only(bottom: 8),
          child: _PollOption(
            text: option.content,
            votes: option.count,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPostImageWithFile({required String fileName, required String fileUrl}) {

    return Column(
      children: [
        12.ph(),
        PostImageWithFile(
          fileName: fileName,
          fileUrl: fileUrl,
          images: post.images!,
        )
      ],
    );
  }

}

class _PollOption extends StatelessWidget {
  final String text;
  // final double percentage;
  final int votes;

  const _PollOption({
    required this.text,
    // required this.percentage,
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
            // widthFactor: percentage / 100,
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
                text: '$votes',
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
