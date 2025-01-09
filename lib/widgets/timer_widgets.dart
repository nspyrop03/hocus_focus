import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
//import 'package:hocus_focus/tests/test.dart';
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
    print("set new timer: $min:$sec");
    int maxTime = min * 60 + sec;
    timerModel.setNewTimer(maxTime, !isTimer);
  }

  //function to adjust time on 12hour format based on PM/AM
  void _adjustHour(int hourIn, int minIn, String periodName, cache.TimerModel timerModel) {
    // timer string is of the form "TimeOfDay(MM:SS)"
    // newTimer string of the form "MM:SS" from the timer
    //String newTimer = timer.substring(10, timer.length - 1);

    // Split the input time by colon (e.g., "3:10 PM" -> ["3", "10 PM"])
    //List<String> time = newTimer.split(":");

    // The last part of the time string is "AM" or "PM"
    String amPm = periodName.toUpperCase();
        //time[1].trim().substring(time[1].trim().length - 2); // Get AM/PM

    // Extract the hour and minute
    //int hour = int.parse(time[0].trim());
    //int min = int.parse(
    //   time[1].trim().substring(0, time[1].trim().length - 2)); // Remove AM/PM
    //int min = int.parse(time[1].trim());
    int hour = hourIn;
    int min = minIn;

    // Adjust the hour based on AM/PM
    if (amPm == "PM" && hour != 12) {
      hour += 12; // Convert PM hour to 24-hour format, except for 12 PM
    } else if (amPm == "AM" && hour == 12) {
      hour = 0; // 12 AM is midnight, so set hour to 0
    }

    // Debug print to check the hour and minute
    print("Hour: $hour, Minute: $min");
    String formattedTime = "$hour:$min";
    _addTimer(formattedTime, timerModel);
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
        onPressed: () async {
          timerModel.stopTimer();
          /*
          showDialog(
              context: context,
              builder: (context) {
                return AddTimerDialog(onAddTimer: _addTimer, isTimer: isTimer);
              });*/
          final TimeOfDay? selectedTime = await showTimePicker(
            context: context,
            hourLabelText: "Min",
            minuteLabelText: "Sec",
            initialTime: TimeOfDay(hour: 00, minute: 10),
            //helpText: '',
            initialEntryMode: TimePickerEntryMode.inputOnly, // Input only mode
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  timePickerTheme: TimePickerThemeData(
                    backgroundColor: MyColors.background,
                    hourMinuteColor: MyColors.primary,
                    hourMinuteTextColor: MyColors.details,
                    dialHandColor: MyColors.details,
                    dialBackgroundColor: MyColors.details,
                    entryModeIconColor: MyColors.details,
                    hourMinuteTextStyle: MyStyles.magic40,
                    dayPeriodTextStyle: MyStyles.magic14,
                    dialTextStyle: MyStyles.magic14,
                    helpTextStyle: MyStyles.magic14,
                    
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          MyColors.details, // OK and Cancel buttons color
                      textStyle: MyStyles.magic14,
                    ),
                  ),
                  colorScheme: ColorScheme.light(
                    primary: MyColors.details,
                    onPrimary: MyColors.secondary,
                    onSurface: MyColors.details,
                  ),
                ),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                      alwaysUse24HourFormat: true), // Enforces 24-hour format
                  child: Focus(
                    focusNode: FocusNode(), // This ensures the keyboard shows
                    child: child!,
                  ),
                ),
              );
            },
          );

          if (selectedTime != null) {
            //print("Selected time: ${selectedTime.toString()} ${selectedTime.period.name}");
            print("Hour: ${selectedTime.hour}, Minute: ${selectedTime.minute}");
            _adjustHour(selectedTime.hour, selectedTime.minute, selectedTime.period.name, timerModel);
          }
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
                if (timerModel.seconds >= timerModel.maxTime) {
                  return;
                }
                setState(() {
                  //if (cache.currentClock.value == null) {
                  //  return;
                  //}
                  isPaused = !isPaused;
                  if (isPaused) {
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
                if (timerModel.seconds >= timerModel.maxTime) {
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
