// lib/src/common/position_notifier.dart
import 'package:academe_x/features/home/presentation/widgets/lib/src/common/position.dart';
import 'package:flutter/material.dart';

class PositionNotifier extends ValueNotifier<PositionData> {
  PositionNotifier() : super(const PositionData.init());
}