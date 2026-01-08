import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/core.dart';
import '../../controllers/cubits/create_post/create_post_cubit.dart';
import '../../controllers/states/create_post/create_post_state.dart';

class PostSubmitButton extends StatelessWidget {
  const PostSubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        return Column(
          children: [
            // Error message
            if (state.errorMessage != null) ...[
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 20.r,
                    ),
                    12.pw(),
                    Expanded(
                      child: AppText(
                        text: state.errorMessage!,
                        fontSize: 12.sp,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              12.ph(),
            ],

            // Submit button
            GestureDetector(
              onTap: state.canSubmit
                  ? () => context.read<CreatePostCubit>().submitPost(context)
                  : null,
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: state.canSubmit
                      ? const Color(0xFF0077FF)
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: _buildButtonContent(state),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildButtonContent(CreatePostState state) {
    switch (state.status) {
      case CreatePostStatus.processing:
      case CreatePostStatus.uploading:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.r,
              height: 20.r,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                value: state.uploadProgress,
              ),
            ),
            if (state.uploadProgress != null) ...[
              4.ph(),
              AppText(
                text: '${(state.uploadProgress! * 100).toInt()}%',
                fontSize: 10.sp,
                color: Colors.white,
              ),
            ],
          ],
        );

      default:
        return AppText(
          text: 'نشر',
          fontSize: 16.sp,
          color: state.canSubmit ? Colors.white : Colors.grey[500]!,
          fontWeight: FontWeight.bold,
        );
    }
  }
}