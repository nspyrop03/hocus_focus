import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/stats_widgets.dart';

class StatisticsPageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        StatsInfoWidget(),
        SizedBox(
          height: 20,
        ),
        StatsBarGraphWidget(),
      ],
    );
  }
}
