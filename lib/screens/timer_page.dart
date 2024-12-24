import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/new_clock.dart';
import 'package:hocus_focus/widgets/timer_widgets.dart';
import 'package:provider/provider.dart';
import '../cache.dart' as cache;

class TimerPageLayout extends StatefulWidget {
  @override
  State<TimerPageLayout> createState() => _TimerPageLayoutState();
}

class _TimerPageLayoutState extends State<TimerPageLayout> {
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
      //cache.currentClock.value?.updateClock();
      //_progressIndicatorKey = UniqueKey();
      newClockWidgetKey.currentState?.updateFromCache();
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final timerModel = Provider.of<cache.TimerModel>(context);
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerButtonWidget(isTimer: true),
            SizedBox(
              width: 20,
            ),
            TimerButtonWidget(isTimer: false),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        /*
        ClockProgressWidget(
          key: _progressIndicatorKey,
          isStopped: cache.currentClock.value?.isStopped ?? false,
          start: cache.currentClock.value?.elapsedTime ?? 0,
          maxRecordTime: cache.currentClock.value?.maxTime ?? 0,
          isStopwatch: cache.currentClock.value?.isStopwatch ?? false,
        ),*/
        //NewClockWidget(key: newClockWidgetKey),
        TimerModelClockWidget(),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StartStopButtonWidget(isPaused: timerModel.isStopped()),
              QuitButtonWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
