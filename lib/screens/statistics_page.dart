import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/stats_widgets.dart';

class StatisticsPage extends StatelessWidget {
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
              SizedBox(height: 20),
              StatsInfoWidget(),
              SizedBox(height: 20,),
              StatsBarGraphWidget(),
            ],
          )),
        ],
      ),
      //bottomNavigationBar: BottomBarWidget(),
    );
  }
}
