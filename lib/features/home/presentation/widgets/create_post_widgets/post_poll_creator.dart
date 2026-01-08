import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../../../core/core.dart';
import '../../controllers/cubits/create_post/create_post_cubit.dart';
import '../../controllers/states/create_post/create_post_state.dart';

class PostPollCreator extends StatefulWidget {
  const PostPollCreator({Key? key}) : super(key: key);

  @override
  State<PostPollCreator> createState() => _PostPollCreatorState();
}

class _PostPollCreatorState extends State<PostPollCreator> {
  late TextEditingController _questionController;
  late List<TextEditingController> _optionControllers;

  @override
  void initState() {
    super.initState();
    final state = context.read<CreatePostCubit>().state;
    
    _questionController = TextEditingController(text: state.pollQuestion);
    _optionControllers = state.pollOptions
        .map((option) => TextEditingController(text: option))
        .toList();
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        // Sync controllers if options length changed
        while (_optionControllers.length < state.pollOptions.length) {
          _optionControllers.add(TextEditingController());
        }
        while (_optionControllers.length > state.pollOptions.length) {
          _optionControllers.removeLast().dispose();
        }

        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F8),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Poll icon and title
              Row(
                children: [
                  const Icon(Icons.poll, color: Color(0xFF0077FF)),
                  8.pw(),
                  AppText(
                    text: 'إنشاء استطلاع رأي',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              
              16.ph(),
              
              // Question input
              AppTextField(
                controller: _questionController,
                hintText: 'اكتب سؤالك هنا...',
                keyboardType: TextInputType.text,
                withBoarder: true,
                onChanged: (value) {
                  context.read<CreatePostCubit>().updatePollQuestion(value);
                },
              ),
              
              16.ph(),
              
              // Options
              ...List.generate(
                state.pollOptions.length,
                (index) => _buildPollOption(context, index, state),
              ),
              
              12.ph(),
              
              // Add option button
              if (state.pollOptions.length < 10)
                _buildAddOptionButton(context),
              
              16.ph(),
              
              // End date picker
              _buildEndDatePicker(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPollOption(BuildContext context, int index, CreatePostState state) {
    final isFirst = index == 0;
    final isSecond = index == 1;
    final canRemove = index > 1;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: AppTextField(
        controller: _optionControllers[index],
        hintText: _getOptionHint(index),
        keyboardType: TextInputType.text,
        withBoarder: true,
        hintStyle: const TextStyle(
          color: Color(0xFF3BBAA6),
        ),
        autofocus: !isFirst && !isSecond,
        textInputAction: index == state.pollOptions.length - 1
            ? TextInputAction.done
            : TextInputAction.next,
        onChanged: (value) {
          context.read<CreatePostCubit>().updatePollOption(index, value);
        },
        suffixIcon: canRemove
            ? IconButton(
                onPressed: () {
                  context.read<CreatePostCubit>().removePollOption(index);
                },
                icon: const Icon(Icons.close, color: Colors.red),
              )
            : null,
      ),
    );
  }

  Widget _buildAddOptionButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CreatePostCubit>().addPollOption();
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: const [10, 8],
        strokeWidth: 1,
        radius: Radius.circular(12.r),
        color: const Color(0xFFD9D9D9),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add, color: Color(0xFF3BBAA6)),
              8.pw(),
              AppText(
                text: 'إضافة خيار',
                fontSize: 14.sp,
                color: const Color(0xFF3BBAA6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEndDatePicker(BuildContext context, CreatePostState state) {
    return Row(
      children: [
        Expanded(
          child: AppText(
            text: 'سيكون هذا التصويت متاح حتى:',
            fontSize: 12.sp,
            color: Colors.grey[600]!,
          ),
        ),
        
        TextButton(
          onPressed: () => _showDateTimePicker(context),
          child: AppText(
            text: _formatEndDate(state.pollEndDate),
            fontSize: 12.sp,
            color: const Color(0xFF0077FF),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _getOptionHint(int index) {
    if (index == 0) return 'الخيار الأول';
    if (index == 1) return 'الخيار الثاني';
    return 'خيار إضافي';
  }

  String _formatEndDate(DateTime? date) {
    if (date == null) return 'اختر التاريخ';
    
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final period = date.hour >= 12 ? 'م' : 'ص';
    
    return '${date.year}/${date.month}/${date.day} - $hour:${date.minute.toString().padLeft(2, '0')} $period';
  }

  Future<void> _showDateTimePicker(BuildContext context) async {
    // Show date picker
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date == null || !mounted) return;

    // Show time picker
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null || !mounted) return;

    // Update end date
    context.read<CreatePostCubit>().updatePollEndDate(date, time);
  }
}