import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/utils/deep_link_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../auth/presentation/controllers/cubits/login_cubit.dart';
import '../../../auth/presentation/widgets/custom_text_field.dart';
import '../../../home/presentation/controllers/cubits/post/posts_cubit.dart';
import '../../../home/presentation/controllers/states/post/post_state.dart';
import '../../../home/presentation/widgets/post/post_widget.dart';
import '../../../home/presentation/widgets/post/shimmer/post_widget_shimmer.dart';
import '../controllers/cubits/profile_cubit.dart';
import '../controllers/states/profile_state.dart';
import '../widgets/post_profile_widget.dart';

class ProfilePage extends StatefulWidget {
  final String? userId;

  const ProfilePage({
    super.key,
    this.userId,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadProfile();
  }

  void _loadProfile() {
    context.read<ProfileCubit>().loadProfile(context, userId: widget.userId);
    context.read<PostsCubit>().loadProfilePosts(context, username: widget.userId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  AppText(text: state.errorMessage ?? 'An error occurred',
                    fontSize: 12,),
                  ElevatedButton(
                    onPressed: _loadProfile,
                    child: AppText(text: 'Retry', fontSize: 14,),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _buildProfileHeader(state),
                _buildBioSection(state),
                if (state.profileType == ProfileType.otherUser)
                  _buildFollowButton(state),
                _buildTabBar(context),
                _buildTabBarView(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(ProfileState state) {
    final user = state.user;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
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
                text: '${user?.user.firstName ?? ''} ${user?.user.lastName ??
                    ''}',
                fontSize: 16,
              ),
              AppText(
                text: '@${user?.user.username ?? ''}',
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

                context.go(
                  '/setting'
                );

                // Navigator.pushReplacementNamed(context, '/setting');
              },
            )
        ],
      ),
    );
  }

  Widget _buildBioSection(ProfileState state) {
    final user = state.user;
    final hasBio = user?.user.bio != null && user!.user.bio!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          AppText(
            text: hasBio
                ? user.user.bio!
                : 'قم بادخال سيرتك الذاتية هنا واجعل الناس يعرفوك اكثر ',
            fontSize: 12,
            color: const Color(0xEA6A6A6A),
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
                  constraints: BoxConstraints(
                    maxHeight: 600
                  ),
                  builder: (context) {
                  return Container(
                    height: 600,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)
                      )
                    ),
                    child: Column(
                      children: [
                        12.ph(),
                        Container(
                          height: 5,
                          width: 56,
                         
                          decoration: BoxDecoration(
                              color: const Color(0xffE7E8EA),
                              borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                        14.ph(),
                        Row(
                          children: [
                            Spacer(),
                            AppText(text: 'تعديل بروفايلي', fontSize: 16),
                            Spacer(),
                            IconButton(onPressed: () {

                            }, icon: Icon(Icons.close))
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
                                  border: Border.all(color: Colors.white, width: 2)
                                ),
                                child: Icon(Icons.edit, color: Colors.white, size: 16),
                              ),
                            )
                          ],
                        ),



                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              CustomTextField(
                                label: 'اليوزر نيم',
                                hintText: '@hema21',
                                controller: TextEditingController(),
                                // validator: (value) => value?.isEmpty ?? true ? 'أو اسم المستخدم مطلوب' : null,
                              ),
                              20.ph(),
                              CustomTextField(
                                label: 'نبذة عني',
                                hintText: 'نبذة عنك لا تتعدى 200 حرف',
                                controller: TextEditingController(),
                              ),
                              20.ph(),
                              CustomButton(widget: AppText(text: 'تعديل', fontSize: 16,color: Colors.white,), onPressed: () {

                              }, backgraoundColor: Color(0xff2769F2))
                            ],
                          ),
                        )


                      ],
                    ),
                  );
                },);


                // Handle bio add/edit button tap


              },
              backgraoundColor: const Color(0xFF2769F2),
            ),
          15.ph()
        ],
      ),
    );
  }

  Widget _buildFollowButton(ProfileState state) {
    // Add follow/unfollow button implementation
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomButton(
        height: 40,
        widget: AppText(
          text: 'Follow', // Or 'Unfollow' based on state
          fontSize: 14,
          color: Colors.white,
        ),
        onPressed: () {
          // Handle follow/unfollow
          // context.read<ProfileCubit>().followUser();
        },
        backgraoundColor: const Color(0xFF2769F2),
      ),
    );
  }

// Rest of the code remains the same (TabBar and TabBarView)...


