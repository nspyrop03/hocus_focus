import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/home_widgets.dart';
import 'package:hocus_focus/widgets/new_clock.dart';
import 'package:hocus_focus/widgets/wizard_widgets.dart';
import 'package:provider/provider.dart';
import '../widgets/welcome_widgets.dart' as welcome;
import '../cache.dart' as cache; 

class HomePageLayout extends StatefulWidget {
  @override
  State<HomePageLayout> createState() => _HomePageLayoutState();
}

class _HomePageLayoutState extends State<HomePageLayout> {
  //Key _progressIndicatorKey = UniqueKey();
   /*final GlobalKey<NewClockWidgetState> newClockWidgetKey = GlobalKey<NewClockWidgetState>();

  @override
  void initState() {
    super.initState();
    cache.currentClock.addListener(_onClockChanged);
  }

  @override
  void dispose() {
    cache.currentClock.removeListener(_onClockChanged);
    super.dispose();
  }

  void _onClockChanged() {
    setState(() {
      // Update the key to force the widget to rebuild
      newClockWidgetKey.currentState?.updateFromCache();
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final timerModel = Provider.of<cache.TimerModel>(context);
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
              //cache.currentClock.value?.updateClock();
              welcome.mainPageKey.currentState?.onItemTapped(5);
            },
            //child: NewClockWidget(key: newClockWidgetKey),),
            child: TimerModelClockWidget()),
            /*
            child: ClockProgressWidget(
              isStopped: cache.currentClock.value?.isStopped ?? false,
              start: cache.currentClock.value?.elapsedTime ?? 0,
              maxRecordTime: cache.currentClock.value?.maxTime ?? 0,
              isStopwatch: cache.currentClock.value?.isStopwatch ?? false,
            )),*/
        SizedBox(
          height: 50,
        ),
        WizardHomeWidget(),
      ],
    );
  }
}
