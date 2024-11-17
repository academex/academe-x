import 'package:flutter/material.dart';
import 'package:academe_x/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowGridViewItem extends StatelessWidget {

  final List<String> data;
  final Function(int)onTap;
   int? selectedIndex;
   // int? selectedSemesterIndex;

   ShowGridViewItem({super.key,required this.data,required this.onTap, this.selectedIndex});


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount:data.length,
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: data.length ==2 ?2:4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: data.length ==2 ?4:2,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap:() => onTap(index),
          child: Container(
            decoration: ShapeDecoration(
              color:const Color(0xFFF9F9F9),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.80, color:selectedIndex== index?const Color(0xFF0077FF): Color(0x38E1E1E1)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            height: 56,
            width: 80,
            child: Center(
              child: AppText(text: data[index], fontSize: 16),
            ),
          ),
        );
      },
      // gridDelegate: ,
    );
  }
}
