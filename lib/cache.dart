library cache;

import 'package:flutter/material.dart';

ValueNotifier<LoadClock?> currentClock = ValueNotifier<LoadClock?>(null);

// Transfer clock data between screens
class LoadClock {
  late int maxTime;
  late int elapsedTime;
  late bool isStopwatch;
  late DateTime _lastUpdate;

  LoadClock(this.maxTime, this.elapsedTime, this.isStopwatch) {
    _lastUpdate = DateTime.now();
  }

  bool isFinished() {
    return elapsedTime >= maxTime;
  }

  void updateClock() {
    final currentTime = DateTime.now();
    final elapsed = currentTime.difference(_lastUpdate).inSeconds;
    _lastUpdate = currentTime;
    elapsedTime += elapsed;
    if(elapsedTime >= maxTime) {
      elapsedTime = maxTime;
    }
  }
}