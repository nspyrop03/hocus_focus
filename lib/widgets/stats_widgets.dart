import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';

class StatsInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 385,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: MyStyles.roundBox16,
          boxShadow: [MyStyles.boxShadowBasic],
          color: MyColors.primary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total tasks completed: 42", style: MyStyles.magic14),
              Text("Total events completed: 42", style: MyStyles.magic14),
              Text("Total coins earned: 4200", style: MyStyles.magic14),
              Text("Total hours spent: 42", style: MyStyles.magic14),
            ],
          ),
        ));
  }
}

class StatsBarGraphWidget extends StatelessWidget {
  final values = <int>[1, 3, 2, 1, 3, 10, 2];
  final days = <String>["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  late final int maxValue;
  final double maxHeight = 280;

  StatsBarGraphWidget() {
    maxValue = values.reduce(max);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        width: 385,
        height: 350,
        decoration: BoxDecoration(
          borderRadius: MyStyles.roundBox16,
          boxShadow: [MyStyles.boxShadowBasic],
          color: MyColors.primary,
        ),
        child: Column(
          children: [
            Text("Tasks completed per day", style: MyStyles.magic14),
            Container(
                // bar graph
                width: 335,
                height: 300,
                decoration: BoxDecoration(
                  border: MyStyles.borderAll1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var v in values)
                      Container(
                        width: 20,
                        height: (v / maxValue) * maxHeight,
                        decoration: BoxDecoration(
                          color: MyColors.details,
                        ),
                        child: Center(
                            child: Text("$v",
                                style: MyStyles.magic14
                                    .copyWith(color: MyColors.primary))),
                      )
                  ],
                )),
            SizedBox(
                // x-labels
                width: 335,
                height: 20,
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  
                  children: [
                    for (var d in days) Text(d, style: MyStyles.magic10)
                  ],
                )),
          ],
        ));
  }
}
