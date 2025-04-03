import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/poll_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/poll_state.dart';
import 'package:academe_x/features/home/presentation/widgets/create_post_widgets/create_post.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

class CreateMultiChoiceWidget extends StatefulWidget {
  CreateMultiChoiceWidget({
    super.key,
  });

  @override
  State<CreateMultiChoiceWidget> createState() =>
      _CreateMultiChoiceWidgetState();
}

class _CreateMultiChoiceWidgetState extends State<CreateMultiChoiceWidget> {
  TextEditingController qusController = TextEditingController();
  final List<String> _hintText = [
    'الخيار الأول هنا',
    'الخيار الثاني هنا',
    'خيار اضافي',
  ];
  late int numberOfChoices;
  FocusNode inputNode = FocusNode();
  void openKeyboard() {
    FocusScope.of(context).requestFocus(inputNode);
  }

  late List<TextEditingController> _textControllers;
  @override
  void initState() {
    super.initState();
    _textControllers = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];
    numberOfChoices = 2;
    qusController.text = context.read<PollCubit>().state.question??'';
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<PollCubit>().state.optionContent != null) {
      numberOfChoices = context.read<PollCubit>().state.optionContent!.length;
      for (int i = 0;
          i < context.read<PollCubit>().state.optionContent!.length;
          i++) {
        _textControllers.add(TextEditingController());
        _textControllers[i].text =
            context.read<PollCubit>().state.optionContent![i];
      }
    }
    return Column(
      children: [
        SizedBox(
          height: 0.3.sh,
          child: RawScrollbar(
            thumbVisibility: true,
            thumbColor: Colors.blue.shade100,
            shape: const StadiumBorder(),
            thickness: 6,
            scrollbarOrientation: ScrollbarOrientation.left,
            padding: const EdgeInsets.only(left: 0),
            //controller: PrimaryScrollController.of(context),
            ////controller: _wScrollController,
            minThumbLength: 100,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFieldForCreatePost(
                      postController: qusController,
                      onChange: (v) {
                        context.read<PollCubit>().addQuestionTitle(v);
                      }),
                  for (int i = 0; i < numberOfChoices; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AppTextField(
                        hintText: _hintText[i > 2 ? 2 : i],
                        keyboardType: TextInputType.text,
                        controller: _textControllers[i],
                        withBoarder: true,
                        hintStyle: const TextStyle(
                            color: Color.fromRGBO(59, 186, 166, 1)),
                        autofocus:
                            i + 1 == numberOfChoices && i != 1 ? true : false,
                        textInputAction: i + 1 == numberOfChoices
                            ? TextInputAction.done
                            : TextInputAction.next,
                        onChanged: (content) {
                          context
                              .read<PollCubit>()
                              .onChanges(index: i, content: content);
                        },
                        suffixIcon: i > 1
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    _textControllers.removeAt(i);
                                    numberOfChoices--;
                                    context.read<PollCubit>().deleteOptionAt(i);
                                  });
                                },
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.redAccent,
                                ))
                            : null,
                      ),
                    ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _textControllers.add(TextEditingController());
                        numberOfChoices++;
                        context.read<PollCubit>().addChoice();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        dashPattern: [10, 8],
                        strokeWidth: 1,
                        radius: const Radius.circular(12),
                        color: const Color(0xffD9D9D9),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: AppTextField(
                            hintStyle: const TextStyle(
                                color: Color.fromRGBO(59, 186, 166, 1)),
                            enabled: false,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 12, 10, 12),
                            hintText: _hintText[2],
                            keyboardType: TextInputType.text,
                            controller: _textControllers.last,
                            withBoarder: true,
                            enableBoarderColor: Colors.transparent,
                            fucusBoarderColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  10.ph(),
                ],
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppText(text: 'سيكون هذا التصويت متاح حتى:', fontSize: 14.sp),
              TextButton(onPressed: () {
                showDialog(
                  context: context, // Prevent dismissing by tapping outside
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return DatePickerDialog(
                      firstDate: DateTime.now(),
                      lastDate: DateTime.utc(DateTime.now().year + 2),
                      initialCalendarMode: DatePickerMode.day,
                    );
                  },
                );
                showDialog(
                  context: context, // Prevent dismissing by tapping outside
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return TimePickerDialog(
                      initialTime: TimeOfDay.now(),
                    );
                  },
                ).then(
                  (time) {
                    Logger().d(time);
                    context.read<PollCubit>().changeEndPoll(time: time);
                  },
                );
                showDialog(
                  context: context, // Prevent dismissing by tapping outside
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return DatePickerDialog(
                      firstDate: DateTime.now(),
                      lastDate: DateTime.utc(DateTime.now().year + 2),
                      initialCalendarMode: DatePickerMode.day,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                    );
                  },
                ).then(
                  (date) {
                    Logger().d(date);
                    context.read<PollCubit>().changeEndPoll(date: date);
                  },
                );

                // DatePickerDialog
              }, child: BlocBuilder<PollCubit, PollState>(
                builder: (context, state) {
                  DateTime dateTime = state.endPoll;
                  return Directionality(
                      textDirection: TextDirection.rtl,
                      child: AppText(
                        text:
                            '${dateTime.year}/${dateTime.month}/${dateTime.day}'
                            '  ${dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12}'
                            ':${dateTime.minute} '
                            '${dateTime.hour > 11 && dateTime.hour != 24 ? 'م' : 'ص'}',
                        fontSize: 14.sp,
                        color: Colors.blue,
                      ));
                },
              )),

            ],
          ),
        ),

      ],
    );
  }
}
