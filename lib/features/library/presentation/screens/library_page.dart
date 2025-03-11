import 'dart:async';

import 'package:academe_x/features/library/domain/entities/library_entity.dart';
import 'package:academe_x/features/library/presentation/controllers/cubits/library_cubit.dart';
import 'package:academe_x/features/library/presentation/controllers/states/library_state.dart';
import 'package:academe_x/features/profile/presentation/controllers/cubits/profile_cubit.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../home/presentation/widgets/post/shimmer/post_widget_shimmer.dart';
import '../widgets/shimmer/library_widget_shimmer.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {

  Timer? _debounce;
  late ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() async{
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (_isBottom) {
         context.read<LibraryCubit>().loadLibrary(context: context);
      }
    });
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }
    final maxScroll = _scrollController
        .position
        .maxScrollExtent;
    final currentScroll =
        _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: true,
              expandedHeight: 90,
              pinned: true,
              leading: 0.pw(),
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final percent = (constraints.maxHeight - kToolbarHeight) /
                      (90 - kToolbarHeight);
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: AnimatedOpacity(
                        opacity: percent < 0.2 ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 100),
                        child: _buildHeaderContent(true, context)),
                    background: _buildHeaderBackground(false, context),
                  );
                },
              ),
            ),
            SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver:BlocBuilder<LibraryCubit, LibraryState>(
                  builder: (context, state) {
                    // state.
                    switch (state.status) {
                      case LibraryStatus.initial:
                      case LibraryStatus.loading:
                        return SliverFillRemaining(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => const Column(
                                children: [
                                  LibraryWidgetShimmer(),
                                ],
                              ),
                            )
                          //
                        );
                      case LibraryStatus.error:
                        if (state.libraryFiles.isEmpty) {
                          return SliverFillRemaining(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(state.errorMessage ?? 'Failed to fetch posts'),
                                  16.ph(),
                                  ElevatedButton(
                                    onPressed: () async {
                                      // return await context.read<LibraryCubit>().loadLibrary();
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        break;
                      case LibraryStatus.loaded:
                        if (state.libraryFiles.isEmpty) {
                          return const SliverFillRemaining(
                            child: Center(child: Text('No Files found')),
                          );
                        }
                        break;
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final entry = state.libraryFiles.entries.elementAt(index);
                              final type = entry.key;
                              final items = entry.value;
                              if (items.isEmpty) return const SizedBox.shrink();
                              final libraryItems = items.map((file) => LibraryItem(file: file)).toList();

                              if (index >= state.libraryFiles.length) {
                            // AppLogger.success('reach the end');
                            // if (state.hasLibraryReachedMax) {
                            //   AppLogger.success('reach the end');
                            //   return Column(
                            //     children: [
                            //       20.ph(),
                            //       Container(
                            //         padding: const EdgeInsets.symmetric(vertical: 16),
                            //         alignment: Alignment.center,
                            //         child: Text(
                            //           'You\'ve reached the end!',
                            //           style: TextStyle(
                            //             color: Colors.grey.shade600,
                            //             fontSize: 14,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   );
                            // }
                            return const LibraryWidgetShimmer();
                          }
                          return Column(
                            children: [
                              20.ph(),
                               LibrarySection(icon:'assets/icons/book_icon.png', title: type!, items: libraryItems),
                            ],
                          );
                        },
                        childCount: state.libraryFiles.length ,
                      ),
                    );
                  },
                ),
                ),
          ],

        ),
        onRefresh: () async {
          await context.read<LibraryCubit>().loadLibrary(context: context);
        });
  }

  Widget _buildHeaderBackground(bool inScroll, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2200F2),
      ),
      child: _buildHeaderContent(inScroll, context),
    );
  }

  Widget _buildHeaderContent(bool inScroll, BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                  height: 45,
                  child: HeaderWidget(
                    inScroll: inScroll,
                    logoPath: 'assets/images/Frame.png',
                    title: 'مكتبتي',
                    subTitle: 'كل ما تحتاجه من كتب وملخصات وشباتر',
                    firstIconPath: 'assets/icons/filter.png',
                    onTap: () => showFilteringOptions(context),
                  )),
            ),
            // inScroll ? 0.ph() : 15.ph(),
            // inScroll ? 0.ph() : _buildCategoryTabs(),
          ],
        ));
  }

  Future showFilteringOptions(BuildContext context) {
    return showModalBottomSheet(
        constraints: const BoxConstraints(
          maxHeight: 700,
        ),
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    10.ph(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 56,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15)),
                        )
                      ],
                    ),
                    20.ph(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        AppText(
                          text: 'فلترة',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                      ],
                    ),
                    20.ph(),
                    CollegeSelectionWidget(
                      ctx: NavigationService.navigatorKey.currentContext!,
                    ),

                    20.ph(),
                    // AppTextField(hintText: 'الكلية', keyboardType: )
                    SizedBox(
                      height: 98,
                      // width: 326,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(text: 'سنة الدراسة الحالية ', fontSize: 14),
                          16.ph(),
                          BlocBuilder<SignupCubit, AuthState>(
                            builder: (context, state) {
                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  int crossAxisCount =
                                  SizeConfig().getCrossAxisCount(context);
                                  double itemHeight =
                                  SizeConfig().getItemHeight(context);
                                  int rowCount = ([
                                    'أولى',
                                    'ثانية',
                                    'ثالتة',
                                    'رابعة',
                                  ].length /
                                      crossAxisCount)
                                      .ceil();
                                  double gridHeight = rowCount * itemHeight;
                                  return SizedBox(
                                    height: gridHeight,
                                    child: ShowGridViewItem<String>(
                                      crossAxisCount: crossAxisCount,
                                      data: const [
                                        'أولى',
                                        'ثانية',
                                        'ثالتة',
                                        'رابعة',
                                      ],
                                      onTap: (index, string) {
                                        context.read<SignupCubit>().selectIndex(
                                            index: index,
                                            selectionType:
                                            SelectionType.semester);
                                      },
                                      selectedIndex: context
                                          .read<SignupCubit>()
                                          .state
                                          .selectedSemesterIndex,
                                      displayTextBuilder: (p0) => p0,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    20.ph(),
                    CustomButton(
                      widget: AppText(
                        text: 'تطبيق',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      onPressed: () async{
                        // AppLogger.success('${context.read<SignupCubit>().state.selectedSemesterIndex!+1}'.toString());
                        int? tagId= context.read<SignupCubit>().state.selectedTagId;
                        int? yearNum= context.read<SignupCubit>().state.selectedSemesterIndex!+1;
                        Navigator.pop(context);
                      await  context.read<LibraryCubit>().loadLibrary(context: context,yearNum: yearNum,tagId: tagId);

                      },
                      backgraoundColor: const Color(0xFF0077FF),
                    )
                  ],
                ),
              ));
        });
  }

}
