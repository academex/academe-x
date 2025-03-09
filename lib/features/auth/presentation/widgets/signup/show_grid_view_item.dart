import 'package:flutter/material.dart';

import '../../../../../core/widgets/app_text.dart';

class ShowGridViewItem<T> extends StatelessWidget {
  final List<T> data;
  final Function(int,T) onTap;
  final int? selectedIndex;
  final int crossAxisCount;
  final String Function(T) displayTextBuilder;

   ShowGridViewItem({
    required this.data,
    required this.onTap,
    required this.selectedIndex,
    required this.crossAxisCount,
     required this.displayTextBuilder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: MediaQuery.of(context).orientation == Orientation.portrait
            ? 2.5  // Adjust for portrait
            : 3.0, // Adjust for landscape
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return  InkWell(
          onTap:() => onTap(index,data[index]),
          child: Container(
            // padding: EdgeInsets.all(8),
            decoration: ShapeDecoration(
              color:const Color(0xFFF9F9F9),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.80, color:selectedIndex== index?const Color(0xFF0077FF): const Color(0x38E1E1E1)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            // height: 56,
            // width: 80,
            child:  Center(
              child: AppText(text:displayTextBuilder(data[index]) , fontSize: 16),
            ),
          ),
        );
      }
        // Your existing grid item implementation
    );
  }
}