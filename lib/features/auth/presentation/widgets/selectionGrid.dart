import 'package:flutter/material.dart';
import 'package:academe_x/lib.dart';

class SelectionGrid extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? selectedOption;
  final bool? isYearVar;
  final bool? isTerm;
  final Function(String) onSelected;
  const SelectionGrid(
      {super.key,
      required this.title,
      required this.options,
      required this.selectedOption,
       this.isYearVar=false,
       this.isTerm=false,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          color: const Color(0xE014130D),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        16.ph(),
        SizedBox(
          height:(isTerm! || isYearVar!)? 70: 290,
          // color: Colors.amber,
          child: GridView.builder(
            // padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: options.length >= 4 ? 4 : 2,
              // childAspectRatio:68/60 ,
              crossAxisSpacing:16,
              mainAxisSpacing:  12,
            ),
            itemCount: options.length,
            itemBuilder: (context, index) {
              return _buildSelectableOption(
                  options[index],
                  isSelected: options[index] == selectedOption,
                  onTap: () => onSelected(options[index]),
                  isYearVar:isYearVar!,
                  isTerm:isTerm!
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildSelectableOption(String text,
      {required bool isSelected, required VoidCallback onTap, bool isYearVar=false ,bool isTerm=false}) {
    return GestureDetector(
      onTap: onTap,
      child:  Column(
        children: [
          (isYearVar || isTerm)?Container(
            height:60,
            decoration: ShapeDecoration(
              color: const Color(0xFFF9F9F9),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1,
                    color:isSelected ? Color(0xFF3253FF) : Color(0xFFF9F9F9)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child:Center(
              child: AppText(
                text: text,
                color: isSelected ?  Color(0xFF3253FF) : const Color(0xFF646C7C),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ): Container(
            width: 68,
            height: 68,
            decoration: ShapeDecoration(
              color: const Color(0xFFF9F9F9),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1,
                    color:isSelected ? Color(0xFF3253FF) : Color(0xFFF9F9F9)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child:( isYearVar || isTerm)? Center(
              child: AppText(
                text: text,
                color: isSelected ? Colors.blueAccent : const Color(0xFF646C7C),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ): 0.ph() ,
          ),

          (isYearVar || isTerm)? 0.ph():AppText(
            text: text,
            color: isSelected ? Colors.blueAccent :const Color(0xFF646C7C),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
