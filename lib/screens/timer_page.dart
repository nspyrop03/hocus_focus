import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/clock_widget.dart';
import 'package:hocus_focus/widgets/timer_widgets.dart';
import '../cache.dart' as cache;

class TimerPageLayout extends StatefulWidget {
  @override
  State<TimerPageLayout> createState() => _TimerPageLayoutState();
}

class _TimerPageLayoutState extends State<TimerPageLayout> {

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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
        ClockProgressWidget(
          seconds: cache.currentClock.value?.elapsedTime ?? 0,
          maxRecordTime: cache.currentClock.value?.maxTime ?? 0,
          isStopwatch: cache.currentClock.value?.isStopwatch ?? false,
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StartStopButtonWidget(isPaused: true),
              QuitButtonWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
