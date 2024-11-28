import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostHeaderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
          ),
          10.pw(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 14,
                  color: Colors.white,
                ),
                4.ph(),
                Container(
                  width: 80,
                  height: 12,
                  color: Colors.white,
                )
              ],
            ),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.more_horiz),
          )
        ],
      ),
    );
  }
}