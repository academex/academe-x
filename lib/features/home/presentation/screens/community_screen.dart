import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/app_size.dart';
import '../controllers/cubits/home/action_post_cubit.dart';
import '../controllers/cubits/home/category_cubit.dart';
import '../controllers/states/action_post_states.dart';
import '../widgets/action_button.dart';
import '../widgets/comments_list.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const CustomBottomNavBar(),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: true,
              expandedHeight: kAppBarExpandedHeight.h,
              pinned: true,
              leading: 0.pw(),
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  // Get the scroll percentage (1 = fully expanded, 0 = collapsed)
                  final percent = (constraints.maxHeight - kToolbarHeight) /
                      (kAppBarExpandedHeight.h - kToolbarHeight);

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
                padding: EdgeInsets.symmetric(horizontal: kPaddingHorizontal.w),
                child: ListView.separated(
                  shrinkWrap: true,

                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://scontent.ftlv21-1.fna.fbcdn.net/v/t39.30808-6/295928553_2070311023148654_6760145031800456898_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=3zXhjg5POMoQ7kNvgEaeogu&_nc_ht=scontent.ftlv21-1.fna&_nc_gid=AZfV6b1yRcUmoKX3s-jXRo5&oh=00_AYDZNQMHGTZ1-1WwX8xXh_4Ox1LCVrngo1zxSAON4Cf_Uw&oe=67194CF7')),
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
                            'https://scontent.ftlv21-1.fna.fbcdn.net/v/t39.30808-6/295928553_2070311023148654_6760145031800456898_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=3zXhjg5POMoQ7kNvgEaeogu&_nc_ht=scontent.ftlv21-1.fna&_nc_gid=AZfV6b1yRcUmoKX3s-jXRo5&oh=00_AYDZNQMHGTZ1-1WwX8xXh_4Ox1LCVrngo1zxSAON4Cf_Uw&oe=67194CF7'),
                        10.ph(),
                        // _buildDotsIndicator(),
                        // 20.ph(),
                       BlocProvider(
                         create:(context) =>  ActionPostCubit(),
                         child:  SizedBox(
                           width: 326.w,
                           height: 42.h,
                           child: Row(
                             children: [
                               BlocBuilder<ActionPostCubit,ActionPostState>(
                                 builder: (context, state) {
                                   return ActionButton(iconPath:state.isLiked? 'assets/icons/favourite_selected.png':'assets/icons/favourite.png',count: '450',onTap:  () {
                                     context.read<ActionPostCubit>().performLikeAction(!state.isLiked);

                                   },);
                                 },
                               ),
                               10.pw(),
                               ActionButton(iconPath:  'assets/icons/comment.png',count: '21',onTap: () {
                                 CommentsList(postId:0, context: context);

                               },),
                               10.pw(),
                               ActionButton(iconPath:  'assets/icons/share.png',count: '15',onTap: () {
                                 showShareOptions(context);
                               },),
                               const Spacer(),
                               BlocBuilder<ActionPostCubit,ActionPostState>(
                                 builder: (context, state) {
                                   return IconButton(
                                     icon: Image.asset(
                                       state.isSaved?'assets/icons/bookMark_selected.png':  'assets/icons/Bookmark.png',
                                       height: 17.h,
                                       width: 19.w,
                                     ),
                                     padding: EdgeInsets.zero,
                                     onPressed: () {
                                       context.read<ActionPostCubit>().performSaveAction(!state.isSaved);
                                     },
                                   );
                                 },

                               )
                             ],
                           )  ,
                         )
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
                      endIndent: kPaddingHorizontal.w,
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
                  // return FlexibleSpaceBar(
                  //   centerTitle: true,
                  //   title: AnimatedOpacity(
                  //       opacity: percent < 0.2 ? 1.0 : 0.0,
                  //       duration: const Duration(milliseconds: 100),
                  //       child: _buildHeaderContent(true)),
                  //   background: _buildHeaderBackground(false),
                  // );
            //     },
            //   ),
            // ),
        //     SliverToBoxAdapter(
        //         child: Padding(
        //             padding:
        //                 EdgeInsets.symmetric(horizontal: kPaddingHorizontal.w),
        //             child: ListView.separated(
        //               shrinkWrap: true,
        //               itemBuilder: (context, index) {
        //                 return Column(
        //                   children: [
        //                     Row(
        //                       children: [
        //                         const CircleAvatar(
        //                             backgroundImage: NetworkImage(
        //                                 'https://scontent.ftlv21-1.fna.fbcdn.net/v/t39.30808-6/295928553_2070311023148654_6760145031800456898_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=dy9GqZDay4UQ7kNvgHdEbqB&_nc_ht=scontent.ftlv21-1.fna&_nc_gid=AmMjF5Eha2nBoTKp3X46xw6&oh=00_AYBh4xXrqkDSbNsQgWbIlmkcNjugFuu95x_Gr5qfGyB5ug&oe=67119C37')),
        //                         10.pw(),
        //                         Column(
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             AppText(
        //                               text: 'حسين غباين',
        //                               fontSize: 14.sp,
        //                             ),
        //                             4.ph(),
        //                             AppText(
        //                               text: 'منذ 4 دقائق',
        //                               fontSize: 12.sp,
        //                               color: Color(0xff64748B),
        //                             )
        //                           ],
        //                         ),
        //                         const Spacer(),
        //                         IconButton(
        //                             onPressed: () {},
        //                             icon: const Icon(Icons.more_horiz))
        //                       ],
        //                     ),
        //                     10.ph(),
        //                     const ExpandableText(
        //                         text:
        //                             'مرحبا اصدقائي اريد معرفة الشباتر المطلوبة للامتحان النهائي وموعد الامتحان  بالاضافة لحل السؤال التالي الموضح بالصور موعد الامتحان  بالاضافة لحل السؤال التالي الموضح بالصور '),
        //                     12.ph(),
        //                     _buildPostImage(
        //                         'https://scontent.ftlv21-1.fna.fbcdn.net/v/t39.30808-6/295928553_2070311023148654_6760145031800456898_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=dy9GqZDay4UQ7kNvgHdEbqB&_nc_ht=scontent.ftlv21-1.fna&_nc_gid=AmMjF5Eha2nBoTKp3X46xw6&oh=00_AYBh4xXrqkDSbNsQgWbIlmkcNjugFuu95x_Gr5qfGyB5ug&oe=67119C37'),
        //                     10.ph(),
        //                     // _buildDotsIndicator(),
        //                     // 20.ph(),
        //                     BlocProvider(
        //                         create: (context) => ActionPostCubit(),
        //                         child: SizedBox(
        //                           width: 326.w,
        //                           height: 42.h,
        //                           child: Row(
        //                             children: [
        //                               BlocBuilder<ActionPostCubit,
        //                                   ActionPostState>(
        //                                 builder: (context, state) {
        //                                   return ActionButton(
        //                                     iconPath: state.isLiked
        //                                         ? 'assets/icons/favourite_selected.png'
        //                                         : 'assets/icons/favourite.png',
        //                                     count: '450',
        //                                     onTap: () {
        //                                       context
        //                                           .read<ActionPostCubit>()
        //                                           .performLikeAction(
        //                                               !state.isLiked);
        //                                     },
        //                                   );
        //                                 },
        //                               ),
        //                               10.pw(),
        //                               ActionButton(
        //                                 iconPath: 'assets/icons/comment.png',
        //                                 count: '21',
        //                                 onTap: () {
        //                                   CommentsList(
        //                                       context: context, postId: 5);
        //                                 },
        //                               ),
        //                               10.pw(),
        //                               ActionButton(
        //                                 iconPath: 'assets/icons/share.png',
        //                                 count: '15',
        //                                 onTap: () {
        //                                   showShareOptions(context);
        //                                 },
        //                               ),
        //                               const Spacer(),
        //                               BlocBuilder<ActionPostCubit,
        //                                   ActionPostState>(
        //                                 builder: (context, state) {
        //                                   return IconButton(
        //                                     icon: Image.asset(
        //                                       state.isSaved
        //                                           ? 'assets/icons/bookMark_selected.png'
        //                                           : 'assets/icons/Bookmark.png',
        //                                       height: 17.h,
        //                                       width: 19.w,
        //                                     ),
        //                                     padding: EdgeInsets.zero,
        //                                     onPressed: () {
        //                                       CommentsList(
        //                                           context: context, postId: 5);
        //
        //                                       context
        //                                           .read<ActionPostCubit>()
        //                                           .performSaveAction(
        //                                               !state.isSaved);
        //                                     },
        //                                   );
        //                                 },
        //                               )
        //                             ],
        //                           ),
        //                         ))
        //                   ],
        //                 );
        //               },
        //               separatorBuilder: (context, index) {
        //                 return Column(
        //                   children: [
        //                     16.ph(),
        //                     Divider(
        //                       color: Colors.grey.shade300,
        //                       endIndent: kPaddingHorizontal.w,
        //                       indent: 25.w,
        //                     ),
        //                     16.ph()
        //                   ],
        //                 );
        //               },
        //               itemCount: 5,
        //               physics: BouncingScrollPhysics(),
        //             ))),
        //   ],
        // ));
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
    List<Map<String,String>> list= [
    {
      'عام': 'assets/images/image_test1.png',
    },
      {
        'تطوير برمجيات': 'assets/images/image_test1.png',
      },
      {
        'علم حاسوب': 'assets/images/image_test1.png',
      },
      {
        'حوسبة متنقلة': 'assets/images/image_test1.png',
      },
      {
        'وسائط متعددة': 'assets/images/image_test1.png',
      },
    ];
    /*

    [
      'عام',
      'تطوير برمجيات',
      'علم حاسوب',
      'حوسبة متنقلة',
      'وسائط متعددة',
    ];
     */
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
        inScroll?0.ph(): kPaddingHorizontal.ph(),
        inScroll?0.ph(): _buildCategoryTabs(),
      ],
    )) :
   BlocProvider(
     create: (context) => CategoryCubit(),
     child:  Column(
       children: [
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
         BlocBuilder<CategoryCubit,int>(
           builder: (BuildContext context, selectedIndex) {
             return Container(
               padding: EdgeInsets.only(right: kPaddingHorizontal.w),
               height: kCategoryHeight.h,
               // width: 327.w,
               child: ListView.separated(
                   physics: const BouncingScrollPhysics(),
                   shrinkWrap: true,
                   scrollDirection: Axis.horizontal,
                   itemBuilder:(context, index) {
                     String title= list[index].keys.first;
                     String image= list[index].values.first;
                     return Column(
                       children: [
                         GestureDetector(
                           child: Container(
                             width: 56.w,
                             height: 56.h,
                             decoration: BoxDecoration(
                               // image:
                                 color: selectedIndex == index ? Colors.white : Colors.blue,
                                 borderRadius: BorderRadius.circular(10.r)
                             ),
                             child: Image.asset(image),
                           ),
                           onTap: () {
                             context.read<CategoryCubit>().selectCategory(index);
                           },
                         ),
                         12.ph(),
                         AppText(text: title, fontSize: 14.sp,color: Colors.white,)
                       ],
                     );

                   },
                   separatorBuilder: (context, index) {
                     return 20.pw();

                   },
                   itemCount: list.length),
             );
           },
         )
         // _buildCategoryTabs(),
       ],
     ),

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
              height: kPostImageHeight.h,
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

void showShareOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4.h,
              width: 56.w,
              color: Color(0xffE7E8EA),
            ),
            20.ph(),
            // Close button and title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                100.pw(),

                AppText(text:  'مشاركة بواسطة', fontSize: 16,
                fontWeight: FontWeight.w600,),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
               // To balance the close icon space
              ],
            ),
            // Sharing options
            20.ph(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildShareOption(
                  iconPath: 'assets/icons/copy_link.png',
                  label: 'نسخ الرابط',
                  onTap: () {
                    // Add your Copy Link logic here
                    Navigator.pop(context);
                  },
                ),
                _buildShareOption(
                  iconPath: 'assets/icons/telegram.png',
                  label: 'تلجرام',
                  onTap: () {
                    // Add your Telegram sharing logic here
                    Navigator.pop(context);
                  },
                ),
                _buildShareOption(
                  iconPath: 'assets/icons/X.png',
                  label: 'تويتر',
                  onTap: () {
                    // Add your Twitter sharing logic here
                    Navigator.pop(context);
                  },
                ),
                _buildShareOption(
                  iconPath: 'assets/icons/whatsapp.png',
                  label: 'واتساب',
                  onTap: () {
                    // Add your WhatsApp sharing logic here
                    Navigator.pop(context); // Close the bottom sheet
                  },
                ),



              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}

// Helper widget to build a share option
Widget _buildShareOption({
  required String iconPath,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 69.h,
          width: 69.w,
          decoration: BoxDecoration(
            color: const Color(0xF9F9F9C4),
            shape: BoxShape.circle,
            image: DecorationImage(image: AssetImage(iconPath,),)
          ),
        ),
        // CircleAvatar(
        //   radius: 28.0,
        //   backgroundColor: Colors.grey.shade200,
        //   child: Image.asset(iconPath, height: 30, width: 30),
        // ),
        SizedBox(height: 8),
        AppText(text: label, fontSize: 12.sp,color: Color(0xff3D5A80),)

      ],
    ),
  );
}

