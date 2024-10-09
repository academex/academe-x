import 'package:flutter/material.dart';

class AppCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final double elevation;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showCloseButton;
  final VoidCallback? onCloseButtonPressed;

  AppCustomAppBar({
    Key? key,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0.0,
    this.leading,
    this.actions,
    this.showCloseButton = false,
    this.onCloseButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: backgroundColor,
      leading: leading ??
          (showCloseButton
              ? const SizedBox()
              : const BackButton(
            color: Colors.black,
          )),
      actions: actions ??
          (showCloseButton
              ? [
            IconButton(
              onPressed: onCloseButtonPressed ??
                      () {
                    Navigator.pop(context);
                  },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ]
              : null),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
