import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final int postId;
  final bool isSaved;
  final VoidCallback onSave;

  const SaveButton({
    required this.postId,
    required this.isSaved,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        isSaved
            ? 'assets/icons/bookMark_selected.png'
            : 'assets/icons/Bookmark.png',
        height: 17,
        width: 19,
      ),
      padding: EdgeInsets.zero,
      onPressed: onSave,
    );
  }
}