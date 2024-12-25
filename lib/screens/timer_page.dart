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
  @override
  Widget build(BuildContext context) {
    final timerModel = Provider.of<cache.TimerModel>(context);
    return Column(
      children: [
        Expanded(
            child: ListView(
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
        )),
      ],
    );
  }
}
