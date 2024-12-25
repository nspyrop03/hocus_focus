library cache;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hocus_focus/sqflite_helper.dart';

class TimerModel extends ChangeNotifier {
  int _seconds = 0;
  int _maxTime = 60;
  bool _isStopwatch = true;
  Timer? _timer;

  int get seconds => _seconds;
  int get maxTime => _maxTime;
  bool get isStopwatch => _isStopwatch;

  bool isStopped() {
    return _timer == null || !_timer!.isActive;
  }

  void startTimer() {
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;
      notifyListeners();

      if(_seconds >= _maxTime) {
        giveReward(_seconds ~/ 2, _seconds ~/ 2);
        stopTimer();
        print("[TimeModel] Timer stopped");
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    stopTimer();
    _seconds = 0;
    notifyListeners();
  }

  void setNewTimer(int maxSeconds, bool isStopwatch) {
    _maxTime = maxSeconds;
    _isStopwatch = isStopwatch;
    resetTimer();
  }
}

void addExpAndCoins(int exp, int coins) async {
  // Add experience and coins to the user
  var dbh = DatabaseHelper();
  await dbh.addProfileExp(exp);
  await dbh.addProfileCoins(coins);
}


void giveReward(int exp, int coins) {
  addExpAndCoins(exp, coins); // give the reward
  print("[Cache] Reward given ($exp exp, $coins coins)");
}

const baseExp = 100;
// function to get exp needed for next level based on current level.
// each level requires 20 more exp than the previous level.
int getExpForNextLevel(int level) {
  return baseExp + (level - 1) * 20;
}

// function to get the level based on the exp based on the above function.
int getLevel(int exp) {
  int level = 1;
  while (exp >= getExpForNextLevel(level)) {
    exp -= getExpForNextLevel(level);
    level++;
  }
  return level;
}

// function to get percentage of level completion based on exp.
double getLevelPercentage(int exp) {
  int level = getLevel(exp);
  if (level > 1) {
    int expForLevel = getExpForNextLevel(level);
    int expForPrevLevel = getExpForNextLevel(level - 1);
    print(
        "Level: $level, exp: $exp, expForLevel: $expForLevel, expForPrevLevel: $expForPrevLevel");
    final double percentage =
        (exp - expForPrevLevel) / (expForLevel - expForPrevLevel);
    print("Percentage: $percentage");
    return percentage;
  } else {
    return exp / getExpForNextLevel(level);
  }
}
