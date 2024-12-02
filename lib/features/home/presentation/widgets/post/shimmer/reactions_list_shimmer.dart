import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReactionsListShimmer extends StatelessWidget {
  const ReactionsListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10, // Show 10 shimmer items while loading
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            direction: ShimmerDirection.rtl,
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListTile(
              leading: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
              ),
              title: Container(
                width: 100,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              trailing: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}