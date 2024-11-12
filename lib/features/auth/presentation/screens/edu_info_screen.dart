import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class EduInfoScreen extends StatefulWidget {
  const EduInfoScreen({super.key});

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
        padding: EdgeInsets.symmetric(horizontal: 24   ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            40.ph(),
            ProgressBarWithCloseButton(onClose: () {

            },
            progressValue: 1,),
            19.ph(),
             // RobotWithSpeechBubble(svgString: myEduInfoRobotSVG, speechText: context.localizations.educationalLevel,),
            20.ph(),
            _buildSelectionGrid(context.localizations.collegeLabel, colleges, selectedCollege, (value) {
              setState(() {
                print('object');
                selectedCollege = value;
              });
            }),
            20.ph(),
            _buildSelectionGrid(context.localizations.currentYearLabel, studyYears, selectedYear, (value) {
              setState(() {
                selectedYear = value;
              });
            }),
            20.ph(),
            _buildSelectionGrid(context.localizations.semesterLabel, terms, selectedTerm, (value) {
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
                text:context.localizations.createAccountButton,
                fontSize: 14 ,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              backgraoundColor: Colors.blueAccent,
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
  //     height: 50    ,
  //     child: Stack(
  //       children: [
  //         Positioned.fill(
  //           right: 40,
  //           child: Align(
  //             alignment: Alignment.center,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(10),
  //               child: SizedBox(
  //                 height: 10    ,
  //                 width: 284.w,
  //                 child: LinearProgressIndicator(
  //                   value: 1,
  //                   minHeight: 16    ,
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
          fontSize: 16 ,
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
            crossAxisSpacing: 10   ,
            mainAxisSpacing: 10   ,
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
        width: 101   ,
        height: 60   ,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.blueAccent : Colors.transparent,
            width: 1.5   ,
          ),
        ),
        child: Center(
          child: AppText(
            text: text,
            fontSize: 14 ,
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
          text: context.localizations.already_have_account,
          fontSize: 14 ,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          child: AppText(
            text: context.localizations.loginTitle,
            fontSize: 14 ,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
