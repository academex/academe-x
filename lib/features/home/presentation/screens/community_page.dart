import 'dart:async';

import 'package:academe_x/core/constants/cache_keys.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_majors_state.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/post/post_state.dart';
import 'package:academe_x/features/home/presentation/widgets/post/shimmer/post_widget_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  Timer? _debounce;
  late ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    context.read<CollegeMajorsCubit>().initCollegeMajorForHome();
    context.read<PostsCubit>().loadTagPosts();
    // Future
    _scrollController = context.read<PostsCubit>().scrollController;
    _scrollController.addListener(_onScroll);
  }
  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }



  void _onScroll() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (_isBottom) {
        context.read<PostsCubit>().loadPosts(tagId: context.read<CollegeMajorsCubit>().state.selectedMajor!.id!);
      }
    });
  }

  bool get _isBottom {
    if (!context.read<PostsCubit>().scrollController.hasClients) return false;
    final maxScroll = context.read<PostsCubit>().scrollController.position.maxScrollExtent;
    final currentScroll = context.read<PostsCubit>().scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }


  Widget _buildSliverAppBar() {
    return BlocBuilder<CollegeMajorsCubit,CollegeMajorsState>(
      // buildWhen: (previous, current) => previous!=current,
      builder: (context, state) => SliverAppBar(
        automaticallyImplyLeading: true,
        expandedHeight:state.isVisibileMajors? 250: 150,
        pinned: true,
        leading: 0.pw(),
        flexibleSpace: LayoutBuilder(
          builder: (context, constraints) {
            final percent = (constraints.maxHeight - kToolbarHeight) /
                ((state.isVisibileMajors? 250: 150) - kToolbarHeight);
            return FlexibleSpaceBar(
              centerTitle: true,
              title: AnimatedOpacity(
                opacity: percent < 0.2 ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 100),
                child: _buildHeaderContent(true, state),
              ),
              background: _buildHeaderBackground(false,state),
            );
          },
        ),
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
                  // AppLogger.success('reach the end');
                  if (state.hasPostsReachedMax) {
                  AppLogger.success('reach the end');
                    return Column(
                      children: [
                        20.ph(),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          child: Text(
                            'You\'ve reached the end!',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const PostWidgetShimmer();
                }

                final post = state.posts[index];
                return Column(
                  children: [
                    20.ph(),
                    PostWidget(post: post,fromHome:true),
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
                  ? state.posts.length + 1
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
        return await context.read<PostsCubit>().refreshPosts(context.read<CollegeMajorsCubit>().state.selectedMajor!.id!);
      },
      child: CustomScrollView(
        controller: context.read<PostsCubit>().scrollController,
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

  Widget _buildHeaderBackground(bool inScroll,CollegeMajorsState state) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2200F2),
      ),
      child: _buildHeaderContent(inScroll,state),
    );
  }

  Widget _buildHeaderContent(bool inScroll,CollegeMajorsState state) {
      if (
        (state.status == MajorsStatus.loading)) {
      return const Center(child: CircularProgressIndicator());
    }else if(state.status == MajorsStatus.failure && state.majors.isEmpty) {
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
    else if(state.status== MajorsStatus.success){
        final title = state.selectedMajor != null
            ? '${state.selectedMajor!.majorAr!} | ${state.selectedMajor!.name!.toUpperCase()}'
            : 'Loading...';
        return inScroll
            ? SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                      // width: 327,
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
                  HeaderWidget(inScroll: inScroll, logoPath: 'assets/images/Frame.png', title:title , subTitle:  'مجتمع مخصص لكل تساؤلاتك', firstIconPath: 'assets/icons/search.png', secondIconPath: 'assets/icons/notification.png')
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
                        text:context.read<CollegeMajorsCubit>().state.isVisibileMajors? 'عرض اقل' : 'عرض المزيد',
                        fontWeight: FontWeight.w500,
                        onPressed: () {
                          context.read<CollegeMajorsCubit>().toggleVisibleMajors();


                        },
                        fontSize: 12  ,
                        color: Colors.white.withOpacity(0.66),
                      ),
                    ],
                  ),
                  12.ph(),
                ],
              ),
            ),
            state.isVisibileMajors?
            Container(
              padding: const EdgeInsets.only(right: 24),
              height: 100,
              // width: 327.w,
              child: ListView.separated(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    bool isSelected= state.majors[index].name! == state.selectedTag;
                    String? title = state.majors[index].majorAr;
                    // String image = 'assets/images/image_test1.png';
                    AppLogger.success(state.majors[index].photoUrl.toString());
                    String image = state.majors[index].photoUrl!;
                    return Column(
                      children: [
                        GestureDetector(
                          child: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                  color:isSelected?Colors.white: Color(0x0F000000),
                                  // : const,
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: image,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )

                              )
                          ),
                    ),
                          onTap: ()async {
                            context
                                .read<CollegeMajorsCubit>()
                                .selectTag(state.majors[index]);
                            //

                            await   context
                                .read<PostsCubit>()
                                .loadTagPosts(tagId: state.majors[index].id!);
                          },
                        ),
                        12.ph(),
                        AppText(
                          text: title!,
                          fontSize: 14,
                          color: Colors.white,
                          // fontWeight:FontWeight.bold ,
                          fontWeight:isSelected? FontWeight.bold : FontWeight.normal,
                          // fontWeight:selectedIndex == index? FontWeight.bold : FontWeight.normal,

                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return 10.pw();
                  },
                  itemCount: state.majors.length),
            )
                :0.ph(),
          ],
        );
      }  else{
      return Text('data');
      }


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


