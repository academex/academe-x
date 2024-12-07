import 'dart:async';

import 'package:academe_x/core/constants/cache_keys.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_majors_state.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/post/post_state.dart';
import 'package:academe_x/features/home/presentation/widgets/post/shimmer/post_widget_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:academe_x/lib.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final _scrollController = ScrollController();
  Timer? _debounce;
  List<MajorModel> majors=[];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  // ( HiveCacheManager().getCachedResponse(CacheKeys.MAJORS,
  //   (p0) => (p0 as List)
  //       .map((item) => MajorModel.fromJson(item as Map<String, dynamic>))
  //       .toList())).then(
  //     (value) => majors =value!
  //   );
  //   context.read<CollegeMajorsCubit>().loadMajors();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (_isBottom) {
        context.read<PostsCubit>().loadPosts();
      }
    });
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Widget _buildSliverAppBar() {
    AppLogger.success(majors.toString());
    return SliverAppBar(
      automaticallyImplyLeading: true,
      expandedHeight: 260,
      pinned: true,
      leading: 0.pw(),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final percent = (constraints.maxHeight - kToolbarHeight) /
              (260 - kToolbarHeight);
          return FlexibleSpaceBar(
            centerTitle: true,
            title: AnimatedOpacity(
              opacity: percent < 0.2 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 100),
              child: _buildHeaderContent(true),
            ),
            background: _buildHeaderBackground(false),
          );
        },
      ),
    );
  }

  Widget _buildPostsList() {
    return SliverPadding(

      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.initial:
            case PostStatus.loading:
              if (state.posts.isEmpty) {
                return  SliverFillRemaining(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Column(
                      children: [
                        const PostWidgetShimmer(),
                        Divider(
                          color: Colors.grey.shade300,
                          endIndent: 25,
                          indent: 25,
                        ),
                      ],
                    ),
                  )
                  //
                );
              }
              break;

            case PostStatus.failure:
              if (state.posts.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.errorMessage ?? 'Failed to fetch posts'),
                        16.ph(),
                        ElevatedButton(
                          onPressed: () async{
                            return  await context.read<PostsCubit>().loadPosts();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }
              break;

            case PostStatus.success:
              if (state.posts.isEmpty) {
                return const SliverFillRemaining(

                  child: Center(child: Text('No posts found')),
                );
              }
              break;
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                if (index >= state.posts.length) {

                  if (state.hasPostsReachedMax) {
                    return null;
                  }
                  return const PostWidgetShimmer();
                }

                final post = state.posts[index];
                return Column(
                  children: [
                    20.ph(),
                    PostWidget(post: post),
                    if (index < state.posts.length - 1) ...[
                      16.ph(),
                      Divider(
                        color: Colors.grey.shade300,
                        endIndent: 25,
                        indent: 25,
                      ),
                      16.ph(),
                    ],
                  ],
                );},
              childCount: state.hasPostsReachedMax
                  ? state.posts.length
                  : state.posts.length + 1,
            ),

          );
        },

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return await context.read<PostsCubit>().refreshPosts();
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(), // Add this to enable refresh when at top
        ),
        shrinkWrap: true,
        slivers: [
          _buildSliverAppBar(),
          _buildPostsList(),
        ],
      ),
    );
  }

  Widget _buildHeaderBackground(bool inScroll) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2200F2),
      ),
      child: _buildHeaderContent(inScroll),
    );
  }

  Widget _buildHeaderContent(bool inScroll) {

    return BlocBuilder<CollegeMajorsCubit, CollegeMajorsState>(
        builder: (context, state) {
          if (state.status == MajorsStatus.loading && state.majors.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == MajorsStatus.failure && state.majors.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage ?? 'Failed to load majors'),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<CollegeMajorsCubit>().refreshMajors(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return inScroll
              ? SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                        width: 327,
                        // 327.w,
                        height: 45  ,
                        child:HeaderWidget(inScroll: inScroll, logoPath: 'assets/images/Frame.png', title: 'تطوير البرمجيات'  , subTitle:  'مجتمع مخصص لكل تساؤلاتك', firstIconPath: 'assets/icons/search.png', secondIconPath: 'assets/icons/notification.png')
                    ),
                  ),
                  inScroll ? 0.ph() : 15.ph(),
                  inScroll ? 0.ph() : _buildCategoryTabs(),
                ],
              ))
              :  Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    inScroll ? 0.ph() : 60.ph(),
                    HeaderWidget(inScroll: inScroll, logoPath: 'assets/images/Frame.png', title: 'تطوير البرمجيات'  , subTitle:  'مجتمع مخصص لكل تساؤلاتك', firstIconPath: 'assets/icons/search.png', secondIconPath: 'assets/icons/notification.png')
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
                    ,18.ph(),
                    Row(
                      children: [
                        AppText(
                          text: 'التخصصات',
                          fontSize: 16  ,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        const Spacer(),
                        AppText(
                          text: 'عرض المزيد',
                          fontWeight: FontWeight.w500,
                          fontSize: 12  ,
                          color: Colors.white.withOpacity(0.66),
                        ),
                      ],
                    ),
                    12.ph(),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 24),
                height: 100,
                // width: 327.w,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      String? title = majors[index].majorAr;
                      String image = 'assets/images/image_test1.png';
                      return Column(
                        children: [
                          GestureDetector(
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                      // : const Color(0x0F000000),
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
                            text: title!,
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight:FontWeight.bold ,
                            // fontWeight:selectedIndex == index? FontWeight.bold : FontWeight.normal,

                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return 10.pw();
                    },
                    itemCount: majors.length),
              )
            ],
          );
        });



  }



  Widget _buildCategoryTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5  , horizontal: 8),
      height: 55  ,
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
        height: 43  ,
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
