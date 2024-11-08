
import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';

extension sizedBoxExtension on num {
  Widget ph() => SizedBox(
        height: h,
      );
  Widget pw() => SizedBox(
        width: w,
      );
}
