import 'package:equatable/equatable.dart';

class BottomSheetState extends Equatable {
  final double currentHeight;
  final double minHeight;
  final double maxHeight;
  final bool isDragging;

  const BottomSheetState({
    required this.currentHeight,
    required this.minHeight,
    required this.maxHeight,
    this.isDragging = false,
  });

  factory BottomSheetState.initial({
    required double initialHeight,
    required double minHeight,
    required double maxHeight,
  }) {
    return BottomSheetState(
      currentHeight: initialHeight,
      minHeight: minHeight,
      maxHeight: maxHeight,
    );
  }

  BottomSheetState copyWith({
    double? currentHeight,
    double? minHeight,
    double? maxHeight,
    bool? isDragging,
  }) {
    return BottomSheetState(
      currentHeight: currentHeight ?? this.currentHeight,
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
      isDragging: isDragging ?? this.isDragging,
    );
  }

  @override
  List<Object?> get props => [currentHeight, minHeight, maxHeight, isDragging];
}