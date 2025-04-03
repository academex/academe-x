import 'package:academe_x/features/library/domain/entities/file_entity.dart';
import 'package:academe_x/features/library/domain/entities/library_entity.dart';
import 'package:academe_x/features/profile/presentation/screens/profile_page.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:academe_x/lib.dart';
import '../../../library/presentation/controllers/cubits/file_upload_cubit.dart';
import '../../../library/presentation/controllers/states/file_upload_state.dart';
import '../../../library/presentation/screens/library_page.dart';
import '../../../library/presentation/widgets/file_selection_card.dart';
import '../../../library/presentation/widgets/upload_progress_widget.dart';
import '../widgets/SuccessCard.dart';
import '../widgets/lib/flutter_reaction_button.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen();

  TextEditingController nameController= TextEditingController();
  TextEditingController subjectController= TextEditingController();
  TextEditingController descriptionController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    // StorageService.getUser()!.user.
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          floatingActionButton:
              _buildFloatingActionButton(context, currentIndex),
          bottomNavigationBar: const CustomBottomNavBar(),
          body: _buildBody(currentIndex, context),
        );
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context, int currentIndex) {
    if (currentIndex != NavigationIndex.library) return const SizedBox.shrink();
    return FloatingActionButton(
      elevation: 0,
      // clipBehavior: Clip.antiAlias,

      backgroundColor: const Color(0xff0077FF),

      child: Image.asset(
        AppAssets.upload,
      ),
      onPressed: () => _handleUploadFile(context),
    );
  }

  Widget _buildBody(int currentIndex, BuildContext context) {
    return IndexedStack(
      index: currentIndex,
      children: [
        const CommunityPage(),
        const LibraryPage(),
        const Row(),
        Container(
          child: Center(
              child: CustomButton(
                  widget: AppText(text: 'Logout', fontSize: 16),
                  onPressed: () async {
                    await context.read<LoginCubit>().logout();
                  },
                  backgraoundColor: Colors.blue)),
        ),
        const ProfilePage(),
      ],
    );
  }

  void _handleUploadFile(BuildContext context) async {
    await showCreateFileSheet(context);
  }

  Future<void> showCreateFileSheet(BuildContext context) async {
    return showModalBottomSheet(
        constraints: BoxConstraints(maxHeight: 700),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return BlocConsumer<FileUploadCubit, FileUploadState>(
              listener: (ctx, state) {
            if (state.status == FileUploadStatus.success) {
              context.read<FileUploadCubit>().reset();
            }
          }, builder: (context, state) {
            return ListView(
              children: [
                10.ph(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 5,
                      decoration: ShapeDecoration(
                        color: Color(0xFFE7E8EA),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    AppText(
                      text: 'رفع ملف',
                      color: Color(0xFF0F172A),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          context.read<FileUploadCubit>().reset();
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                24.ph(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => context.read<FileUploadCubit>().pickFile(),
                        child: DottedBorder(
                            dashPattern: const [7, 13],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(15),
                            color: Colors.grey,
                            child: Container(
                              width: 327,
                              height: 60,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF9F9F9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: state.file?.name == null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.cloud_upload_rounded,
                                          color: Colors.blue,
                                        ),
                                        10.pw(),
                                        AppText(
                                          text: 'منطقة مخصصة لرفع الملف',
                                          fontSize: 14,
                                          color: Color(0xFF646C7C),
                                        )
                                      ],
                                    )
                                  : Center(
                                      child: AppText(
                                        text: state.file!.name!,
                                        fontSize: 16,
                                      ),
                                    ),
                            )),
                      ),
                      20.ph(),
                      CustomTextField(
                          label: 'العنوان',
                          hintText: 'أدخل عنوان الملف هنا',
                          controller: nameController),
                      20.ph(),
                      CustomTextField(
                          label: 'المادة',
                          hintText: 'أدخل اسم المادة هنا',
                          controller: subjectController),
                      20.ph(),
                      CustomTextField(
                        label: 'الوصف',
                        hintText: 'أدخل وصف الملف هنا (اختياري)',
                        controller: descriptionController,
                      ),
                      20.ph(),
                      CollegeSelectionWidget(
                        ctx: NavigationService.navigatorKey.currentContext!,
                      ),
                      20.ph(),
                      SizedBox(
                        height: 98,
                        // width: 326,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(text: 'سنة الدراسة ', fontSize: 14),
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
                                          context
                                              .read<SignupCubit>()
                                              .selectIndex(
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
                      AppText(
                        text: 'نوع الملف',
                        color: Color(0xFF0F172A),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      10.ph(),
                      BlocBuilder<FileUploadCubit, FileUploadState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(4, (index) {
                              return _buildFileType(
                                  typeName: state.typesOfFiles[index],
                                  index:index,
                                  selectedIndex: state.selectedIndex,
                                  onTap: () {
                                    context.read<FileUploadCubit>().selectType(index);

                                  });
                            }),
                          );
                        },
                      ),
                      20.ph(),
                      CustomButton(
                        widget: AppText(
                          text: 'رفع الملف',
                          color: state.file == null
                              ? Color(0x70001A27)
                              : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        onPressed: () async {

                          if (state.file != null &&
                              state.status != FileUploadStatus.uploading) {
                            int? tagId= context.read<SignupCubit>().state.selectedTagId;
                            int? yearNum= context.read<SignupCubit>().state.selectedSemesterIndex!+1;
                            FileEntity newFile= FileEntity(
                              name: nameController.text,
                              subject: subjectController.text,
                              description: descriptionController.text,
                              tagId: tagId,
                              yearNum: yearNum,
                              type: state.typesOfFiles[state.selectedIndex!]

                              // file: state.file
                            );
                             context.read<FileUploadCubit>().uploadFile(newFile,context);
                            Navigator.pop(context);
                          }
                        },
                        backgraoundColor: state.file == null
                            ? Colors.white
                            : Color(0xdd2769F2),
                        wihtBorder: state.file == null ? true : false,
                      ),
                    ],
                  ),
                )
              ],
            );
          });
        });
  }

  /*


   */

  Widget _buildFileType({required String typeName, required Function() onTap,required int index,required int? selectedIndex}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 69,
            height: 56,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              // borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFF9F9F9),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.80, color:selectedIndex==null? Color(0x38E1E1E1):  selectedIndex== index?const Color(0xFF0077FF): const Color(0x38E1E1E1)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),

          ),
          5.ph(),
          AppText(
            text: typeName,
            fontSize: 16,
            color: Color(0xFF646C7C),
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}
