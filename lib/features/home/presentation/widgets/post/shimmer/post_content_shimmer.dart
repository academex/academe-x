import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostContentShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.white,
          ),
          8.ph(),
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.white,
          ),
          8.ph(),
          Container(
            width: 150,
            height: 16,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}