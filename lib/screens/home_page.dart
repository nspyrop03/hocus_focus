import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/home_widgets.dart';
import 'package:hocus_focus/widgets/new_clock.dart';
import 'package:hocus_focus/widgets/wizard_widgets.dart';
import 'main_page.dart' as main_page;
import '../global.dart' as global;

class HomePageLayout extends StatefulWidget {
  @override
  State<HomePageLayout> createState() => _HomePageLayoutState();
}

class _HomePageLayoutState extends State<HomePageLayout> {
  @override
  Widget build(BuildContext context) {
    //final timerModel = Provider.of<cache.TimerModel>(context);
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        SpotifyDropdownWidget(),
        SizedBox(
          height: 50,
        ),
        GestureDetector(
            onTap: () {
              main_page.mainPageKey.currentState?.onItemTapped(global.timerIndex);
            },
            child: TimerModelClockWidget()),
        SizedBox(
          height: 50,
        ),
        GestureDetector(
          onTap: () {
            main_page.mainPageKey.currentState?.onItemTapped(global.statisticsIndex);
          },
          child: WizardHomeWidget(),
        )
      ],
    );
  }
}
