import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/home_widgets.dart';
import 'package:hocus_focus/widgets/calendar_widgets.dart';


class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarWidget(),
          SizedBox(height: 10),
          // Use Flexible to ensure proper space allocation
          Flexible(
            child: Stack(
              children: [
                // The TableBasicsExample is placed at the bottom of the Stack
                Positioned.fill(
                  child: Column(
                    children: [
                      TableBasicsExample(),
                      //SizedBox(height: 15),
                      EventdisplayWidget(),
                      SizedBox(height: 15),
                      EventdisplayWidget(),
                      SizedBox(height: 15),
                      EventdisplayWidget(),
                    ],
                  ),
                ),
                // The HoverplusbuttonWidget is positioned at the top-right corner of the Stack
                Positioned(
                  top: 300, // Adjust top position
                  right: 10, // Adjust right position
                  child: HoverplusbuttonWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
      //bottomNavigationBar: BottomBarWidget(),
    );
  }
}
