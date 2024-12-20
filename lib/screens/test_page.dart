import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TopBarWidget(),
          Expanded(child: Text("Test Page")),
        ],
      ),
    );
  }
}
