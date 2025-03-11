import 'dart:io';

import 'package:academe_x/academeX_main.dart';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/auth/domain/entities/response/user_response_entity.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_majors_state.dart';
import 'package:academe_x/features/college_major/data/models/major_model.dart';
import 'package:academe_x/features/home/domain/entities/post/file_info_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/image_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/home/home.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/poll_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/show_tag_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/tag_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/poll_state.dart';
import 'package:academe_x/features/home/presentation/controllers/states/post/post_state.dart';
import 'package:academe_x/features/home/presentation/widgets/create_post_widgets/chose_tag_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import 'create_multi_choice_widget.dart';
import 'file_container.dart';

class CreatePost {
  PostEntity post =  PostEntity();
  final _formKey = GlobalKey<FormState>();


  void showCreatePostModal(BuildContext parContext) async {
    int tagId = (await parContext.cachedUser)!.user.tagId!;

    UserResponseEntity user = (await parContext.cachedUser)!.user;
    showModalBottomSheet(
      context: parContext,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 24.w,
              right: 24.w,
              top: 16.h,
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                height: 0.85.sh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CenterDivider(),
                    10.ph(),
                    const TitleWithCancel(),
                    16.ph(),
                    UserInfo(user: user,context: parContext,tagId:tagId),
                    16.ph(),
                    TextFieldForCreatePost(formKey: _formKey, postController: context.read<PickerCubit>().state.postController),
                    const ShowSelectedTags(),
                    16.ph(),
                    ShowImagesAndFileAndMultiChoice(),
                    7.ph(),
                    const IconChoices(),
                    // select one tag
                    BlocBuilder<ShowTagCubit, bool>(
                      builder: (context, state) {
                        if (state) {
                          return Expanded(child: SelectableButtonGrid(userTagId: tagId,));
                        } else {
                          return const Spacer();
                        }
                      },
                    ),
                    SubmitButton(
                        formKey: _formKey,
                        post: post,
                        textController: context.read<PickerCubit>().state.postController,
                    ),
                    // 5.ph(),
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

class IconChoices extends StatelessWidget {
  const   IconChoices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<PickerCubit, PickState>(
          builder: (context, state) => Row(
            children: [
              IconBottomForCreatePost(
                selected:
                    state.images.isNotEmpty,
                imagePath: 'assets/icons/image.png',
                onPressed: () {
                  context.read<PickerCubit>().pickImage(context);
                },
              ),
              IconBottomForCreatePost(
                selected:
                    state.file.isNotEmpty,
                imagePath: 'assets/icons/document.png',
                onPressed: () {
                  context.read<PickerCubit>().pickFile();
                },
              ),
              IconBottomForCreatePost(
                selected: state.status == Status.multiChoice,
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
    );
  }
}

class ShowImagesAndFileAndMultiChoice extends StatelessWidget{
  late List<File> images;
  late List<File> file;

   ShowImagesAndFileAndMultiChoice({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickerCubit, PickState>(
      // buildWhen: (previous, current) {

        // return current is! CreatePostIconsLoading;
      // },
      builder: (context, state) {
        // Logger().f(state);
        images = state.images;
        file = state.file;
        if (state.status == Status.pickers) {
          // context.read<PollCubit>().addQuestionTitle('title');
          Logger().d(context.read<PollCubit>().state.question);
          return Column(
            children: [
              if (images.isNotEmpty || context.read<PickerCubit>().state.statusResize == StatusResize.loading) ImageContainer(images: images),
              10.ph(),
              if (file.isNotEmpty) FileContainer(file: file.first),
              10.ph(),
              BlocBuilder<PollCubit, PollState>(
                builder: (context, state) {
                  if (state.question != null &&
                      state.question != '') {
                    return FileContainer(
                      question: context.read<PollCubit>().state.question,
                    );
                  }else{
                    return const SizedBox();
                  }
                },
              ),
            ],
          );
        }
        else if (state.status == Status.multiChoice) {
          return CreateMultiChoiceWidget();
        } else {
          return 0.ph();
        }
      },
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.images,
  });

  final List<File>? images;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if(context.read<PickerCubit>().state.statusResize == StatusResize.loading)
          AppText(text: context.read<PickerCubit>().state.bytes.toString(), fontSize: 12.sp),
        for (int index = 0; index < images!.length; index++)
          Stack(
            children: [

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
              Positioned(
                left: 0,
                top: -10,
                child: Container(
                  width: 40,
                  height: 40,

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.white),
                  child: Center(
                    child: IconButton(onPressed: () {
                      context.read<PickerCubit>().removeImageAt(index);
                    }, icon: const Icon(Icons.clear,color: Colors.red)),
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

class ShowSelectedTags extends StatelessWidget {
  const ShowSelectedTags({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagCubit, TagState>(
      builder: (context, state) {
        // Logger().f(state);
        if (state is SuccessTagState) {
          // getIt<SuccessTagState>().selectedTags = state.selectedTags;
          return Wrap(
            spacing: 15, // Space between buttons horizontally
            runSpacing: 0,
            children: List.generate(state.selectedTags.length,
                (index) {
              return AppText(
                text: state.selectedTags[index].name !=
                        null
                    ? '${state.selectedTags[index].name!}#'
                    : '',
                fontSize: 14.sp,
                color: const Color(0xff0077FF),
              );
            }),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class TextFieldForCreatePost extends StatelessWidget {
  const TextFieldForCreatePost({
    super.key,
    GlobalKey<FormState>? formKey,
    required TextEditingController postController,
    this.onChange,
  }) : _formKey = formKey, _postController = postController;

  final GlobalKey<FormState>? _formKey;
  final TextEditingController _postController;
  final void Function(String value)? onChange;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AppTextField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        withBoarder: false,
        maxLine: 2,
        controller: _postController,
        hintText: onChange != null
            ? 'قم بكتبة سؤالك...'
            : 'قم بكتابة ما تريد الاستفسار عنه ..',
        keyboardType: TextInputType.multiline,
        onChanged: onChange,
        suffix: GestureDetector(
          onTap: () {
            _postController.clear();
            if (onChange != null) {
              context.read<PollCubit>().addQuestionTitle('');
            }
          },
          child: const Icon(Icons.clear, color: Colors.grey),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget{
  final UserResponseEntity user;
  final BuildContext context;
  final int tagId;
  const UserInfo({super.key, required this.user,required this.context,required this.tagId});

  @override
  Widget build(BuildContext context) {
    String userName = '${user.firstName} ${user.lastName}';

    return Row(
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

                  MajorModel? userMajor = getUserMajor(state.majors,tagId);
                  context.read<TagCubit>().init(userMajor);
                  return AppText(
                    text:  '${userMajor.name}#',
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
    );
  }

  MajorModel getUserMajor(tags,int tagId) {
    for(int i =0;i<tags.length;i++){
      if(tags[i].id == tagId) return tags[i];
    }
    throw ValidationException(messages: ['we don\'t find your tag']);

  }
}


class TitleWithCancel extends StatelessWidget {
  const TitleWithCancel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.,
      children: [
        Expanded(
          child: AppText(
            text: 'الغاء',
            fontSize: 14.sp,
            color: Colors.green,
            onPressed: () {
              context.read<PostsCubit>().cancelCreationPostState();
              context.read<PickerCubit>().init();
              context.read<PollCubit>().clear();
              Navigator.pop(context);
            },
          ),
        ),
        Expanded(
          child: AppText(
            text: 'إنشاء بوست',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
        ),
        const Expanded(
          child: SizedBox()
        ),

        // const Expanded(child: SizedBox(width: 70,)),

      ],
    );
  }
}

class CenterDivider extends StatelessWidget {
  const CenterDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 56,
        height: 5,
        decoration: BoxDecoration(
          color: const Color(0xffE7E8EA),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
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


    return BlocBuilder<PostsCubit, PostsState>(

      builder: (context, state) {
        if (state.creationState == CreationStatus.failure) {
          Logger().e(state.creationPostErrorMessage);
        }
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
                            images: context.read<PickerCubit>().state.images
                                .map(
                                  (e) => ImageEntity(id: 0, url: e.path),
                                )
                                .toList(),
                            file: context.read<PickerCubit>().state.file.isEmpty
                                ? null
                                : FileInfo(
                                    url: context.read<PickerCubit>().state.file.first.path,
                                  ),
                            tags:getIt<TagCubit>().getSelectedTags(),
                        );

                        context.read<PostsCubit>().sendPost(context:context,
                            post: post.copyWith(content: textController.text,));
                        Navigator.pop(context);
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
