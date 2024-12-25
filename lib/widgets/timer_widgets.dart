import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:provider/provider.dart';
import '../cache.dart' as cache;

class TimerButtonWidget extends StatelessWidget {
  final bool isTimer;

  const TimerButtonWidget({super.key, required this.isTimer});

  void _addTimer(String timer, timerModel) async {
    int min = 0;
    int sec = 10; // default
    try {
      List<String> time = timer.split(":");
      min = int.parse(time[0]);
      sec = int.parse(time[1]);
    } catch (err) {
      if (timer.isEmpty) {
        print("Empty input");
        return;
      }
    }
    int maxTime = min * 60 + sec;
    timerModel.setNewTimer(maxTime, !isTimer);
  }

  @override
  Widget build(BuildContext context) {
    final timerModel = Provider.of<cache.TimerModel>(context);
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
        onPressed: () {
          timerModel.stopTimer();
          showDialog(
              context: context,
              builder: (context) {
                return AddTimerDialog(onAddTimer: _addTimer, isTimer: isTimer);
              });
        },
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
    final timerModel = Provider.of<cache.TimerModel>(context);
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
                if(timerModel.seconds >= timerModel.maxTime) {
                  return;
                }
                setState(() {
                  //if (cache.currentClock.value == null) {
                  //  return;
                  //}
                  isPaused = !isPaused;
                  if(isPaused) {
                    timerModel.stopTimer();
                  } else {
                    timerModel.startTimer();
                  }
                  //cache.currentClock.value?.isStopped = isPaused;
                  //_toggleStartStop();
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
    final timerModel = Provider.of<cache.TimerModel>(context);
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
                if(timerModel.seconds >= timerModel.maxTime) {
                  return;
                }
                timerModel.resetTimer();
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

class AddTimerDialog extends StatefulWidget {
  final Function(String, cache.TimerModel) onAddTimer;
  final bool isTimer;

  const AddTimerDialog(
      {super.key, required this.onAddTimer, required this.isTimer});

  @override
  _AddTimerDialogState createState() => _AddTimerDialogState();
}

class _AddTimerDialogState extends State<AddTimerDialog> {
  final TextEditingController _timerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final timerModel = Provider.of<cache.TimerModel>(context);
    return AlertDialog(
      title: Text(
        widget.isTimer ? 'Add New Timer' : 'Add New Stopwatch',
        style: MyStyles.magic24,
      ),
      backgroundColor: MyColors.primary,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _timerController,
            decoration: InputDecoration(
                labelText: 'MM:SS', labelStyle: MyStyles.magic14),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: MyStyles.magic14.copyWith(color: MyColors.details),
          ),
        ),
        TextButton(
          onPressed: () {
            if (_timerController.text.isNotEmpty) {
              widget.onAddTimer(_timerController.text, timerModel);
              Navigator.of(context).pop();
            }
          },
          child: Text(
            'Add',
            style: MyStyles.magic14.copyWith(color: MyColors.details),
          ),
        ),
      ],
    );
  }
}
