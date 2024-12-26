import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';

class StatsInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseHelper().getProfileTotals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
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
                      Text(
                          "Total tasks completed: ${snapshot.data?['total_tasks']}",
                          style: MyStyles.magic14),
                      Text(
                          "Total events completed: ${snapshot.data?['total_events']}",
                          style: MyStyles.magic14),
                      Text(
                          "Total coins earned: ${snapshot.data?['total_coins']}",
                          style: MyStyles.magic14),
                      Text(
                          "Total hours spent: ${((snapshot.data?['total_hours'] ?? 0)/ 3600).toStringAsFixed(2)}",
                          style: MyStyles.magic14),
                    ],
                  ),
                ));
          } else {
            return Container(
                width: 385,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: MyStyles.roundBox16,
                  boxShadow: [MyStyles.boxShadowBasic],
                  color: MyColors.primary,
                ),
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }
}

class StatsBarGraphWidget extends StatelessWidget {
  //final values = <int>[1, 3, 2, 1, 3, 10, 2];
  final days = <String>["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  late final int maxValue;
  final double maxHeight = 280;

  StatsBarGraphWidget() {
    //maxValue = values.reduce(max);
  }

  // function that returns a Map<String, String> where the keys are the values of "days" list and the values are the dates of the current week
  Map<String, String> getDaysOfWeek() {
    var daysOfWeek = <String, String>{};
    var now = DateTime.now();
    var currentWeekday = now.weekday;
    var currentDay = now.day;
    for (var i = 0; i < 7; i++) {
      var day = currentDay - currentWeekday + i;
      var date = DateTime(now.year, now.month, day);
      daysOfWeek[days[i]] = date.toString().substring(0, 10);
    }
    return daysOfWeek;
  }

  Future<List<int>> getValues() async {
    var dbh = DatabaseHelper();
    var values = <int>[];
    var daysOfWeek = getDaysOfWeek();
    for (var day in daysOfWeek.values) {
      var value = await dbh.getDateCounter(day);
      values.add(value);
    }
    maxValue = max(values.reduce(max), 1);
    return values;
  }
  
  @override
  Widget build(BuildContext context) {
    print(getDaysOfWeek());
    return FutureBuilder(
      future: getValues(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
                  Text("Tasks/Events completed per day", style: MyStyles.magic14),
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
                          for (var v in snapshot.data as List<int>) 
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
        } else {
          return Container(
              width: 385,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: MyStyles.roundBox16,
                boxShadow: [MyStyles.boxShadowBasic],
                color: MyColors.primary,
              ),
              child: Center(child: CircularProgressIndicator()));
        }
      }
    );
  }
}
