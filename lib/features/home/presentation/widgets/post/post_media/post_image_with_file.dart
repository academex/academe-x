import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';
import 'package:academe_x/lib.dart';

import '../../../../domain/entities/post/image_entity.dart';

class PostImageWithFile extends StatelessWidget {
  final String fileName;
  final String fileUrl;
  final List<ImageEntity> images;

  const PostImageWithFile({
    Key? key,
    required this.fileName,
    required this.fileUrl,
    required this.images,
  }) : super(key: key);

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(fileUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image Section
        Stack(
          children: [
            ClipRRect(
              child: SizedBox(
                height: 292,
                child: PageView(
                  children: List.generate(
                    images.length,
                        (index) => CachedNetworkImage(
                      imageUrl: images[index].url!,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11.54),
                          ),
                        ),
                      ),
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff0077ff),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  onPageChanged: (value) {
                    context.read<PostImageCubit>().changeImageIndex(value);
                  },
                ),
              ),
            ),
            _buildImageCounter(images),
          ],
        ),
        9.5.ph(),
        _buildDotsIndicator(images),
        12.ph(),
        // File Section
        Container(
          height: 50.h,
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 7.w),
          decoration: BoxDecoration(
            color: const Color(0xffF9F9F9),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: const Color.fromRGBO(156, 163, 175, 0.44)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              11.pw(),
              const ImageIcon(
                AssetImage('assets/icons/pdf.png'),
                color: Color(0xff9CA3AF),
              ),
              10.pw(),
              Expanded(
                child: AppText(
                  text: fileName,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff193648),
                ),
              ),
              InkWell(
                onTap: _launchURL,
                child: Container(
                  height: 36,
                  width: 68,
                  decoration: BoxDecoration(
                    color: const Color(0xff0077ff),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: AppText(
                      text: 'تنزيل',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageCounter(List<ImageEntity> images) {
    if (images.length > 1) {
      return BlocBuilder<PostImageCubit, int>(
        builder: (context, currentIndex) {
          return Positioned(
            top: 8.0,
            left: 8.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: AppText(
                text: '${currentIndex + 1}/${images.length}',
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildDotsIndicator(List<ImageEntity> images) {
    if (images.length > 1) {
      return BlocBuilder<PostImageCubit, int>(
        builder: (context, currentIndex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
                  (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.25),
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == currentIndex
                      ? const Color(0xFF0077FF)
                      : const Color(0xFFEEEEEE),
                ),
              ),
            ),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
}