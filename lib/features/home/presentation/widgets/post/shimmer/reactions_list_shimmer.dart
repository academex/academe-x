import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReactionShimmer extends StatelessWidget {
  const ReactionShimmer({Key? key}) : super(key: key);

  Widget _buildShimmerHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const Spacer(),
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerReactionType() {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (index) =>
            Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
        ),
      ),
    );
  }

  Widget _buildShimmerReactionItem() {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 80,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
      trailing: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildShimmerHeader(),
            20.ph(),
            _buildShimmerReactionType(),
            20.ph(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10, // Show a fixed number of shimmer items
                itemBuilder: (context, index) => _buildShimmerReactionItem(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}