import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/home/presentation/widgets/post/post_widget.dart';
import 'package:academe_x/features/home/presentation/widgets/post/shimmer/post_widget_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/cubits/post/posts_cubit.dart';
import '../../controllers/states/post/post_state.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;

  const PostDetailScreen({Key? key, required this.postId}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  @override
  void didUpdateWidget(PostDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.postId != widget.postId) {
      _loadPost();
    }
  }

  void _loadPost() async{
   await context.read<PostsCubit>().loadPostDetails(postId: widget.postId);
    // context.read<PostsCubit>().loadPostDetails(widget.postId);
  }

  void _handleBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      context.go('/home_screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _handleBack(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Post Details ${widget.postId}'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _handleBack(context),
          ),
        ),
        body: BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {

            switch (state.postDetailsStatus) {
              case PostDetailsStatus.initial:
              case PostDetailsStatus.loading:
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

              case PostDetailsStatus.failure:
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

              case PostDetailsStatus.success:
                if (state.posts.isEmpty) {
                  return const SliverFillRemaining(

                    child: Center(child: Text('No posts found')),
                  );
                }
                break;
            }

            return PostWidget(post: state.post!);
            // if (state is PostDetailsLoading) {
            //   return const Center(child: CircularProgressIndicator());
            // }
            //
            // if (state is PostDetailsError) {
            //   return Center(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(state.error),
            //         ElevatedButton(
            //           onPressed: _loadPost,
            //           child: const Text('Retry'),
            //         ),
            //       ],
            //     ),
            //   );
            // }
            //
            // if (state is PostDetailsLoaded) {
            //   return RefreshIndicator(
            //     onRefresh: () async => _loadPost(),
            //     child: SingleChildScrollView(
            //       physics: const AlwaysScrollableScrollPhysics(),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           // Your post detail UI here
            //         ],
            //       ),
            //     ),
            //   );
            // }

            return const Center(child: Text('Post not found'));
          },
        ),
      ),
    );
  }
}