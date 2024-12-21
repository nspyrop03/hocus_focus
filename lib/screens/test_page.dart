import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/clock_widget.dart';
import 'package:hocus_focus/widgets/home_widgets.dart';
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
              //LevelBarWidget(level: 42, exp: 300),
              //CoinsWidget(coins: 100000),
              //NavBarButton(iconPath: "assets/images/nav_icons/ShopIcon.svg", width: 24, height: 22),
              //SpotifyDropdownWidget(),
              //SizedBox(height: 20,),
              //ClockProgressWidget(seconds: 120, isStopwatch: true,),
              //SizedBox(height: 10,),
              //TimerButtonWidget(isTimer: true),
              //StartStopButtonWidget(isPaused: true),
              //QuitButtonWidget(),
              TaskListItemWidget(description: "Task List Entry", isDone: false)
            ],
          )),
        ],
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
