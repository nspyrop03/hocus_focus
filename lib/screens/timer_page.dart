import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/clock_widget.dart';
import 'package:hocus_focus/widgets/timer_widgets.dart';

class TimerPageLayout extends StatelessWidget {
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
          seconds: 120,
          isStopwatch: true,
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

class TimerPage extends StatelessWidget {
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
                seconds: 120,
                isStopwatch: true,
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
          )),
        ],
      ),
      //bottomNavigationBar: BottomBarWidget(),
    );
  }
}
