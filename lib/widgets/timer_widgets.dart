import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';

class TimerButtonWidget extends StatelessWidget {
  final bool isTimer;

  const TimerButtonWidget({super.key, required this.isTimer});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 158,
      height: 56,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: MyColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(isTimer ? Icons.timer : Icons.access_alarm,
                color: MyColors.details),
            SizedBox(width: 10),
            Text(isTimer ? "Timer" : "Stopwatch", style: MyStyles.magic14),
          ],
        ),
      ),
    );
  }
}

class StartStopButtonWidget extends StatefulWidget {
  final bool isPaused;

  const StartStopButtonWidget({super.key, required this.isPaused});

  @override
  State<StartStopButtonWidget> createState() => _StartStopButtonWidgetState();
}

class _StartStopButtonWidgetState extends State<StartStopButtonWidget> {
  late bool isPaused;

  @override
  void initState() {
    super.initState();
    isPaused = widget.isPaused;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [MyStyles.boxShadowBasic],
          ),
          child: IconButton(
              onPressed: () {
                setState(() {
                  isPaused = !isPaused;
                });
              },
              style: IconButton.styleFrom(
                backgroundColor: MyColors.details,
                //shape: CircleBorder(),
              ),
              icon: Icon(isPaused ? Icons.play_arrow : Icons.pause,
                  color: MyColors.primary)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            isPaused ? "Start" : "Pause",
            style: MyStyles.magic14,
          ),
        )
      ],
    );
  }
}

class QuitButtonWidget extends StatefulWidget {
  const QuitButtonWidget({super.key});

  @override
  State<QuitButtonWidget> createState() => _QuitButtonWidgetState();
}

class _QuitButtonWidgetState extends State<QuitButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [MyStyles.boxShadowBasic],
          ),
          child: IconButton(
              onPressed: () {
                print("Pressed QuitButton");
              },
              style: IconButton.styleFrom(
                backgroundColor: MyColors.details,
                //shape: CircleBorder(),
              ),
              icon: Icon(Icons.stop, color: MyColors.primary)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            "Quit",
            style: MyStyles.magic14,
          ),
        )
      ],
    );
  }
}