// import 'package:academe_x/core/core.dart';
// import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
// import 'package:academe_x/features/auth/auth.dart';
// import 'package:academe_x/features/profile/presentation/controllers/cubits/profile_cubit.dart';
// import 'package:academe_x/features/profile/presentation/controllers/states/profile_state.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ProfilePage extends StatefulWidget {
//    ProfilePage({super.key });
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   UserResponseEntity? userResponseEntity;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//     if (kDebugMode) {
//     }
//   }
//   //get user cached data
//
//
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildProfileHeader(),
//             _buildBioSection(),
//             _buildTabBar(context),
//             _buildTabBarView(context),
//           ],
//         ),
//       ),
//     );
//     // return BlocBuilder<ProfileCubit, ProfileState>(
//     //   builder: (context, state) {
//     //     return
//     //   },
//     // );
//   }
//
//   Widget _buildProfileHeader() {
//     // final user = state.profileUser;
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             // backgroundImage: user?.photoUrl!= null
//             //   ? NetworkImage(user!.photoUrl!) as ImageProvider
//             //   : const AssetImage('assets/images/default_avatar.png'),
//           ),
//           10.pw(),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // AppText(text: '${user?.firstName ?? ''} ${user?.lastName ?? ''}', fontSize: 16),
//               AppText(text: 's', fontSize: 16),
//               AppText(
//                 // text: '@${user?.username ?? ''}',
//                 text: '@s',
//                 fontSize: 14,
//                 color: const Color(0xC4767676),
//               ),
//             ],
//           ),
//           const Spacer(),
//           IconButton(
//             icon: const Icon(
//               Icons.settings_outlined,
//               color: Color(0xffCCCCCC),
//             ),
//             onPressed: () {
//               // Handle settings tap
//             },
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBioSection() {
//     // final user = state.profileUser;
//     // final hasBio = user?.bio != null && user!.bio!.isNotEmpty;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.person),
//               4.pw(),
//               AppText(
//                 // text: hasBio ? 'السيرة الذاتية' : 'اضافة سيرة ذاتية !!',
//                 text:  'اضافة سيرة ذاتية !!',
//                 fontSize: 12,
//                 color: const Color(0xE0373737),
//               ),
//             ],
//           ),
//           6.ph(),
//           AppText(
//             // text: hasBio
//             //   ? user!.bio!
//             //   : ,
//             text: 'قم بادخال سيرتك الذاتية هنا واجعل الناس يعرفوك اكثر ',
//             fontSize: 12,
//             color: const Color(0xEA6A6A6A),
//           ),
//           8.ph(),
//           CustomButton(
//             height: 40,
//             widget: AppText(
//               // text: hasBio ? 'تعديل' : 'اضافة',
//               text: 'تعديل',
//               fontSize: 14,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               // Handle bio add/edit button tap
//             },
//             backgraoundColor: const Color(0xFF2769F2),
//           ),
//           15.ph()
//         ],
//       ),
//     );
//   }
//
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
        tabs: const [
          Tab(text: 'المنشورات'),
          Tab(text: 'الملفات'),
          Tab(text: 'تم حفظه'),
        ],
      ),
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildPostsList(),
          _buildTabContent('الملفات'),
          _buildTabContent('تم حفظه'),
        ],
      ),
    );
  }

  Widget _buildPostsList() {
    return BlocBuilder<PostsCubit,PostsState>(
      builder: (context, state) {
        switch (state.profileStatus) {
          case PostProfileStatus.initial:
          case PostProfileStatus.loading:
            return  ListView.builder(
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
            if (state.profilePosts.isEmpty) {
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
            if (state.profilePosts.isEmpty) {
              return const Center(child: Text('No posts found'));
            }
            break;
        }
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  if (index >= state.profilePosts.length) {
                    if (state.hasProfilePostsReachedMax) {
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

                  final post = state.profilePosts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        20.ph(),
                        PostWidget(post: post,),
                        if (index < state.profilePosts.length - 1) ...[
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
                childCount: state.hasProfilePostsReachedMax
                    ? state.profilePosts.length + 1
                    : state.profilePosts.length + 1,
              ),
            ),
          ],
        );
      },

    );
  }

  Widget _buildTabContent(String text) {
    return Container(
      child: Center(
        child: CustomButton(widget: AppText(text: 'Logout', fontSize: 16), onPressed:() async{
          await  context.read<LoginCubit>().logout();

        }, backgraoundColor: Colors.blue)
      ),
    );
  }
}
// }
