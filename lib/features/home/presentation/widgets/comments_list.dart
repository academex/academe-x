import 'package:academe_x/core/extensions/sized_box_extension.dart';
import 'package:academe_x/core/widgets/app_text.dart';
import 'package:academe_x/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/comment.dart';
import 'comment_card.dart'; // Assuming this is the file name

class CommentsList {
  final FocusNode _focusNode = FocusNode();
  TextEditingController comment = TextEditingController();
  CommentsList({required postId, required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This allows the modal to take more space

      builder: (context) {
        String text = '';
        // this list will get from api
        List<Comment> comments = [
          Comment(
              commenter: 'Baraa',
              commentText:
                  ' حتوى رائع استمر يا عبقري العباقر محتوى رائع استمر يا عبقري العباقرة',
              likes: 70,
              createdAt: DateTime.now()),
          Comment(
              commenter: 'Ahmed Dadar',
              commentText:
                  ' حتوى رائع استمر يا عبقري العباقر حتوى رائع استمر يا عبقري العباقر محتوى رائع استمر يا عبقري العباقرة',
              likes: 70,
              createdAt: DateTime.now()),
          Comment(
              commenter: 'Hussen GHabayen',
              commentText: 'محتوى رائع استمر يا عبقري العباقرة',
              likes: 70,
              createdAt: DateTime.now()),
          Comment(
              commenter: 'Alaa M Mubarak',
              commentText: 'محتوى رائع استمر يا عبقري العباقرة',
              likes: 70,
              createdAt: DateTime.now()),
          Comment(
              commenter: 'Alaa M Mubarak',
              commentText: 'محتوى رائع استمر يا عبقري العباقرة',
              likes: 70,
              createdAt: DateTime.now()),
          Comment(
              commenter: 'Alaa M Mubarak',
              commentText: 'محتوى رائع استمر يا عبقري العباقرة',
              likes: 70,
              createdAt: DateTime.now()),
          Comment(
              commenter: 'Alaa M Mubarak',
              commentText: 'محتوى رائع استمر يا عبقري العباقرة',
              likes: 70,
              createdAt: DateTime.now()),
          Comment(
              commenter: 'Alaa M Mubarak',
              commentText: 'محتوى رائع استمر يا عبقري العباقرة',
              likes: 70,
              createdAt: DateTime.now()),
          Comment(
              commenter: 'Alaa M Mubarak',
              commentText: 'محتوى رائع استمر يا عبقري العباقرة',
              likes: 70,
              createdAt: DateTime.now()),
          Comment(
              commenter: 'Alaa M Mubarak',
              commentText: 'محتوى رائع استمر يا عبقري العباقرة',
              likes: 70,
              createdAt: DateTime.now()),
          Comment(
              commenter: 'Alaa M Mubarak',
              commentText: 'محتوى رائع استمر يا عبقري العباقرة',
              likes: 70,
              createdAt: DateTime.now()),
          Comment(
              commenter: 'Alaa M Mubarak',
              commentText: 'محتوى رائع استمر يا عبقري العباقرة',
              likes: 70,
              createdAt: DateTime.now()),
          Comment(
              commenter: 'Alaa M Mubarak',
              commentText: 'محتوى رائع استمر يا عبقري العباقرة',
              likes: 70,
              createdAt: DateTime.now()),
          Comment(
              commenter: 'End M Mubarak',
              commentText: 'محتوى رائع استمر يا عبقري العباقرة',
              likes: 70,
              createdAt: DateTime.now()),
        ];
        return FractionallySizedBox(
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
                            reply: () {
                              FocusScope.of(context).requestFocus(_focusNode);
                              text = 'رد على @${comments[index].commenter}';
                            },
                          ),
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
                        child: AppTextField(
                          focusNode: _focusNode,
                          controller: comment,
                          hintText: 'اكتب تعليقك...',
                          keyboardType: TextInputType.multiline,
                          prefixText: text,
                          suffix: GestureDetector(
                            onTap: () {
                              comment.clear();
                              FocusScope.of(context).unfocus();
                            },
                            child: const ImageIcon(
                              AssetImage('assets/images/send.png'),
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      18.pw(),
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color:
                              Colors.white, // Background color of the container
                          borderRadius:
                              BorderRadius.circular(12), // Rounded corners
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12, // Shadow color
                              blurRadius: 4, // Shadow blur
                              offset: Offset(0, 2), // Shadow position
                            ),
                          ],
                          border: Border.all(color: Colors.black12)
                        ),
                        child: Center(
                          child: AppText(
                            text: '😍', // Emoji
                            fontSize: 28.sp, // Size of the emoji
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
