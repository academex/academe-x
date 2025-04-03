import 'package:flutter/material.dart';

class Reaction<T> {
  const Reaction({
    required this.value,
    required this.icon,
    Widget? previewIcon,
    this.title,
  }) : previewIcon = previewIcon ?? icon;

  final Widget icon;
  final Widget previewIcon;
  final Widget? title;
  final T? value;

  @override
  bool operator ==(Object? other) {
    return other is Reaction &&
        icon == other.icon &&
        icon.key == other.icon.key &&
        previewIcon == other.previewIcon &&
        previewIcon.key == other.previewIcon.key &&
        title == other.title &&
        title?.key == other.title?.key;
  }

  @override
  int get hashCode {
    return Object.hash(icon, previewIcon, title);
  }
}