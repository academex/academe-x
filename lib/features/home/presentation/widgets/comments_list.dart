import 'package:academe_x/core/domy_data/domy_comments.dart';
import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/core/widgets/app_text.dart';
import 'package:academe_x/core/widgets/app_text_field.dart';
import 'package:academe_x/features/home/presentation/controllers/states/comment/reply_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/cubits/comment/reply_cubit.dart';
import '../controllers/cubits/comment/show_replies_cubit.dart';
import '../controllers/states/comment/show_replyes_state.dart';
import 'comment_card.dart'; // Assuming this is the file name

class CommentsList {
  final FocusNode _focusNode = FocusNode();
  TextEditingController comment = TextEditingController();
  CommentsList({required postId, required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This allows the modal to take more space

      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ReplyCubit>(
              create: (context) => ReplyCubit(ReplySatae(commenter: '')),
            ),
            BlocProvider<ShowRepliesCubit>(
              create: (context) => ShowRepliesCubit(ShowReplyesState(index: 0)),
            ),
          ],
          child: FractionallySizedBox(
            heightFactor: 0.9, // Modal height
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom), // Adjust for keyboard
              child: Column(
                children: [
                  20.ph(),
                  SizedBox(
                    width: 56.w, // Custom width for the divider
                    child: Divider(
                      thickness: 5.h, // Thickness of the divider
                      color: const Color(0xffE7E8EA), // Color of the divider
                    ),
                  ),
                  16.ph(),
                  AppText(
                    text: 'التعليقات',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  20.ph(),
                  // Use Expanded to make the list scrollable
                  Expanded(
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CommentCard(
                              commenter: comments[index].commenter,
                              commentText: comments[index].commentText,
                              likes: comments[index].likes,
                              replies:comments[index].replies,
                              reply: () {
                                context.read<ReplyCubit>().reply(
                                    commenter:
                                        'رد على @${comments[index].commenter}');
                              },
                              commentIndex: index,
                            ),
                            BlocBuilder<ShowRepliesCubit, ShowReplyesState>(
                              buildWhen: (previous, current) {
                                return current.index == index;
                              },
                                builder: (context, state) {
                              return Column(
                                children: [
                                  for (int i = 0; 
                                  i < comments[index].replies.length &&  state.show && state.index == index; i++)
                                    CommentCard(
                                      isReply: true,
                                      commenter:
                                          comments[index].replies[i].commenter,
                                      commentText: comments[index]
                                          .replies[i]
                                          .commentText,
                                      likes: comments[index].replies[i].likes,
                                      reply: () {
                                        context.read<ReplyCubit>().reply(
                                            commenter:
                                                'رد على @${comments[index].replies[i].commenter}');
                                      },
                                      isEndReply: i == ((comments[index].replies.length)-1),
                                    ),
                                ],
                              );
                            }),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 5.h, left: 24.w, right: 24.w, top: 2.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<ReplyCubit, ReplySatae>(
                            builder: (context, state) {
                              comment.text = state.commenter != ''
                                  ? '${state.commenter}: '
                                  : '';
                              return AppTextField(
                                autofocus: comment.text.isNotEmpty,
                                focusNode: _focusNode,
                                controller: comment,
                                hintText: 'اكتب تعليقك...',
                                keyboardType: TextInputType.multiline,
                                maxLine: 3,
                                minLine: 1,
                                withBoarder: true,
                                // prefixText: state.commenter,
                                suffix: GestureDetector(
                                  onTap: () {
                                    if (comment.text != '') {
                                      context
                                          .read<ReplyCubit>()
                                          .reply(commenter: '');
                                      comment.clear();
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                  child: const ImageIcon(
                                    AssetImage('assets/images/send.png'),
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        18.pw(),
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                              color: Colors
                                  .white, // Background color of the container
                              borderRadius:
                                  BorderRadius.circular(12), // Rounded corners
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12, // Shadow color
                                  blurRadius: 4, // Shadow blur
                                  offset: Offset(0, 2), // Shadow position
                                ),
                              ],
                              border: Border.all(color: Colors.black12)),
                          child: Center(
                            child: AppText(
                              text: '😍', // Emoji
                              fontSize: 20.sp, // Size of the emoji
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
