import 'package:flutter/material.dart';
import 'package:hocus_focus/screens/home_page.dart';
import 'package:hocus_focus/screens/task_list_page.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  var selectedIndex = 2;

  static List<Widget> _pages = <Widget>[
    HomePageLayout(), // 0: should be shop page
    HomePageLayout(), // 1: should be book page
    HomePageLayout(),
    HomePageLayout(), // 3: should be calendar page
    TaskListPageLayout()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page = _pages[selectedIndex];

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TopBarWidget(),
            Expanded(child: page),
          ],
        ),
        bottomNavigationBar: BottomBarWidget(onPressed: _onItemTapped,),
      );
    });
  }
}
