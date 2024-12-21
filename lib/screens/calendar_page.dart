import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/calendar_widgets.dart';


class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarWidget(),
          SizedBox(height: 10),
          // Flexible ensures proper space allocation for the content
          Flexible(
            child: Stack(
              children: [
                // ListView includes TableBasicsExample and EventdisplayWidgets
                Positioned.fill(
                  child: ListView(
                    padding: EdgeInsets.all(10.0), // Add padding around the list
                    children: [
                      TableBasicsExample(),
                      EventdisplayWidget(),
                      SizedBox(height: 15),
                      EventdisplayWidget(),
                      SizedBox(height: 15),
                      EventdisplayWidget(),
                      // Add more EventdisplayWidgets as needed
                    ],
                  ),
                ),
                // HoverplusbuttonWidget positioned at the top-right corner
                Positioned(
                  top: 300, // Adjust position as needed
                  right: 10, // Adjust position as needed
                  child: HoverplusbuttonWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




/*
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
*/