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
          Expanded(
              child: Column(
            children: [
              Text("Test Page"),
              //LevelBarWidget(level: 42, exp: 300),
              //CoinsWidget(coins: 100000),
            ],
          )),
        ],
      ),
    );
  }
}
