import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';



class BuildHeaderContent extends StatelessWidget {
  bool inScroll;
   BuildHeaderContent({required this.inScroll,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        inScroll ? 0.ph() : 40.ph(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24   ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BuildLogoContainer(),
                  8.pw(),
                  BuildTitleAndSubtitle(inScroll: inScroll),
                  const Spacer(),
                  BuildIconButton(iconPath: 'assets/icons/filter.png',inScroll:inScroll),
                ],
              ),
              16.ph(),
              AppText(
                text: 'المواد الخاصة بي',
                fontSize: 16  ,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              20.ph(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 24   ),
          child: SizedBox(
            height: 40,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 70   ,
                          height: 40,
                          decoration: BoxDecoration(
                            // image:
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10 )),
                          child: Center(
                            child: Text('data'),
                          ),
                        ),
                        onTap: () {
                          // context
                          //     .read<CategoryCubit>()
                          //     .selectCategory(index);
                        },
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return 10.pw();
                },
                itemCount: 5),
          ),
        ),
      ],
    );
  }
}
