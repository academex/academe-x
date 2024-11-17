

import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';

class SelectionDropDown extends StatelessWidget {
  final String value;
  final List<String> items;
  final Function(String?) onChanged;
  final String label;

  const SelectionDropDown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        8.ph(),
        Container(
          width: double.infinity,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(

            color: Color(0xffF9F9F9),
            // border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(

            child: DropdownButton<String>(
              onTap: () {

              },
              itemHeight: 100,

              // hint: AppText(text: 'text', fontSize: 16),

              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: (value) {

              },
            ),
          ),
        ),
      ],
    );
  }
}