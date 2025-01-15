import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/poll_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/poll_state.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateMultiChoiceWidget extends StatefulWidget {
  CreateMultiChoiceWidget({
    super.key,
  });

  @override
  State<CreateMultiChoiceWidget> createState() =>
      _CreateMultiChoiceWidgetState();
}

class _CreateMultiChoiceWidgetState extends State<CreateMultiChoiceWidget> {
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PollCubit>(
      create: (context) => PollCubit(PollState()),
      child: SizedBox(
        height: 0.3.sh,
        child: RawScrollbar(
          thumbVisibility: true,
          thumbColor: Colors.blue.shade100,
          shape: const StadiumBorder(),
          thickness: 6,
          scrollbarOrientation: ScrollbarOrientation.left,
          padding: EdgeInsets.only(left: 0),
          //controller: PrimaryScrollController.of(context),
          ////controller: _wScrollController,
          minThumbLength: 100,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < numberOfChoices; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: AppTextField(
                      hintText: _hintText[i > 2 ? 2 : i],
                      keyboardType: TextInputType.text,
                      controller: _textControllers[i],
                      withBoarder: true,
                      hintStyle:
                          const TextStyle(color: Color.fromRGBO(59, 186, 166, 1)),
                      autofocus:
                          i + 1 == numberOfChoices && i != 1 ? true : false,
                      textInputAction: i + 1 == numberOfChoices
                          ? TextInputAction.done
                          : TextInputAction.next,
                      onChanged: (content) {
                        context.read<PollCubit>().onChanges(index: i, content: content);
                      },
                    ),
                  ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _textControllers.add(TextEditingController());
                      numberOfChoices++;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      dashPattern: [10, 8],
                      strokeWidth: 1,
                      radius: Radius.circular(12),
                      color: const Color(0xffD9D9D9),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: AppTextField(
                          hintStyle:
                              TextStyle(color: Color.fromRGBO(59, 186, 166, 1)),
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
    );
  }
}
