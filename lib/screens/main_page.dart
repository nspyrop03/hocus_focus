import 'package:flutter/material.dart';
import 'package:hocus_focus/screens/calendar_page.dart';
import 'package:hocus_focus/screens/home_page.dart';
import 'package:hocus_focus/screens/set_tasks_page.dart';
import 'package:hocus_focus/screens/statistics_page.dart';
import 'package:hocus_focus/screens/task_list_page.dart';
import 'package:hocus_focus/screens/timer_page.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';

class MainPage extends StatefulWidget {

  MainPage({ super.key });

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  var selectedIndex = 2;

  static List<Widget> _pages = <Widget>[
    HomePageLayout(), // 0: should be shop page
    HomePageLayout(), // 1: should be book page
    HomePageLayout(), // 2: home
    CalendarPageLayout(), // 3: should be calendar page
    TaskListPageLayout(), // 4: tasks list
    
    // Extra pages!
    TimerPageLayout(), // 5: timer page
    SetTasksPageLayout(), // 6: set tasks page
    StatisticsPageLayout(), // 7: statistics page
  ];

  void onItemTapped(int index) {
    print("Tapping with index $index");
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page = _pages[selectedIndex];

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TopBarWidget(),
            Expanded(child: page),
          ],
        ),
        bottomNavigationBar: BottomBarWidget(onPressed: onItemTapped,),
      );
    });
  }
}
