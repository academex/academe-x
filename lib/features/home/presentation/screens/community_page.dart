import 'dart:async';

import 'package:academe_x/core/constants/app_colors.dart';
import 'package:academe_x/core/utils/extensions/context_extenssion.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_majors_state.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import 'package:academe_x/features/home/presentation/widgets/community/community_header.dart';
import 'package:academe_x/features/home/presentation/widgets/community/community_posts_list.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    _scrollController = context.read<PostsCubit>().homePostsScrollController;
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
        context.read<PostsCubit>().loadPosts(
            tagId: context.read<CollegeMajorsCubit>().state.selectedMajor!.id!);
      }
    });
  }

  bool get _isBottom {
    if (!context.read<PostsCubit>().homePostsScrollController.hasClients) {
      return false;
    }
    final maxScroll = context
        .read<PostsCubit>()
        .homePostsScrollController
        .position
        .maxScrollExtent;
    final currentScroll =
        context.read<PostsCubit>().homePostsScrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Widget _buildSliverAppBar() {
    return BlocBuilder<CollegeMajorsCubit, CollegeMajorsState>(
      builder: (context, state) => SliverAppBar(
        automaticallyImplyLeading: true,
        expandedHeight: state.isVisibileMajors
            ? context.hp(24)
            : context.hp(13),
        pinned: true,
        leading: const SizedBox.shrink(),
        flexibleSpace: LayoutBuilder(
          builder: (context, constraints) {
            final expandedHeight = state.isVisibileMajors
                ? context.hp(31)
                : context.hp(18.5);
            final percent = (constraints.maxHeight - kToolbarHeight) /
                (expandedHeight - kToolbarHeight);
                AppLogger.auth(percent.toString());
            return FlexibleSpaceBar(
              centerTitle: true,
              title: AnimatedOpacity(
                opacity: percent < 0.2 ? 0.0 : percent ==0.25794641371276417 ||percent ==0.5129902366374318? 1.0 : 0.0,
                duration: const Duration(milliseconds: 100),
                child: CommunityHeader(inScroll: true, state: state),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                ),
                child: CommunityHeader(inScroll: false, state: state),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return await context.read<PostsCubit>().refreshPosts(
            context.read<CollegeMajorsCubit>().state.selectedMajor!.id!);
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        shrinkWrap: true,
        slivers: [
          _buildSliverAppBar(),
          const CommunityPostsList(),
        ],
      ),
    );
  }
}
