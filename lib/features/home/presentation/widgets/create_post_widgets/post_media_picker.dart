import 'package:academe_x/core/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/cubits/create_post/create_post_cubit.dart';
import '../../controllers/states/create_post/create_post_state.dart';

class PostMediaPicker extends StatelessWidget {
  const PostMediaPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        final cubit = context.read<CreatePostCubit>();

        return Row(
          children: [
            // Image picker
            _MediaPickerButton(
              icon: 'assets/icons/image.png',
              selected: state.mediaType == MediaType.images,
              onTap: () => cubit.pickImages(),
            ),
            
            8.pw(),
            
            // Document picker
            _MediaPickerButton(
              icon: 'assets/icons/document.png',
              selected: state.mediaType == MediaType.file,
              onTap: () => cubit.pickDocument(),
            ),
            
            8.pw(),
            
            // Poll creator
            _MediaPickerButton(
              icon: 'assets/icons/menu.png',
              selected: state.mediaType == MediaType.poll,
              onTap: () => cubit.togglePollMode(),
            ),
            
            8.pw(),
            
            // Tag selector toggle
            _MediaPickerButton(
              icon: 'assets/icons/hash.png',
              selected: state.showTagSelector,
              onTap: () => cubit.toggleTagSelector(),
            ),
          ],
        );
      },
    );
  }
}

class _MediaPickerButton extends StatelessWidget {
  final String icon;
  final bool selected;
  final VoidCallback onTap;

  const _MediaPickerButton({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      child: CircleAvatar(
        radius: 20.r,
        backgroundColor: selected 
            ? const Color(0xFF0077FF) 
            : Colors.grey[200],
        child: IconButton(
          icon: ImageIcon(
            AssetImage(icon),
            color: selected ? Colors.white : Colors.black,
          ),
          onPressed: onTap,
          iconSize: 20.r,
        ),
      ),
    );
  }
}