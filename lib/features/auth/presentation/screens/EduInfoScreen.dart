import 'package:academe_x/features/auth/presentation/widgets/progress_bar_with_close_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/const/app_robot.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/extensions/sized_box_extension.dart';
import '../widgets/custom_button.dart';
import '../widgets/robot_with_speech_bubble.dart';

class EduInfoScreen extends StatefulWidget {
  const EduInfoScreen({Key? key}) : super(key: key);

  @override
  _EduInfoScreenState createState() => _EduInfoScreenState();
}

class _EduInfoScreenState extends State<EduInfoScreen> {
  // Track the selected option for each category
  String? selectedCollege="";
  String? selectedYear;
  String? selectedTerm;

  final List<String> colleges = [
    "هندسة",
    "طب",
    "تجارة",
    "IT",
    "محاسبة",
    "صحافة",
    "إنجليش",
    "شريعة",
    "بصريات",
  ];

  final List<String> studyYears = [
    "سنة أولى",
    "سنة ثانية",
    "سنة ثالثة",
    "سنة رابعة",
  ];

  final List<String> terms = [
    "الأول",
    "الثاني",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            40.ph(),
            ProgressBarWithCloseButton(onClose: () {

            },
            progressValue: 1,),
            19.ph(),
            const RobotWithSpeechBubble(svgString: myEduInfoRobotSVG, speechText: 'مستوى تعليمي'),
            20.ph(),
            _buildSelectionGrid("الكلية", colleges, selectedCollege, (value) {
              setState(() {
                print('object');
                selectedCollege = value;
              });
            }),
            20.ph(),
            _buildSelectionGrid("سنة الدراسة الحالية", studyYears, selectedYear, (value) {
              setState(() {
                selectedYear = value;
              });
            }),
            20.ph(),
            _buildSelectionGrid("الفصل الدراسي", terms, selectedTerm, (value) {
              setState(() {
                selectedTerm = value;
              });
            }),
            24.ph(),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, '/account_creation');

                // Add logic to create account
              },
              widget: AppText(
                text: 'إنشاء حسابي',
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              color: Colors.blueAccent,
            ),
            16.ph(),
            _buildBottomText(context),
            20.ph(),
          ],
        ),
      ),
    );
  }

  // Widget to build the top progress bar
  // Widget _buildProgressBar(BuildContext context) {
  //   return SizedBox(
  //     height: 50.h,
  //     child: Stack(
  //       children: [
  //         Positioned.fill(
  //           right: 40,
  //           child: Align(
  //             alignment: Alignment.center,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(10),
  //               child: SizedBox(
  //                 height: 10.h,
  //                 width: 284.w,
  //                 child: LinearProgressIndicator(
  //                   value: 1,
  //                   minHeight: 16.h,
  //                   backgroundColor: Colors.grey[200],
  //                   color: const Color(0xff5DCA14),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           right: 0,
  //           child: IconButton(
  //             icon: Icon(Icons.close, size: 24.w, color: Colors.black),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget to build the selection grid
  Widget _buildSelectionGrid(String title, List<String> options, String? selectedOption, Function(String) onSelected) {
    // print(options.length);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        16.ph(),
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:options.length==9 ? 3 :2 ,
            childAspectRatio: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
          ),
          itemCount: options.length,
          itemBuilder: (context, index) {
            return _buildSelectableOption(
              options[index],
              isSelected: options[index] == selectedOption,
              onTap: () => onSelected(options[index]),
            );
          },
        )
      ],
    );
  }

  // Widget to build each selectable option
  Widget _buildSelectableOption(String text, {required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 101.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? Colors.blueAccent : Colors.transparent,
            width: 1.5.w,
          ),
        ),
        child: Center(
          child: AppText(
            text: text,
            fontSize: 14.sp,
            color: isSelected ? Colors.blueAccent : Colors.black87,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Widget to build the "Create Account" Button
  // Widget _buildCreateAccountButton() {
  //   return ;
  // }

  // Widget to build the Bottom Text with "تسجيل الدخول" link
  Widget _buildBottomText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: 'لدي حساب بالفعل ؟',
          fontSize: 14.sp,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          child: AppText(
            text: ' تسجيل الدخول',
            fontSize: 14.sp,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
