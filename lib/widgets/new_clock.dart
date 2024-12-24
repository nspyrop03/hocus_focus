import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:provider/provider.dart';
import '../cache.dart' as cache;

class TimerModelClockWidget extends StatefulWidget {
  @override
  State<TimerModelClockWidget> createState() => _TimerModelClockWidgetState();
}

class _TimerModelClockWidgetState extends State<TimerModelClockWidget> {
  @override
  Widget build(BuildContext context) {
    final timerModel = Provider.of<cache.TimerModel>(context);
    return Container(
        width: 220,
        height: 220,
        decoration: BoxDecoration(
          border: MyStyles.borderAll1,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(child: progressIndicatorWidget(timerModel)),
        ));
  }

  Widget progressIndicatorWidget(timerModel) {
    //return ValueListenableBuilder(
    //  valueListenable: timerModel.seconds,
    //  builder: (BuildContext context, int values, Widget? child) {
        double? per =
            (double.parse((timerModel.seconds / timerModel.maxTime).toString()));
        return CustomPaint(
          painter: CircularPaint(
            progressValue: per,
          ),
          child: Container(
            padding: const EdgeInsets.all(
              4.5,
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              border: Border.fromBorderSide(BorderSide(
                color: Colors.transparent,
                width: 1.5,
              )),
            ),
            child: CircleAvatar(
              radius: 110,
              backgroundColor: Colors.transparent,
              child: Text(
                timerModel.isStopwatch
                    ? "${timerModel.seconds ~/ 60}:${timerModel.seconds % 60 < 10 ? '0' : ''}${timerModel.seconds % 60}"
                    : "${(timerModel.maxTime - timerModel.seconds) ~/ 60}:${(timerModel.maxTime - timerModel.seconds) % 60 < 10 ? '0' : ''}${(timerModel.maxTime - timerModel.seconds) % 60}",
                style: MyStyles.magic40,
              ),
            ),
          ),
        );
      //},
    //);
  }

}

/*
class NewClockWidget extends StatefulWidget {
  final Key? key;

  const NewClockWidget({this.key});

  @override
  State<NewClockWidget> createState() => NewClockWidgetState();
}

class NewClockWidgetState extends State<NewClockWidget> {
  //final ValueNotifier<int> elapsedTime = ValueNotifier<int>(0); //initialize for the first time to 0
  //late int maxTime;
  //late bool isStopwatch;
  //late bool isStopped;

  @override
  void initState() {
    super.initState();
    //cache.currentClock.addListener(updateFromCache);
    //updateFromCache();
    //_timerVideo = ValueNotifier<int>(elapsedTime);
    //if(!isStopped) {
      tick();
    //}
    //print("[NewClockWidgetState] Timer: ${elapsedTime.value}");
  }
  / *
  @override
  void dispose() {
    cache.currentClock.removeListener(updateFromCache);
    super.dispose();
  }

  void updateFromCache() {
    setState(() {
      if (cache.currentClock.value == null) {
        maxTime = 0;
        elapsedTime.value = 0;
        isStopwatch = false;
        isStopped = true;
      } else {
        maxTime = cache.currentClock.value!.maxTime;
        elapsedTime.value = cache.currentClock.value!.elapsedTime;
        isStopwatch = cache.currentClock.value!.isStopwatch;
        isStopped = cache.currentClock.value!.isStopped;
      }
      print("Updated from cache: maxTime: $maxTime, elapsedTime: $elapsedTime, isStopwatch: $isStopwatch, isStopped: $isStopped");

    });
  }
  * /
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 220,
        height: 220,
        decoration: BoxDecoration(
          border: MyStyles.borderAll1,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(child: progressIndicatorWidget()),
        ));
  }

  Widget progressIndicatorWidget() {
    return ValueListenableBuilder(
      valueListenable: elapsedTime,
      builder: (BuildContext context, int values, Widget? child) {
        double? per =
            (double.parse((values / maxTime > 0 ? maxTime : 1).toString()));
        return CustomPaint(
          painter: CircularPaint(
            progressValue: per,
          ),
          child: Container(
            padding: const EdgeInsets.all(
              4.5,
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              border: Border.fromBorderSide(BorderSide(
                color: Colors.transparent,
                width: 1.5,
              )),
            ),
            child: CircleAvatar(
              radius: 110,
              backgroundColor: Colors.transparent,
              child: Text(
                isStopwatch
                    ? "${elapsedTime.value ~/ 60}:${elapsedTime.value % 60 < 10 ? '0' : ''}${elapsedTime.value % 60}"
                    : "${(maxTime - elapsedTime.value) ~/ 60}:${(maxTime - elapsedTime.value) % 60 < 10 ? '0' : ''}${(maxTime - elapsedTime.value) % 60}",
                style: MyStyles.magic40,
              ),
            ),
          ),
        );
      },
    );
  }

  void tick() {
    if (!isStopped) {
      Timer.periodic(const Duration(seconds: 1), (Timer t) {
        if (elapsedTime.value != maxTime) {
          cache.currentClock.value?.updateClock();
          updateFromCache();
          //elapsedTime.value = elapsedTime.value + 1;
        } else {
          t.cancel();
          if (cache.currentClock.value != null) {
            print("Cancelling Timer because it reached maxRecordTime!");
            cache.resetClockAndGiveReward(maxTime ~/ 2, maxTime ~/ 2);
          }
        }
      });
    }
  }
}
*/
double deg2rad(double deg) => deg * math.pi / 180;

class CircularPaint extends CustomPainter {
  /// ring/border thickness, default  it will be 8px [borderThickness].
  final double borderThickness;
  final double progressValue;

  CircularPaint({
    this.borderThickness = 15,
    required this.progressValue,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    final rect =
        Rect.fromCenter(center: center, width: size.width, height: size.height);

    Paint paint = Paint()
      ..color = MyColors.primary
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderThickness;

    //grey background
    canvas.drawArc(
      rect,
      deg2rad(0),
      deg2rad(360),
      false,
      paint,
    );

    Paint progressBarPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderThickness
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          MyColors.details,
          MyColors.secondary,
        ],
      ).createShader(rect);
    canvas.drawArc(
      rect,
      deg2rad(-90),
      deg2rad(360 * progressValue),
      false,
      progressBarPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
