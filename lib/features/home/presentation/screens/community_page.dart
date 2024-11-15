import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:academe_x/lib.dart';

class CommunityPage extends StatelessWidget {
  CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: true,
          expandedHeight: 250,
          pinned: true,
          leading: 0.pw(),
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              // Get the scroll percentage (1 = fully expanded, 0 = collapsed)
              final percent = (constraints.maxHeight - kToolbarHeight) /
                  (280 - kToolbarHeight);
              return FlexibleSpaceBar(
                centerTitle: true,
                title: AnimatedOpacity(
                    opacity: percent < 0.2 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 100),
                    child: _buildHeaderContent(true)),
                background: _buildHeaderBackground(false),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return PostWidget(post: MockData.posts[index]);
                    // return Column(
                    //   children: [
                    //     Row(
                    //       children: [
                    //         const CircleAvatar(
                    //             backgroundImage: NetworkImage(
                    //                 'https://scontent.ftlv21-1.fna.fbcdn.net/v/t39.30808-6/295928553_2070311023148654_6760145031800456898_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=3zXhjg5POMoQ7kNvgEaeogu&_nc_ht=scontent.ftlv21-1.fna&_nc_gid=AZfV6b1yRcUmoKX3s-jXRo5&oh=00_AYDZNQMHGTZ1-1WwX8xXh_4Ox1LCVrngo1zxSAON4Cf_Uw&oe=67194CF7')),
                    //         10.pw(),
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             AppText(
                    //               text: 'حسين غباين',
                    //               fontSize: 14  ,
                    //             ),
                    //             4.ph(),
                    //             AppText(
                    //               text: 'منذ 4 دقائق',
                    //               fontSize: 12  ,
                    //               color: const Color(0xff64748B),
                    //             )
                    //           ],
                    //         ),
                    //         const Spacer(),
                    //         IconButton(
                    //             onPressed: () {},
                    //             icon: const Icon(Icons.more_horiz))
                    //       ],
                    //     ),
                    //     10.ph(),
                    //     const ExpandableText(
                    //         text:
                    //             'مرحبا اصدقائي اريد معرفة الشباتر المطلوبة للامتحان النهائي وموعد الامتحان  بالاضافة لحل السؤال التالي الموضح بالصور موعد الامتحان  بالاضافة لحل السؤال التالي الموضح بالصور '),
                    //     12.ph(),
                    //     _buildPostImage(
                    //         'https://scontent.ftlv21-1.fna.fbcdn.net/v/t39.30808-6/295928553_2070311023148654_6760145031800456898_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=3zXhjg5POMoQ7kNvgEaeogu&_nc_ht=scontent.ftlv21-1.fna&_nc_gid=AZfV6b1yRcUmoKX3s-jXRo5&oh=00_AYDZNQMHGTZ1-1WwX8xXh_4Ox1LCVrngo1zxSAON4Cf_Uw&oe=67194CF7'),
                    //     10.ph(),
                    //     BlocProvider(
                    //         create: (context) => ActionPostCubit(),
                    //         child: SizedBox(
                    //           width: 326.w,
                    //           height: 50  ,
                    //           child: Row(
                    //             children: [
                    //               BlocBuilder<ActionPostCubit, ActionPostState>(
                    //                 builder: (context, state) {
                    //                   return ActionButton(
                    //                     iconPath: state.isLiked
                    //                         ? 'assets/icons/favourite_selected.png'
                    //                         : 'assets/icons/favourite.png',
                    //                     count: '450',
                    //                     onTap: () {
                    //                       context
                    //                           .read<ActionPostCubit>()
                    //                           .performLikeAction(
                    //                               !state.isLiked);
                    //                     },
                    //                   );
                    //                 },
                    //               ),
                    //               10.pw(),
                    //               ActionButton(
                    //                 iconPath: 'assets/icons/comment.png',
                    //                 count: '21',
                    //                 onTap: () {
                    //                   CommentsList(postId: 0, context: context);
                    //                 },
                    //               ),
                    //               10.pw(),
                    //               ActionButton(
                    //                 iconPath: 'assets/icons/share.png',
                    //                 count: '15',
                    //                 onTap: () {
                    //                   showShareOptions(context);
                    //                 },
                    //               ),
                    //               const Spacer(),
                    //               BlocBuilder<ActionPostCubit, ActionPostState>(
                    //                 builder: (context, state) {
                    //                   return IconButton(
                    //                     icon: Image.asset(
                    //                       state.isSaved
                    //                           ? 'assets/icons/bookMark_selected.png'
                    //                           : 'assets/icons/Bookmark.png',
                    //                       height: 17  ,
                    //                       width: 19.w,
                    //                     ),
                    //                     padding: EdgeInsets.zero,
                    //                     onPressed: () {
                    //                       context
                    //                           .read<ActionPostCubit>()
                    //                           .performSaveAction(
                    //                               !state.isSaved);
                    //                     },
                    //                   );
                    //                 },
                    //               )
                    //             ],
                    //           ),
                    //         ))
                    //   ],
                    // );
                  },
                  separatorBuilder: (context, index) {
                    return Column(
                      children: [
                        16.ph(),
                        Divider(
                          color: Colors.grey.shade300,
                          endIndent: 25,
                          indent: 25,
                        ),
                        16.ph()
                      ],
                    );
                  },
                  itemCount: MockData.posts.length,
                  physics: const BouncingScrollPhysics(),
                ))),
      ],
    );
  }

  Widget _buildHeaderBackground(bool inScroll) {
    return Container(
      height: 20.81,
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
    List<Map<String, String>> list = [
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

    return inScroll
        ? SafeArea(
            child: Column(
            children: [
              Expanded(
                child: SizedBox(
                    width: 327,
                    // 327.w,
                    height: 45,
                    child: HeaderWidget(
                        inScroll: inScroll,
                        logoPath: 'assets/images/Frame.png',
                        title: 'تطوير البرمجيات',
                        subTitle: 'مجتمع مخصص لكل تساؤلاتك',
                        firstIconPath: 'assets/icons/search.png',
                        secondIconPath: 'assets/icons/notification.png')),
              ),
              inScroll ? 0.ph() : 15.ph(),
              inScroll ? 0.ph() : _buildCategoryTabs(),
            ],
          ))
        : BlocProvider(
            create: (context) => CategoryCubit(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      inScroll ? 0.ph() : 40.ph(),
                      HeaderWidget(
                          inScroll: inScroll,
                          logoPath: 'assets/images/Frame.png',
                          title: 'تطوير البرمجيات',
                          subTitle: 'مجتمع مخصص لكل تساؤلاتك',
                          firstIconPath: 'assets/icons/search.png',
                          secondIconPath: 'assets/icons/notification.png')
                      // Row(
                      //   children: [
                      //     _buildLogoContainer(),
                      //     8.pw(),
                      //     _buildTitleAndSubtitle(inScroll),
                      //     const Spacer(),
                      //     _buildIconButton('assets/icons/search.png', inScroll),
                      //     _buildIconButton(
                      //         'assets/icons/notification.png', inScroll),
                      //   ],
                      // ),
                      ,
                      18.ph(),
                      SizedBox(
                        // width: 327,
                        height: 24,
                        child: Row(
                          children: [
                            AppText(
                              text: 'التخصصات',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            const Spacer(),
                            AppText(
                              text: 'عرض المزيد',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color:
                                  Colors.white.withOpacity(0.6600000262260437),
                            ),
                          ],
                        ),
                      ),
                      12.ph(),
                    ],
                  ),
                ),
                BlocBuilder<CategoryCubit, int>(
                  builder: (BuildContext context, selectedIndex) {
                    return Container(
                      padding: const EdgeInsets.only(right: 24),
                      height: 100,
                      // width: 327.w,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            String title = list[index].keys.first;
                            String image = list[index].values.first;
                            return Column(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.asset(image),
                                  ),
                                  onTap: () {
                                    context
                                        .read<CategoryCubit>()
                                        .selectCategory(index);
                                  },
                                ),
                                12.ph(),
                                AppText(
                                  text: title,
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: selectedIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return 10.pw();
                          },
                          itemCount: list.length),
                    );
                  },
                )
              ],
            ));
  }

  Widget _buildCategoryTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      height: 55,
      width: 327,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
        height: 43,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff2769F2) : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: AppText(
          text: title,
          fontSize: 14,
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
              height: 200,
              width: 326,
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
              fontSize: 10,
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
              height: 4,
              width: 56,
              color: const Color(0xffE7E8EA),
            ),
            20.ph(),
            // Close button and title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                100.pw(),

                AppText(
                  text: 'مشاركة بواسطة',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
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
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}

// Helper widget to build a share option
Widget _buildShareOption(
    {required String iconPath,
    required String label,
    required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 69,
          width: 69,
          decoration: BoxDecoration(
              color: const Color(0xF9F9F9C4),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  iconPath,
                ),
              )),
        ),
        // CircleAvatar(
        //   radius: 28.0,
        //   backgroundColor: Colors.grey.shade200,
        //   child: Image.asset(iconPath, height: 30, width: 30),
        // ),
        const SizedBox(height: 8),
        AppText(
          text: label,
          fontSize: 12,
          color: const Color(0xff3D5A80),
        )
      ],
    ),
  );
}
