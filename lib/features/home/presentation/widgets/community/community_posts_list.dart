import 'package:academe_x/core/constants/app_colors.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/post/post_state.dart';
import 'package:academe_x/features/home/presentation/widgets/community/community_empty_state.dart';
import 'package:academe_x/features/home/presentation/widgets/community/community_end_indicator.dart';
import 'package:academe_x/features/home/presentation/widgets/post/shimmer/post_widget_shimmer.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Community posts list with infinite scroll support.
///
/// Displays posts in a sliver list with proper loading,
/// error, and empty states. Supports pagination and
/// shows shimmer loading for new posts.
class CommunityPostsList extends StatelessWidget {
  const CommunityPostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.initial:
            case PostStatus.loading:
              return SliverFillRemaining(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Column(
                    children: [
                      const PostWidgetShimmer(),
                      Divider(
                        color: AppColors.grey.withOpacity(0.3),
                        endIndent: 25,
                        indent: 25,
                      ),
                    ],
                  ),
                ),
              );

            case PostStatus.failure:
              if (state.posts.isEmpty) {
                return SliverFillRemaining(
                  child: CommunityEmptyState(
                    message: state.errorMessage,
                    isError: true,
                    onRetry: () async {
                      return await context.read<PostsCubit>().loadPosts();
                    },
                  ),
                );
              }
              break;

            case PostStatus.success:
              if (state.posts.isEmpty) {
                return const SliverFillRemaining(
                  child: CommunityEmptyState(
                    message: 'No posts found',
                    isError: false,
                  ),
                );
              }
              break;
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= state.posts.length) {
                  if (state.hasPostsReachedMax) {
                    AppLogger.success('reach the end');
                    return const CommunityEndIndicator();
                  }
                  return const PostWidgetShimmer();
                }

                final post = state.posts[index];
                return Column(
                  children: [
                    20.ph(),
                    PostWidget(
                      post: post,
                    ),
                    if (index < state.posts.length - 1) ...[
                      16.ph(),
                      Divider(
                        color: AppColors.grey.withOpacity(0.3),
                        endIndent: 25,
                        indent: 25,
                      ),
                      16.ph(),
                    ],
                  ],
                );
              },
              childCount: state.hasPostsReachedMax
                  ? state.posts.length
                  : state.posts.length,
            ),
          );
        },
      ),
    );
  }
}
