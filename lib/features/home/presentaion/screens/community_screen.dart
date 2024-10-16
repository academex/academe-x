import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/action_button.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 5.0,
          child: SizedBox(
            height: 112.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side of the navigation bar
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildNavItem('assets/icons/community.png', 'مجتمعي', true),
                    24.pw(),
                    _buildNavItem('assets/icons/library.png', 'مكتبتي', false),

                  ],
                ),

                FloatingActionButton(
                  onPressed: () {
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.add, size: 32.0),
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildNavItem('assets/icons/chatbot.png', 'شات بوت', false),
                    24.pw(),
                    _buildNavItem('assets/icons/setting.png', 'الاعدادات', false),
                  ],
                ),
                // Right side of the navigation bar

              ],
            ),
          )),
      // extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            expandedHeight: 284.h,
            pinned: true,
            leading: 0.pw(),
            flexibleSpace:LayoutBuilder(
              builder: (context, constraints) {
                // Get the scroll percentage (1 = fully expanded, 0 = collapsed)
                final percent = (constraints.maxHeight - kToolbarHeight) / (217.h - kToolbarHeight);

                return FlexibleSpaceBar(
                  centerTitle: true,
                  title: AnimatedOpacity(
                    opacity: percent < 0.2 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 100),
                    child: _buildHeaderContent(true)
                  ),
                  background:_buildHeaderBackground(false),
                );
              },
            ),
      ),
       SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: ListView.separated(
                  shrinkWrap: true,

                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://scontent.ftlv21-1.fna.fbcdn.net/v/t39.30808-6/295928553_2070311023148654_6760145031800456898_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=dy9GqZDay4UQ7kNvgHdEbqB&_nc_ht=scontent.ftlv21-1.fna&_nc_gid=AmMjF5Eha2nBoTKp3X46xw6&oh=00_AYBh4xXrqkDSbNsQgWbIlmkcNjugFuu95x_Gr5qfGyB5ug&oe=67119C37')),
                            10.pw(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: 'حسين غباين',
                                  fontSize: 14.sp,
                                ),
                                4.ph(),
                                AppText(
                                  text: 'منذ 4 دقائق',
                                  fontSize: 12.sp,
                                  color: Color(0xff64748B),
                                )
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_horiz))
                          ],
                        ),
                        10.ph(),
                        const ExpandableText(
                            text:
                            'مرحبا اصدقائي اريد معرفة الشباتر المطلوبة للامتحان النهائي وموعد الامتحان  بالاضافة لحل السؤال التالي الموضح بالصور موعد الامتحان  بالاضافة لحل السؤال التالي الموضح بالصور '),
                        12.ph(),
                        _buildPostImage(
                            'https://scontent.ftlv21-1.fna.fbcdn.net/v/t39.30808-6/295928553_2070311023148654_6760145031800456898_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=dy9GqZDay4UQ7kNvgHdEbqB&_nc_ht=scontent.ftlv21-1.fna&_nc_gid=AmMjF5Eha2nBoTKp3X46xw6&oh=00_AYBh4xXrqkDSbNsQgWbIlmkcNjugFuu95x_Gr5qfGyB5ug&oe=67119C37'),
                        10.ph(),
                        // _buildDotsIndicator(),
                        // 20.ph(),
                        SizedBox(
                          width: 326.w,
                          height: 42.h,
                          child: Row(
                            children: [
                              ActionButton(iconPath:  'assets/icons/favourite.png',count: '450',),
                              10.pw(),
                              ActionButton(iconPath:  'assets/icons/share.png',count: '21',),
                              10.pw(),
                              ActionButton(iconPath:  'assets/icons/share.png',count: '15',),


                              const Spacer(),
                              IconButton(
                                icon: Image.asset(
                                  'assets/icons/Bookmark.png',
                                  height: 17.h,
                                  width: 19.w,
                                ),
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                              ),
// 20.ph()
                            ],
                          )  ,
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Column(
                      children: [
                        16.ph(),
                    Divider(
                    color: Colors.grey.shade300,
                      endIndent: 24.w,
                      indent: 25.w,
                    ),
                        16.ph()
                      ],
                    );

                  },
                  itemCount: 5,
                  physics: BouncingScrollPhysics(),
                ))
          ),
        ],
      )


    );
  }

  Widget _buildHeaderBackground(bool inScroll) {
    return Container(
      // height: 20.81.h,
      // width: 375.w,
      decoration: const BoxDecoration(
        // color: Color(0xFF0077FF),
        image: DecorationImage(
          image: AssetImage('assets/images/background_home_screen.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: _buildHeaderContent(inScroll),
    );
  }

  Widget _buildHeaderContent(bool inScroll) {
    return  inScroll ?
    SafeArea(child: Column(
      children: [
        // 50.ph(),
        // inScroll?0.ph():64.ph(),
        Expanded(child: SizedBox(
          width:327.w,
          // 327.w,
          height:40.h,
          child: Row(
            children: [
              Expanded(child: _buildLogoContainer(),),
              8.pw(),
              _buildTitleAndSubtitle(inScroll),
              const Spacer(),
              _buildIconButton('assets/icons/search.png',inScroll),
              _buildIconButton('assets/icons/notification.png',inScroll),
            ],
          ),
        ),),
        inScroll?0.ph(): 24.ph(),
        inScroll?0.ph(): _buildCategoryTabs(),
      ],
    )) :
    Column(
      children: [
        // 50.ph(),
        inScroll?0.ph():64.ph(),
        SizedBox(
          height: 55.h,
          width: 327.w,
          child: Row(
            children: [
              _buildLogoContainer(),
              8.pw(),
              _buildTitleAndSubtitle(inScroll),
              const Spacer(),
              _buildIconButton('assets/icons/search.png',inScroll),
              _buildIconButton('assets/icons/notification.png',inScroll),
            ],
          ),
        ),
      20.ph(),
        SizedBox(
          width: 327.w,
          height: 24.h,
          child: Row(
            children: [
              AppText(text: 'التخصصات', fontSize: 16.sp,color: Colors.white,),
              Spacer(),
              AppText(text: 'عرض المزيد', fontSize: 12.sp,color: Colors.lightBlueAccent,),

            ],
          ),
        ),
        26.ph(),
        Container(
          padding: EdgeInsets.only(right: 24.w),
          height: 110.h,
          // width: 327.w,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
              itemBuilder:(context, index) {
                return Column(
                  children: [
                    Container(
                      width: 56.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r)
                      ),
                    ),
                    12.ph(),
                    AppText(text: 'شائع', fontSize: 14.sp,color: Colors.white,)
                  ],
                );

              },
              separatorBuilder: (context, index) {
                return 21.pw();

              },
              itemCount: 6),
        )
        // _buildCategoryTabs(),
      ],
    );
  }
  Widget _buildLogoContainer() {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: const BoxDecoration(
        color: Color(0xff007BFF),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Image.asset(
        'assets/images/Frame.png',
        height: 28.h,
        width: 28.w,
      ),
    );
  }

  Widget _buildTitleAndSubtitle(bool inScroll) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'تطوير البرمجيات',
          fontSize: 18.sp,
          color:inScroll? Colors.black:Colors.white,
          // fontWeight: FontWeight.bold,
        ),

        if (!inScroll) ...[
          6.ph(),
          AppText(
            text: 'مجتمع مخصص لكل تساؤلاتك',
            fontSize: 12.sp,
            color: Colors.white,
          ),
        ],

      ],
    );
  }

  Widget _buildIconButton(String iconPath,bool inScroll) {
    return IconButton(
      onPressed: () {},
      icon: Image.asset(
        iconPath,
        height: 20.h,
        width: 20.w,
        color: inScroll? Colors.black: Colors.white,
      ),
      padding: EdgeInsets.zero,
    );
  }



  Widget _buildCategoryTabs() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
      height: 55.h,
      width: 327.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          _buildCategoryTab('تطوير البرمجيات', isSelected: true),
          15.pw(),
          _buildCategoryTab('جامعتي'),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String title, {bool isSelected = false}) {
    return Expanded(
      child: Container(
        alignment: AlignmentDirectional.center,
        height: 43.h,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff2769F2) : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: AppText(
          text: title,
          fontSize: 14.sp,
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildPostImage(String image) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              image,
              height: 292.h,
              width: 326.w,
              fit: BoxFit.cover,
            )),
        _buildImageCounter(),
      ],
    );
  }

  Widget _buildImageCounter() {
    if (0 > 1) {
      return Positioned(
        top: 8.0,
        left: 8.0,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: AppText(
              text: '${0 + 1}/${0}',
              fontSize: 10.sp,
              color: Colors.white,
            )),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildDotsIndicator() {
    if (0 > 1) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: index == 0 ? 8.0 : 6.0,
              height: index == 0 ? 8.0 : 6.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == 0 ? Colors.blue : Colors.grey,
              ),
            );
          }));
    }
    return const SizedBox.shrink();
  }

  Widget _buildNavItem(String imagePath, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Image.asset(imagePath),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}



class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({required this.text});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: _isExpanded ? null : 2,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14.sp),
        ),
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Text(
            _isExpanded ? 'عرض أقل' : 'عرض المزيد',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Main Content Here"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define what happens when the center button is pressed
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 32.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0, // Margin around the FAB notch
        child: Container(
          height: 70.h, // Adjust height to match your UI needs
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.blue, width: 1.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(Icons.settings, 'الاعدادات'),
              _buildNavItem(Icons.flash_on, 'شات بوت'),
              SizedBox(width: 40.w), // Empty space for the FAB in the center
              _buildNavItem(Icons.book, 'مكتبتي'),
              _buildNavItem(Icons.people, 'مجتمعي', isSelected: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isSelected = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.grey,
          size: 24.0,
        ),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
