import 'package:flutter/material.dart';

import 'file_type_shimmer.dart';
import 'files_shimmer.dart';


class LibraryWidgetShimmer extends StatelessWidget {

  const LibraryWidgetShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FileTypeShimmer(),
        FileShimmer(),
      ],
    );
  }
}