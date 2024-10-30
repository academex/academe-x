import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/core/widgets/app_text.dart';
import 'package:academe_x/features/home/presentation/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/app_size.dart';
import '../controllers/cubits/home/category_cubit.dart';
import '../widgets/library_item.dart';
import '../widgets/library_section.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: true,
          expandedHeight: 200.h,
          pinned: true,
          leading: 0.pw(),
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              // Get the scroll percentage (1 = fully expanded, 0 = collapsed)
              final percent = (constraints.maxHeight - kToolbarHeight) /
                  (200.h - kToolbarHeight);
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
                padding: EdgeInsets.symmetric(horizontal: kPaddingHorizontal.w),
                child:  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return LibrarySection(
                        icon: 'assets/icons/book_icon.png',
                        title: 'الكتب',
                        items: List.generate(
                          4,
                              (index) {
                            return const LibraryItem(
                              title: 'كتاب علم البرمجة',
                              description:
                              'مختص بشرح اهم اساسيات البرمجة ',
                            );
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return 20.ph();
                    },
                    itemCount: 5),)),
      ],
    );
  }

  Widget _buildHeaderBackground(bool inScroll) {
    return Container(
      height: 20.81.h,
      // width: 375.w,
      decoration: const BoxDecoration(
        // color: Color(0xFF0077FF),
        image: DecorationImage(
          image: AssetImage('assets/images/background_library.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: _buildHeaderContent(inScroll),
    );
  }

  Widget _buildHeaderContent(bool inScroll) {
    return inScroll
        ? SafeArea(
            child: Column(
            children: [
              Expanded(
                child: Padding(padding: EdgeInsets.symmetric(horizontal: 20.w),child: SizedBox(
                  // width: 327.w,
                  // 327.w,
                  // height: 45.h,
                  child:
                  HeaderWidget(inScroll: inScroll, logoPath: 'assets/icons/logo_library.png', title: 'مكتبتي', subTitle: 'كل ما تحتاجه من كتب وملخصات وشباتر', secondIconPath: 'assets/icons/filter.png'),
                ),)
              ),
              inScroll ? 0.ph() : kPaddingHorizontal.ph(),
              inScroll ? 0.ph() : _buildCategoryTabs(),
            ],
          ))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              inScroll ? 0.ph() : 40.ph(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderWidget(inScroll: inScroll, logoPath: 'assets/icons/logo_library.png', title: 'مكتبتي', subTitle: 'كل ما تحتاجه من كتب وملخصات وشباتر', secondIconPath: 'assets/icons/filter.png'),
                    16.ph(),
                    AppText(
                      text: 'المواد الخاصة بي',
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    20.ph(),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(right: 24.w),
                child: SizedBox(
                  height: 40.h,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 70.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                    // image:
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Center(
                                  child: Text('data'),
                                ),
                              ),
                              onTap: () {
                                // context
                                //     .read<CategoryCubit>()
                                //     .selectCategory(index);
                              },
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return 10.pw();
                      },
                      itemCount: 5),
                ),
              ),

              // _buildCategoryTabs(),
            ],
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
}
