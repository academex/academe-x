import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/cubits/bottom_sheet/bottom_sheet_cubit.dart';
import '../../controllers/states/bottom_sheet/bottom_sheet_state.dart';

class ResizableBottomSheet extends StatelessWidget {
  final Widget child;
  final double minHeight;
  final double maxHeight;
  final double initialHeight;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color? backgroundColor;
  final double borderRadius;

  const ResizableBottomSheet({
    Key? key,
    required this.child,
    this.minHeight = 100.0,
    this.maxHeight = 900.0,
    this.initialHeight = 900.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.backgroundColor,
    this.borderRadius = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomSheetCubit(
        initialHeight: initialHeight,
        minHeight: minHeight,
        maxHeight: maxHeight,
      ),
      child: _ResizableBottomSheetContent(
        animationDuration: animationDuration,
        animationCurve: animationCurve,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }
}

class _ResizableBottomSheetContent extends StatelessWidget {
  final Widget child;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color? backgroundColor;
  final double borderRadius;

  const _ResizableBottomSheetContent({
    Key? key,
    required this.child,
    required this.animationDuration,
    required this.animationCurve,
    required this.backgroundColor,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetCubit, BottomSheetState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: state.isDragging ? Duration.zero : animationDuration,
          curve: animationCurve,
          height: state.currentHeight,
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(borderRadius),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              _DragHandle(),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (_) {
        context.read<BottomSheetCubit>().startDragging();
      },
      onVerticalDragUpdate: (details) {
        context.read<BottomSheetCubit>().updateHeight(details.primaryDelta!);
      },
      onVerticalDragEnd: (_) {
        context.read<BottomSheetCubit>().stopDragging();
      },
      child: Container(
        height: 24,
        alignment: Alignment.center,
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

// // Example usage in a screen:
// class ExampleScreen extends StatelessWidget {
//   const ExampleScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Your main content here
//           const Center(
//             child: Text('Main Content'),
//           ),
//
//           // Resizable bottom sheet
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: ResizableBottomSheet(
//               minHeight: 100,
//               maxHeight: MediaQuery.of(context).size.height * 0.8,
//               initialHeight: 300,
//               backgroundColor: Colors.white,
//               borderRadius: 16,
//               child: const BottomSheetContent(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class BottomSheetContent extends StatelessWidget {
//   const BottomSheetContent({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Bottom Sheet Title',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 20,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text('Item $index'),
//                   onTap: () {
//                     // Handle item tap
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }