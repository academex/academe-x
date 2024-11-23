import 'package:flutter/material.dart';

import 'fb_reaction_box.dart';

class FbReactionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Facebook Reaction',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Directionality(textDirection: TextDirection.ltr, child: FbReactionBox()),
    );
  }
}