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
          //border: MyStyles.borderAll1, //debug
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(child: progressIndicatorWidget(timerModel)),
        ));
  }

  Widget progressIndicatorWidget(timerModel) {
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
  }
}

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
