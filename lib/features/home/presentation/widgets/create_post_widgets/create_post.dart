import 'dart:io';

import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/create_post_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/show_tag_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/tag_cubit.dart';
import 'package:academe_x/features/home/presentation/widgets/create_post_widgets/chose_tag_widget.dart';
import 'package:academe_x/lib.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import 'create_multi_choice_widget.dart';
import 'file_container.dart';

class CreatePost {
  final TextEditingController _postController = TextEditingController();
  PostEntity post = const PostEntity();
  final _formKey = GlobalKey<FormState>();
  List<File>? images = null;
  File? file = null;

  void showCreatePostModal(BuildContext parContext) {
    showModalBottomSheet(
      context: parContext,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9, // Modal height factor
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 24,
              right: 24,
              top: 16,
            ), // Adjust for keyboard and padding
            child: SingleChildScrollView(
              child: SizedBox(
                height: 0.85.sh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top handle to indicate drag
                    Center(
                      child: Container(
                        width: 56,
                        height: 5,
                        decoration: BoxDecoration(
                          color: const Color(0xffE7E8EA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    16.ph(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: 'الغاء',
                          fontSize: 14,
                          color: Colors.green,
                          onPressed: () {
                            AppLogger.i('message');
                            Navigator.pop(context);
                          },
                        ),
                        AppText(
                          text: 'إنشاء بوست',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        // You can add another icon or widget here if needed
                        50.ph(), // Placeholder for alignment
                      ],
                    ),
                    16.ph(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          child: AppText(
                            text: 'إ',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        8.ph(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: 'إبراهيم',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            AppText(
                              text: '#تطوير البرمجيات',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                    16.ph(),
                    Form(
                      key: _formKey,
                      child: AppTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        withBoarder: false,
                        maxLine: null,
                        controller: _postController,
                        hintText: 'قم بكتابة ما تريد الاستفسار عنه ..',
                        keyboardType: TextInputType.multiline,
                        suffix: GestureDetector(
                          onTap: () {
                            _postController.clear();
                          },
                          child: const Icon(Icons.clear, color: Colors.grey),
                        ),
                      ),
                    ),
                    // need if statment as : if(textController.isNotEmpty) do the loop
                    // for loop for the hashes
                    BlocBuilder<TagCubit, TagState>(
                      builder: (context, state) {
                        post = post.copyWith(
                            tags: state.selectedTags
                                .map(
                                  (e) => e,
                                )
                                .toList());
                        return Wrap(
                          spacing: 3, // Space between buttons horizontally
                          runSpacing: 0,
                          children:
                              List.generate(state.selectedTags.length, (index) {
                            return AppText(
                              text: state.selectedTags[index].name,
                              fontSize: 14.sp,
                              color: const Color(0xff0077FF),
                            );
                          }),
                        );
                      },
                    ),
                    16.ph(),
                    BlocBuilder<PickerCubit, PickState>(
                      builder: (context, state) {
                        images = getIt<ImagePickerLoaded>().images;
                        file = getIt<FilePickerLoaded>().file;
                        if (state is ImagePickerLoaded ||
                            state is FilePickerLoaded ||
                            state is CreatePostIconsInit) {
                          return Expanded(
                            flex: (images == null && file == null)
                                ? 0
                                : (images != null && file != null)
                                    ? 13
                                    : (images != null)
                                        ? 7
                                        : 2,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  if (images != null)
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(children: [
                                        for (int index = 0;
                                            index < images!.length;
                                            index++)
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 9),
                                            height: 178,
                                            width:
                                                images!.length == 1 ? 300 : 178,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12)),
                                              image: DecorationImage(
                                                image:
                                                    FileImage(images![index]),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                      ]),
                                    ),
                                  10.ph(),
                                  if (file != null) FileContainer(file: file),
                                ],
                              ),
                            ),
                          );
                        }
                        // else if (state is FilePickerLoaded) {
                        //   return FileContainer(file: getIt<FilePickerLoaded>().file);
                        // }
                        else if (state is CreateMultiChoice) {
                          AppLogger.i(state.toString());
                          return CreateMultiChoiceWidget();
                        } else {
                          return 0.ph();
                        }
                      },
                    ),
                    Row(
                      children: [
                        BlocBuilder<PickerCubit, PickState>(
                          builder: (context, state) => Row(
                            children: [
                              IconButtomForCreatePost(
                                selected:
                                    getIt<ImagePickerLoaded>().images != null,
                                imagePath: 'assets/icons/image.png',
                                onPressed: () {
                                  context.read<PickerCubit>().pickImage();
                                },
                              ),
                              IconButtomForCreatePost(
                                selected:
                                    getIt<FilePickerLoaded>().file != null,
                                imagePath: 'assets/icons/document.png',
                                onPressed: () {
                                  context.read<PickerCubit>().pickFile();
                                },
                              ),
                              IconButtomForCreatePost(
                                selected: state is CreateMultiChoice,
                                imagePath: 'assets/icons/menu.png',
                                onPressed: () {
                                  context
                                      .read<PickerCubit>()
                                      .createMultiChoice();
                                },
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<ShowTagCubit, bool>(
                          builder: (context, state) {
                            return IconButtomForCreatePost(
                              selected: state,
                              imagePath: 'assets/icons/hash.png',
                              onPressed: () {
                                context.read<ShowTagCubit>().changeState();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    BlocBuilder<ShowTagCubit, bool>(
                      builder: (context, state) {
                        if (state) {
                          return Expanded(child: SelectableButtonGrid());
                        } else {
                          return const Spacer(
                            flex: 5,
                          );
                        }
                      },
                    ),
                    // const Spacer(),
                    10.ph(),
                    SubmitButton(
                        formKey: _formKey,
                        post: post,
                        textController: _postController),
                    20.ph(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final PostEntity post;
  final TextEditingController textController;
  const SubmitButton({
    required this.formKey,
    required this.post,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePostCubit, CreatePostState>(
      listener: (createPostContext, state) {
        AppLogger.d(state.toString());
        if (state is FailureState) {
          context.showSnackBar(message: state.errorMessage, error: true);
        } else if (state is SuccessState) {
          Navigator.pop(context);
          context.showSnackBar(message: 'تم نشر منشورك بنجاح', error: false);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            if (state is FailureState)
              AppText(
                text: state.errorMessage,
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: Colors.red,
              ),
            GestureDetector(
              onTap: state is! SendingState
                  ? () {
                      if (formKey.currentState!.validate()) {
                        context.read<CreatePostCubit>().sendPost(
                            post: post.copyWith(content: textController.text));
                      }
                    }
                  : null,
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color:
                      const Color(0xFF007AFF), // Blue color for the post button
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: state is! SendingState
                      ? AppText(
                          text: 'نشر',
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )
                      : SizedBox(
                          // height: 50,
                          // width: 50,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue),
                          ),
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class IconButtomForCreatePost extends StatelessWidget {
  final bool selected;
  final String imagePath;
  final void Function()? onPressed;
  const IconButtomForCreatePost(
      {required this.selected,
      required this.imagePath,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      child: CircleAvatar(
        backgroundColor: selected ? Colors.blue : Colors.transparent,
        child: IconButton(
          color: selected ? Colors.white : Colors.black,
          icon: ImageIcon(
            AssetImage(
              imagePath,
            ),
            // size: 17.r,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
