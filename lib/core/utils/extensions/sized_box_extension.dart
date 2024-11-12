
import 'package:flutter/material.dart';


extension SizedBoxExtension on num {
  Widget ph() => SizedBox(
    height: toDouble(),  // Convert num to double
  );
  Widget pw() => SizedBox(
    width: toDouble(),   // Convert num to double
  );
}