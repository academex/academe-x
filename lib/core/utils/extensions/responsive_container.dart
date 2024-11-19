import 'package:academe_x/lib.dart';
import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;
  final Color? backgroundColor;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.decoration,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = width ?? constraints.maxWidth;
        double maxHeight = height ?? constraints.maxHeight;

        if (context.isLandscape) {
          maxWidth = maxWidth * 0.8;
          maxHeight = maxHeight * 0.9;
        }

        return Container(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
          ),
          padding: padding,
          decoration: decoration,
          color: backgroundColor,
          child: child,
        );
      },
    );
  }
}