import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';

class ClockProgressWidget extends StatelessWidget {
  final int start;
  final int maxRecordTime;
  final bool isStopwatch;
  const ClockProgressWidget({super.key, required this.start, required this.maxRecordTime, required this.isStopwatch});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        border: MyStyles.borderAll1,
      ),
      child: GradientCircularProgressIndicator(start: start, maxRecordTime: maxRecordTime, isStopwatch: isStopwatch,)
      
    );
  }
}

class GradientCircularProgressIndicator extends StatefulWidget {
  final int maxRecordTime;
  final bool isStopwatch;
  final int start;

  const GradientCircularProgressIndicator({super.key, required this.start, required this.maxRecordTime, required this.isStopwatch});

  @override
  State<GradientCircularProgressIndicator> createState() =>
      _GradientCircularProgressIndicatorState();
}

class _GradientCircularProgressIndicatorState
    extends State<GradientCircularProgressIndicator> {
  late final ValueNotifier<int> _timerVideo;

  @override
  void initState() {
    _timerVideo = ValueNotifier<int>(widget.start);
    tick();
    print("Timer: ${_timerVideo.value}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(child: progressIndicatorWidget()),
    );
  }

  Widget progressIndicatorWidget() {
    return ValueListenableBuilder(
      valueListenable: _timerVideo,
      builder: (BuildContext context, int values, Widget? child) {
        double? per = (double.parse((values / widget.maxRecordTime).toString()));
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
                widget.isStopwatch 
                ? "${_timerVideo.value~/60}:${_timerVideo.value%60<10 ? '0' : ''}${_timerVideo.value%60}"
                : "${(widget.maxRecordTime - _timerVideo.value)~/60}:${(widget.maxRecordTime - _timerVideo.value)%60<10 ? '0' : ''}${(widget.maxRecordTime - _timerVideo.value)%60}",
                style: MyStyles.magic40,
              ),
            ),
          ),
        );
      },
    );
  }

  void tick() {
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (_timerVideo.value != widget.maxRecordTime) {
        _timerVideo.value = _timerVideo.value + 1;
      } else {
        t.cancel();
      }
    });
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
