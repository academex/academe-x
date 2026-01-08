import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/auth/data/models/response/auth_token_model.dart';
import 'package:academe_x/features/auth/domain/entities/response/user_response_entity.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_majors_state.dart';
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:academe_x/features/home/presentation/widgets/create_post_widgets/post_media_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/core.dart';
import '../../controllers/cubits/create_post/create_post_cubit.dart';
import '../../controllers/states/create_post/create_post_state.dart';
import 'post_content_input.dart';
import 'post_media_picker.dart';
import 'post_tag_selector.dart';
import 'post_submit_button.dart';

class CreatePostBottomSheet extends StatelessWidget {
  const CreatePostBottomSheet({Key? key}) : super(key: key);

  /// Show the create post bottom sheet
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (_) => CreatePostCubit(postUseCase: getIt()),
        child: const CreatePostBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostCubit, CreatePostState>(
      listener: (context, state) {
        // Handle success
        if (state.status == CreatePostStatus.success) {
          Navigator.pop(context);
          context.showSnackBar(
            message: 'تم نشر المنشور بنجاح',
            error: false,
          );
        }

        // Handle error
        if (state.errorMessage != null) {
          context.showSnackBar(
            message: state.errorMessage!,
            error: true,
          );
          context.read<CreatePostCubit>().clearError();
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            const Divider(height: 1),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.ph(),
                    
                    // User info
                    _buildUserInfo(context),
                    
                    16.ph(),
                    
                    // Content input
                    const PostContentInput(),
                    
                    16.ph(),
                    
                    // Selected tags display
                    const _SelectedTagsDisplay(),
                    
                    16.ph(),
                    
                    // Media preview (images/file/poll)
                    const PostMediaPreview(),
                    
                    16.ph(),
                    
                    // Media picker buttons
                    const PostMediaPicker(),
                    
                    16.ph(),
                    
                    // Tag selector (expandable)
                    const PostTagSelector(),
                    
                    16.ph(),
                  ],
                ),
              ),
            ),

            // Submit button
            Padding(
              padding: EdgeInsets.all(16.w),
              child: const PostSubmitButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFFE7E8EA),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          12.ph(),
          
          // Title row
          Row(
            children: [
              // Cancel button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<CreatePostCubit>().reset();
                    Navigator.pop(context);
                  },
                  child: AppText(
                    text: 'إلغاء',
                    fontSize: 14.sp,
                    color: Colors.green,
                  ),
                ),
              ),
              
              // Title
              Expanded(
                child: AppText(
                  text: 'إنشاء منشور',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
              ),
              
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return FutureBuilder<AuthTokenModel?>(
      future: context.cachedUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        final user = snapshot.data!.user;
        final userName = '${user.firstName} ${user.lastName}';

        return Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.grey[200],
              backgroundImage: user.photoUrl != null
                  ? NetworkImage(user.photoUrl!)
                  : null,
              child: user.photoUrl == null
                  ? AppText(
                      text: user.firstName[0].toUpperCase(),
                      fontSize: 15.sp,
                      color: const Color(0xFF0077FF),
                      fontWeight: FontWeight.w600,
                    )
                  : null,
            ),
            
            8.pw(),
            
            // User info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: userName,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                
                // User's main tag
                BlocBuilder<CollegeMajorsCubit, CollegeMajorsState>(
                  builder: (context, state) {
                    if (state.status == MajorsStatus.success && user.tagId != null) {
                      final userMajor = state.majors.firstWhere(
                        (m) => m.id == user.tagId,
                        // orElse: () => MajorEntity(id: 0, name: 'عام'),
                      );
                      
                      // Initialize default tag
                      context.read<CreatePostCubit>().initializeDefaultTag(userMajor);
                      
                      return AppText(
                        text: '#${userMajor.name}',
                        fontSize: 12.sp,
                        color: Colors.grey,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// Display selected tags
class _SelectedTagsDisplay extends StatelessWidget {
  const _SelectedTagsDisplay();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        if (state.selectedTags.isEmpty) {
          return const SizedBox();
        }

        return Wrap(
          spacing: 8.w,
          runSpacing: 4.h,
          children: state.selectedTags.map((tag) {
            return AppText(
              text: '#${tag.name}',
              fontSize: 14.sp,
              color: const Color(0xFF0077FF),
            );
          }).toList(),
        );
      },
    );
  }
}