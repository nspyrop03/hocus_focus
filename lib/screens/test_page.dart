import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/clock_widget.dart';
import 'package:hocus_focus/widgets/home_widgets.dart';
import 'package:hocus_focus/widgets/stats_widgets.dart';
import 'package:hocus_focus/widgets/task_list_widgets.dart';
import 'package:hocus_focus/widgets/timer_widgets.dart';

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
              StatsInfoWidget(),
              StatsBarGraphWidget(),
            ],
          )),
        ],
      ),
      //bottomNavigationBar: BottomBarWidget(),
    );
  }
}
