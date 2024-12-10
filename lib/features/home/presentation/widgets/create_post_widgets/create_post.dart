import 'dart:io';

import 'package:academe_x/core/core.dart';
import 'package:academe_x/academeX_main.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/auth/domain/entities/response/user_response_entity.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_majors_state.dart';
import 'package:academe_x/features/college_major/data/models/major_model.dart';
import 'package:academe_x/features/home/domain/entities/post/file_info_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/image_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/home/home.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/show_tag_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/tag_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/post/post_state.dart';
import 'package:academe_x/features/home/presentation/widgets/create_post_widgets/chose_tag_widget.dart';

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

  void showCreatePostModal(BuildContext parContext) async {
    int tagId = (await parContext.cachedUser)!.user.tagId;
    MajorModel? userMajor = null;
    UserResponseEntity user = (await parContext.cachedUser)!.user;
    String userName = '${user.firstName} ${user.lastName}';
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
                            context.read<PostsCubit>().cancelCreationPostState();
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
                          child: user.photoUrl == null
                              ? AppText(
                                  text: user.firstName[0],
                                  fontSize: 15,
                                  color: Colors.white,
                                )
                              : Image.network(user.photoUrl!),
                        ),
                        8.pw(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: userName,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            BlocBuilder<CollegeMajorsCubit, CollegeMajorsState>(
                              builder: (context, state) {

                                if(state.status == MajorsStatus.success) {

                                  userMajor = getUserMajor(parContext, state.majors,tagId);
                                  context.read<TagCubit>().init(userMajor!);
                                  return AppText(
                                    text:  '${userMajor!.majorEn!.replaceAll(' ', '_')}#',
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  );
                                }
                                return AppText(
                                  text: 'نحاول الحصول على tag',
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                );
                              },

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
                      // buildWhen: (previous, current) {
                      //   return previous.toString() != current.toString();
                      // },

                      builder: (context, state) {
                        Logger().f(state);
                        if (state is SuccessTagState) {

                          getIt<SuccessTagState>().selectedTags = state.selectedTags;

                          return Wrap(
                            spacing: 3, // Space between buttons horizontally
                            runSpacing: 0,
                            children: List.generate(state.selectedTags.length,
                                (index) {
                              return AppText(
                                text: state.selectedTags[index].collegeEn !=
                                        null
                                    ? '${state.selectedTags[index].majorEn!}#'
                                        .replaceAll(' ', '_')
                                    : '',
                                fontSize: 14.sp,
                                color: const Color(0xff0077FF),
                              );
                            }),
                          );
                        }
                        return const SizedBox();
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
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 9.w),
                                            height: 178.w,
                                            width:
                                                images!.length == 1 ? 300 : 178,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.all(
                                                      Radius.circular(12.r)),
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
                              IconBottomForCreatePost(
                                selected:
                                    getIt<ImagePickerLoaded>().images != null,
                                imagePath: 'assets/icons/image.png',
                                onPressed: () {
                                  context.read<PickerCubit>().pickImage();
                                },
                              ),
                              IconBottomForCreatePost(
                                selected:
                                    getIt<FilePickerLoaded>().file != null,
                                imagePath: 'assets/icons/document.png',
                                onPressed: () {
                                  context.read<PickerCubit>().pickFile();
                                },
                              ),
                              IconBottomForCreatePost(
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
                            return IconBottomForCreatePost(
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

  MajorModel getUserMajor(BuildContext context, tags,int tagId) {
    for(int i =0;i<tags.length;i++){
      if(tags[i].id == tagId) return tags[i];
    }
    throw ValidationException(messages: ['we don\'t find your tag']);

  }
}

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  PostEntity post;
  final TextEditingController textController;
  SubmitButton({
    super.key,
    required this.formKey,
    required this.post,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<PostsCubit, PostsState>(
      listener: (createPostContext, state) {
        if (state.creationState == CreationStatus.failure) {
          context.showSnackBar(message: state.creationPostErrorMessage!, error: true);
        } else if (state.creationState == CreationStatus.success) {
          Navigator.pop(context);
          context.showSnackBar(message: 'تم نشر منشورك بنجاح', error: false);
        }
      },
      builder: (context, state) {
        if (state.creationState == CreationStatus.failure) Logger().e(state.creationPostErrorMessage);
        return Column(
          children: [
            if (state.creationState == CreationStatus.failure)
              AppText(
                text: state.creationPostErrorMessage!,
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: Colors.red,
              ),
            GestureDetector(
              onTap: state.creationState != CreationStatus.loading
                  ? () {
                      if (formKey.currentState!.validate()) {
                        post = post.copyWith(
                            images: getIt<ImagePickerLoaded>()
                                .images
                                ?.map(
                                  (e) => ImageEntity(id: 0, url: e.path),
                                )
                                .toList(),
                            file: getIt<FilePickerLoaded>().file == null
                                ? null
                                : FileInfo(
                                    url: getIt<FilePickerLoaded>().file!.path,
                                  ),
                            tags:getIt<SuccessTagState>().selectedTags,
                        );

                        Logger().f(post.tags);
                        context.read<PostsCubit>().sendPost(
                            post: post.copyWith(content: textController.text,));
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
                  child: state.creationState != CreationStatus.loading
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

class IconBottomForCreatePost extends StatelessWidget {
  final bool selected;
  final String imagePath;
  final void Function()? onPressed;
  const IconBottomForCreatePost(
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
