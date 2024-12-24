import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/clock_widget.dart';
import 'package:hocus_focus/widgets/home_widgets.dart';
import 'package:hocus_focus/widgets/wizard_widgets.dart';
import '../widgets/welcome_widgets.dart' as welcome;
import '../cache.dart' as cache; 

class HomePageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              cache.currentClock.value?.updateClock();
              welcome.mainPageKey.currentState?.onItemTapped(5);
            },
            child: ClockProgressWidget(
              start: cache.currentClock.value?.elapsedTime ?? 0,
              maxRecordTime: cache.currentClock.value?.maxTime ?? 0,
              isStopwatch: cache.currentClock.value?.isStopwatch ?? false,
            )),
        SizedBox(
          height: 50,
        ),
        WizardHomeWidget(),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
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
              SizedBox(
                height: 20,
              ),
              SpotifyDropdownWidget(),
              SizedBox(
                height: 50,
              ),
              /*ClockProgressWidget(
                seconds: 120,
                isStopwatch: true,
              ),*/
              SizedBox(
                height: 50,
              ),
              WizardIconWidget(),
            ],
          )),
        ],
      ),
      //bottomNavigationBar: BottomBarWidget(),
    );
  }
}
