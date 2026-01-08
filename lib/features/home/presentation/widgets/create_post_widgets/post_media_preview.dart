import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as path;
import '../../../../../core/core.dart';
import '../../controllers/cubits/create_post/create_post_cubit.dart';
import '../../controllers/states/create_post/create_post_state.dart';
import 'post_poll_creator.dart';

class PostMediaPreview extends StatelessWidget {
  const PostMediaPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        // Show image processing indicator
        if (state.isProcessingImages) {
          return _buildProcessingIndicator(state);
        }

        // Show media based on type
        switch (state.mediaType) {
          case MediaType.images:
            return _buildImagesPreview(context, state);
          case MediaType.file:
            return _buildFilePreview(context, state);
          case MediaType.poll:
            return const PostPollCreator();
          case MediaType.none:
          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget _buildProcessingIndicator(CreatePostState state) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          CircularProgressIndicator(
            value: state.totalImagesToProcess > 0
                ? state.processedImagesCount / state.totalImagesToProcess
                : null,
          ),
          12.ph(),
          AppText(
            text: 'جار معالجة الصور... ${state.processedImagesCount}/${state.totalImagesToProcess}',
            fontSize: 12.sp,
            color: Colors.grey[600]!,
          ),
          8.ph(),
          AppText(
            text: 'هذا قد يستغرق بضع ثوانٍ',
            fontSize: 10.sp,
            color: Colors.grey[400]!,
          ),
        ],
      ),
    );
  }

  Widget _buildImagesPreview(BuildContext context, CreatePostState state) {
    return SizedBox(
      height: 180.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.images.length,
        itemBuilder: (context, index) {
          return _ImagePreviewItem(
            image: state.images[index],
            onRemove: () {
              context.read<CreatePostCubit>().removeImage(index);
            },
          );
        },
      ),
    );
  }

  Widget _buildFilePreview(BuildContext context, CreatePostState state) {
    if (state.document == null) return const SizedBox();

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFFD1D5DB),
        ),
      ),
      child: Row(
        children: [
          const ImageIcon(
            AssetImage('assets/icons/pdf.png'),
            color: Color(0xFF9CA3AF),
          ),
          12.pw(),
          Expanded(
            child: AppText(
              text: path.basename(state.document!.path),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<CreatePostCubit>().pickDocument();
            },
            icon: const Icon(Icons.close, color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class _ImagePreviewItem extends StatelessWidget {
  final File image;
  final VoidCallback onRemove;

  const _ImagePreviewItem({
    required this.image,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      width: 150.w,
      child: Stack(
        children: [
          // Image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: FileImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Remove button
          Positioned(
            top: 4.h,
            right: 4.w,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}