library cache;

import 'package:flutter/material.dart';
import 'package:hocus_focus/sqflite_helper.dart';

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
    if (isFinished()) {
      resetClockAndGiveReward(maxTime ~/ 2, maxTime ~/ 2);
    }
  }
}

void addExpAndCoins(int exp, int coins) async {
  // Add experience and coins to the user
  var dbh = DatabaseHelper();
  await dbh.addProfileExp(exp);
  await dbh.addProfileCoins(coins);
}

void resetClockAndGiveReward(int exp, int coins) {
  currentClock = ValueNotifier<LoadClock?>(null); // reset the clock
  addExpAndCoins(exp, coins); // give the reward
  print("Clock reset and reward given ($exp exp, $coins coins)");
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
