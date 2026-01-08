import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/core.dart';
import '../../controllers/cubits/create_post/create_post_cubit.dart';
import '../../controllers/states/create_post/create_post_state.dart';

class PostContentInput extends StatefulWidget {
  const PostContentInput({Key? key}) : super(key: key);

  @override
  State<PostContentInput> createState() => _PostContentInputState();
}

class _PostContentInputState extends State<PostContentInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostCubit, CreatePostState>(
      listenWhen: (previous, current) => previous.content != current.content,
      listener: (context, state) {
        // Sync controller with state if needed
        if (_controller.text != state.content) {
          _controller.text = state.content;
        }
      },
      child: AppTextField(
        controller: _controller,
        focusNode: _focusNode,
        hintText: 'قم بكتابة ما تريد الاستفسار عنه...',
        keyboardType: TextInputType.multiline,
        maxLine: 8,
        minLine: 3,
        withBoarder: false,
        onChanged: (value) {
          context.read<CreatePostCubit>().updateContent(value);
        },
        suffix: _controller.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  _controller.clear();
                  context.read<CreatePostCubit>().updateContent('');
                },
                child: const Icon(Icons.clear, color: Colors.grey),
              )
            : null,
      ),
    );
  }
}