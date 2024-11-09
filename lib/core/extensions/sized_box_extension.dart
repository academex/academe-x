<<<<<<< HEAD

import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';

extension sizedBoxExtension on num {
  Widget ph() => SizedBox(
        height: h,
      );
  Widget pw() => SizedBox(
        width: w,
=======
// ignore_for_file: camel_case_extensions, unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension sizedBoxExtension on num {
  Widget ph() => SizedBox(
        height: this.h,
      );
  Widget pw() => SizedBox(
        width: this.w,
>>>>>>> 536135a (Description of changes)
      );
}
