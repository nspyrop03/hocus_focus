library cache;

import 'package:flutter/material.dart';

ValueNotifier<LoadClock?> currentClock = ValueNotifier<LoadClock?>(null);

// Transfer clock data between screens
class LoadClock {
  late int maxTime;
  late int elapsedTime;
  late bool isStopwatch;
  late DateTime timeCreated;
  

  LoadClock(this.maxTime, this.elapsedTime, this.isStopwatch) {
    timeCreated = DateTime.now();
  }

  bool isFinished() {
    return elapsedTime >= maxTime;
  }

  void updateClock() {
    final currentTime = DateTime.now();
    final elapsed = currentTime.difference(timeCreated).inSeconds;
    elapsedTime += elapsed;
    if(elapsedTime >= maxTime) {
      elapsedTime = maxTime;
    }
  }
}