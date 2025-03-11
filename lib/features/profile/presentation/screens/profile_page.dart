import 'dart:async';

import 'package:academe_x/academeX_main.dart';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/utils/deep_link_service.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/auth/auth.dart';
import 'package:academe_x/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../home/presentation/controllers/cubits/post/posts_cubit.dart';
import '../../../home/presentation/controllers/states/post/post_state.dart';
import '../../../home/presentation/widgets/post/post_widget.dart';
import '../../../home/presentation/widgets/post/shimmer/post_widget_shimmer.dart';
import '../controllers/cubits/profile_cubit.dart';
import '../controllers/states/profile_state.dart';
import '../widgets/post_profile_widget.dart';

class ProfilePage extends StatefulWidget {
  final String? username;

  const ProfilePage({
    super.key,
    this.username,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Timer? _debounce;
  late UserResponseEntity? cachedUser;
  late ScrollController _scrollController;
  late TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length:3, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.cachedUser.then((value) {
      cachedUser = value?.user;
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }
  void _loadData() async{
    context.read<ProfileCubit>().loadProfile(context, username: widget.username);
    context.read<PostsCubit>().loadProfilePosts(context, username: widget.username);
    Future.delayed(const Duration(milliseconds: 500),() => context.read<ProfileCubit>().loadSavedPosts(context,username: widget.username ?? cachedUser!.username),);
  }


  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (_isBottom) {
        context.read<PostsCubit>().loadProfilePosts(
              context,
              username: widget.username,
              fromProfile: true
            );
      }
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == ProfileStatus.error) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: state.errorMessage ?? 'An error occurred',
                    fontSize: 12,
                  ),
                  ElevatedButton(
                    onPressed: () {

                    },
                    child: AppText(
                      text: 'Retry',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        late UserResponseEntity? user;

        if(widget.username == null){
          user = state.user;
        }else{
          user = state.otherUser;
        }
        return Scaffold(
          body: PopScope(
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) {
                context.read<ProfileCubit>().whenCloseOtherUserProfile();
              }

            },
            child: SafeArea(
              child: Column(
                children: [
                  _buildProfileHeader(state,user),
                  _buildBioSection(state,ctx),
                  _buildTabBar(context),
                  _buildTabBarView(context,state,user),
                ],
              ),
            ),
            // onPopInvoked: (didPop) => context.read<ProfileCubit>().whenCloseOtherUserProfile,
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(ProfileState state,UserResponseEntity? user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            // backgroundImage: user?.user.photoUrl != null
            //     ? NetworkImage(user!.user.photoUrl!) as ImageProvider
            //     : const AssetImage('assets/images/default_avatar.png'),
          ),
          10.pw(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text:
                    '${user!.firstName ?? ''} ${user.lastName ?? ''}',
                fontSize: 16,
              ),
              AppText(
                text: '@${user.username ?? ''}',
                fontSize: 14,
                color: const Color(0xC4767676),
              ),
            ],
          ),
          const Spacer(),
          if (state.isEditable)
            IconButton(
              icon: const Icon(
                Icons.settings_outlined,
                color: Color(0xffCCCCCC),
              ),
              onPressed: () {
                // Handle settings tap

                context.pushNamed('setting');

                // Navigator.pushReplacementNamed(context, '/setting');
              },
            )
        ],
      ),
    );
  }

  Widget _buildBioSection(ProfileState state,BuildContext ctx) {
    late UserResponseEntity? user;

    if(widget.username == null){
      user = state.user;
    }else{
      user = state.otherUser;
    }
    final hasBio = user!.bio != null && user.bio!.isNotEmpty;
    bioController.text = user.bio ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if(hasBio) ...[
            Row(
              children: [
                const Icon(Icons.person),
                4.pw(),
                AppText(
                  text: hasBio ? 'السيرة الذاتية' : 'اضافة سيرة ذاتية !!',
                  fontSize: 12,
                  color: const Color(0xE0373737),
                ),
              ],
            ),
            6.ph(),
          ]
    else
         0.ph(),
         Row(
           children: [
             AppText(
               text: hasBio
                   ? user.bio!
                   : '',
               fontSize: 12,
               color: const Color(0xEA6A6A6A),
             ),
           ],
         ),
          8.ph(),
          if (state.isEditable)
            CustomButton(
              height: 40,
              widget: AppText(
                text: hasBio ? 'تعديل' : 'اضافة',
                fontSize: 14,
                color: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  constraints: BoxConstraints(maxHeight: 600),
                  builder: (context) {
                    return Container(
                      height: 600,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      child: Column(
                        children: [
                          12.ph(),
                          Container(
                            height: 5,
                            width: 56,
                            decoration: BoxDecoration(
                                color: const Color(0xffE7E8EA),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          14.ph(),
                          Row(
                            children: [
                              Spacer(),
                              AppText(text: 'تعديل بروفايلي', fontSize: 16),
                              Spacer(),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.close))
                            ],
                          ),
                          15.ph(),
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                // backgroundImage: user?.user.photoUrl != null
                                //     ? NetworkImage(user!.user.photoUrl!) as ImageProvider
                                //     : const AssetImage('assets/images/default_avatar.png'),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff2769F2),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.white, width: 2)),
                                  child: Icon(Icons.edit,
                                      color: Colors.white, size: 16),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                CustomTextField(
                                  label: 'نبذة عني',
                                  hintText: 'اكتب نبذة عنك',
                                  controller: bioController,
                                ),
                                20.ph(),
                                BlocBuilder<ProfileCubit,ProfileState>(builder: (context, state) => CustomButton(
                                    widget: state.isLoading ? CircularProgressIndicator() : AppText(
                                      text: 'تعديل',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    onPressed: ()async {
                                      // Handle bio edit
                                      await ctx.read<ProfileCubit>().updateProfile(
                                          {
                                            'bio': bioController.text,
                                          }
                                          ,
                                          ctx
                                      );
                                      // context
                                      //     .read<ProfileCubit>()
                                      //     .editBio(bioController.text);
                                    },
                                    backgraoundColor: Color(0xff2769F2)),)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );

                // Handle bio add/edit button tap
              },
              backgraoundColor: const Color(0xFF2769F2),
            ),
          15.ph()
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F9),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        labelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
          height: 1.70,
          letterSpacing: 0.10,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Color(0xE06B6B6B),
          fontSize: 14,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w400,
          height: 1.70,
          letterSpacing: 0.10,
        ),
        indicator: BoxDecoration(
          color: const Color(0xFF2769F2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2769F2).withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF6D6D6D),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs:  [
          Tab(text: 'المنشورات'),
          Tab(text: 'الملفات'),
          widget.username !=null ?0.ph(): Tab(text: 'تم حفظه'),
        ],
      ),
    );
  }

  Widget _buildTabBarView(BuildContext context,ProfileState state,UserResponseEntity? user) {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildPostsList(state,user),
          _buildTabContent('الملفات'),
          // widget.username !=null ?0.ph():
          _buildSavedPostsList(state,user),
        ],
      ),
    );
  }
  Widget _buildTabContent(String text) {
    return Container(
      child: Center(
          child: CustomButton(
              widget: AppText(text: 'Logout', fontSize: 16),
              onPressed: () async {
                await context.read<LoginCubit>().logout();
              },
              backgraoundColor: Colors.blue)),
    );
  }

  Widget _buildPostsList(ProfileState state,UserResponseEntity? user) {

    if(user!.username != widget.username){
      return BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          switch (state.profileStatus) {
            case PostProfileStatus.initial:
            case PostProfileStatus.loading:
              return ListView.builder(
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
              );
            case PostProfileStatus.failure:
              if (state.currentProfilePosts.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.errorMessage ?? 'Failed to fetch posts'),
                      16.ph(),
                      ElevatedButton(
                        onPressed: () async {
                          // return await context.read<PostsCubit>().loadPosts();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              break;
            case PostProfileStatus.success:
              if (state.currentProfilePosts.isEmpty) {
                return const Center(child: Text('No posts found'));
              }
              break;
          }
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    if (index >= state.currentProfilePosts.length) {
                      if (state.hasCurrentUserProfilePostsReachedMax) {
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

                    final post = state.currentProfilePosts[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          20.ph(),
                          PostWidget(
                            post: post,
                          ),
                          if (index < state.currentProfilePosts.length - 1) ...[
                            16.ph(),
                            Divider(
                              color: Colors.grey.shade300,
                              endIndent: 25,
                              indent: 25,
                            ),
                            16.ph(),
                          ],
                        ],
                      ),
                    );
                  },
                  childCount: state.hasCurrentUserProfilePostsReachedMax
                      ? state.currentProfilePosts.length + 1
                      : state.currentProfilePosts.length + 1,
                ),
              ),
            ],
          );
        },
      );
    }
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        switch (state.profileStatus) {
          case PostProfileStatus.initial:
          case PostProfileStatus.loading:
            return ListView.builder(
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
            );
          case PostProfileStatus.failure:
            if (state.otherProfilePosts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage ?? 'Failed to fetch posts'),
                    16.ph(),
                    ElevatedButton(
                      onPressed: () async {
                        // return await context.read<PostsCubit>().loadPosts();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            break;
          case PostProfileStatus.success:
            if (state.otherProfilePosts.isEmpty) {
              return const Center(child: Text('No posts found'));
            }
            break;
        }
        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= state.otherProfilePosts.length) {
                    if (state.hasOtherUserProfilePostsReachedMax) {
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

                  final post = state.otherProfilePosts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        20.ph(),
                        PostWidget(
                          post: post,
                        ),
                        if (index < state.otherProfilePosts.length - 1) ...[
                          16.ph(),
                          Divider(
                            color: Colors.grey.shade300,
                            endIndent: 25,
                            indent: 25,
                          ),
                          16.ph(),
                        ],
                      ],
                    ),
                  );
                },
                childCount: state.hasOtherUserProfilePostsReachedMax
                    ? state.otherProfilePosts.length + 1
                    : state.otherProfilePosts.length + 1,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSavedPostsList(ProfileState state,UserResponseEntity? user) {

    return   BlocBuilder<ProfileCubit,ProfileState>(
      builder: (context, state) {

        switch (state.profileSavedPostsStatus) {
          case ProfileSavedPostsStatus.initial:
          case ProfileSavedPostsStatus.loading:
            return ListView.builder(
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
            );
          case ProfileSavedPostsStatus.error:
            if (state.savedPosts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage ?? 'Failed to fetch posts'),
                    16.ph(),
                    ElevatedButton(
                      onPressed: () async {
                        // return await context.read<PostsCubit>().loadPosts();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            break;
          case ProfileSavedPostsStatus.loaded:
            if (state.savedPosts.isEmpty) {
              return const Center(child: Text('No posts found'));
            }
            break;
        }
        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  if (index >= state.savedPosts.length) {
                    if (state.hasSavedPostsReachedMax) {
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

                  final post = state.savedPosts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        20.ph(),
                        PostWidget(
                          post: post,
                        ),
                        if (index < state.savedPosts.length - 1) ...[
                          16.ph(),
                          Divider(
                            color: Colors.grey.shade300,
                            endIndent: 25,
                            indent: 25,
                          ),
                          16.ph(),
                        ],
                      ],
                    ),
                  );
                },
                childCount: state.hasSavedPostsReachedMax
                    ? state.savedPosts.length + 1
                    : state.savedPosts.length + 1,
              ),
            ),
          ],
        );
      },
    );

  }
}
