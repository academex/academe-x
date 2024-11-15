import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/show_tag_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/tag_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/tag_state.dart';
import 'package:academe_x/features/home/presentation/widgets/create_post_widgets/chose_tag_widget.dart';
import 'package:academe_x/lib.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'create_multi_choice_widget.dart';
import 'file_container.dart';

class CreatePost {
  final TextEditingController _postController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

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
                          color: Color(0xffE7E8EA),
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
                    SizedBox(height: 16),
                    AppTextField(
                      withBoarder: false,
                      maxLine: null,
                      controller: _postController,
                      hintText: 'قم بكتابة ما تريد الاستفسار عنه ..',
                      keyboardType: TextInputType.multiline,
                      focusNode: _focusNode,
                      suffix: GestureDetector(
                        onTap: () {
                          _postController.clear();
                        },
                        child: Icon(Icons.clear, color: Colors.grey),
                      ),
                    ),
                    // need if statment as : if(textController.isNotEmpty) do the loop
                    // for loop for the hashes
                    BlocBuilder<TagCubit, TagState>(
                      builder: (context, state) {
                        return Wrap(
                          spacing: 3, // Space between buttons horizontally
                          runSpacing: 0,
                          children:
                              List.generate(state.selectedTags.length, (index) {
                            return AppText(
                              text: state.selectedTags[index],
                              fontSize: 14.sp,
                              color: const Color(0xff0077FF),
                            );
                          }),
                        );
                      },
                    ),
                    // for (int i = 0; i < 1; i++)
                    //   AppText(
                    //     text: '   ' + '#تطوير برمجيات',
                    //     fontSize: 14,
                    //     color: const Color(0xff0077FF),
                    //   ),
                    SizedBox(height: 16),
                    BlocBuilder<PickerCubit, CreatePostIconsState>(
                      builder: (context, state) {
                        if (state is ImagePickerLoaded) {
                          return Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: [
                                for (int index = 0;
                                    index < state.images.length;
                                    index++)
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 9),
                                    height: 178,
                                    width: state.images.length == 1 ? 300 : 178,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      image: DecorationImage(
                                        image: FileImage(state.images[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              ]),
                            ),
                          );
                        } else if (state is FilePickerLoaded) {
                          return FileContainer(file: state.file);
                        } else if (state is CreateMultiChoice) {
                          AppLogger.i(state.toString());
                          return CreateMultiChoiceWidget();
                        } else {
                          return 0.ph();
                        }
                      },
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const ImageIcon(
                              AssetImage('assets/icons/image.png')),
                          onPressed: () {
                            context.read<PickerCubit>().pickImage();
                          },
                        ),
                        IconButton(
                          icon: const ImageIcon(
                              AssetImage('assets/icons/document.png')),
                          onPressed: () {
                            context.read<PickerCubit>().pickFile();
                          },
                        ),
                        IconButton(
                          icon: const ImageIcon(
                              AssetImage('assets/icons/menu.png')),
                          onPressed: () {
                            AppLogger.success('hello');
                            context.read<PickerCubit>().createMulteChoice();
                          },
                        ),
                        BlocBuilder<ShowTagCubit, bool>(
                          builder: (context, state) {
                            return CircleAvatar(
                              backgroundColor:
                                  state ? Colors.blue : Colors.transparent,
                              child: IconButton(
                                color: state ? Colors.white : Colors.black,
                                icon: ImageIcon(
                                  const AssetImage(
                                    'assets/icons/hash.png',
                                  ),
                                  size: 17.r,
                                ),
                                onPressed: () {
                                  context.read<ShowTagCubit>().changeState();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    BlocBuilder<ShowTagCubit, bool>(
                      builder: (context, state) {
                        if (state) {
                          return SelectableButtonGrid();
                        } else {
                          return const Spacer();
                        }
                      },
                    ),
                    // const Spacer(),
                    10.ph(),
                    GestureDetector(
                      onTap: () {
                        // Handle post submission
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(
                              0xFF007AFF), // Blue color for the post button
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: AppText(
                            text: 'نشر',
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
