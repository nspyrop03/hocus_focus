library cache;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hocus_focus/main.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

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

      if (_seconds >= _maxTime) {
        updateTotalHours(_seconds);
        giveReward(_seconds ~/ 2, _seconds ~/ 2);
        stopTimer();
        print("[TimeModel] Timer stopped");
        HapticFeedback.vibrate();
        //Vibration.vibrate(duration: 1000);
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

class RewardNotifier extends ChangeNotifier {
  void rewardGiven() {
    notifyListeners();
  }
}

void updateTotalHours(int hours) async {
  var dbh = DatabaseHelper();
  await dbh.addTotalHours(hours);
}

void addExpAndCoins(int exp, int coins) async {
  // Add experience and coins to the user
  var dbh = DatabaseHelper();
  await dbh.addProfileExp(exp);
  await dbh.addProfileCoins(coins);

  await dbh.addTotalCoins(coins);
}

void giveReward(int exp, int coins) {
  addExpAndCoins(exp, coins); // give the reward
  BuildContext context = navigatorKey.currentContext!;
  Provider.of<RewardNotifier>(context, listen: false).rewardGiven();
  print("[Cache] Reward given ($exp exp, $coins coins) and listeners notified");
}

void buyItem(String itemName) async {
  var dbh = DatabaseHelper();
  var cost = await dbh.getItemCost(itemName);
  var coins = await dbh.getProfileCoins();
  if (coins >= cost) {
    await dbh.addProfileCoins(-cost);
    await dbh.setItemBought(itemName);
  }
  BuildContext context = navigatorKey.currentContext!;
  Provider.of<RewardNotifier>(context, listen: false).rewardGiven();
  print("[Cache] Item bought: $itemName");
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

//function to get current level's exp
int getNormalisedExp(int exp) {
    int level = getLevel(exp);
    int normExp = exp;
    print("Starting Exp: $exp | Level: $level");
    for(int i = level-1; i >= 1; i--) {
        normExp -= getExpForNextLevel(i);
        print("ExpForNextLevel($i): ${getExpForNextLevel(i)}");
    }
    print("Normalised Exp: $normExp");

    return normExp;
}

// function to get percentage of level completion based on exp.
double getLevelPercentage(int exp) {
  int level = getLevel(exp);
  if (level > 1) {
    int expForNextLevel = getExpForNextLevel(level);
    //int expForCurrentLevel = getExpForNextLevel(level - 1);
    //print("Level: $level, exp: ${getNormalisedExp(exp)}, expForNextLevel: ${expForNextLevel}, expForCurrentLevel: $expForCurrentLevel");
    //final double percentage = (exp - expForPrevLevel) / (expForLevel);
    //final double percentage = (getNormalisedExp(exp) - expForCurrentLevel) / (expForNextLevel - expForCurrentLevel);
    final double percentage = getNormalisedExp(exp) / expForNextLevel;

    print("Percentage: $percentage | Exp: $exp | NormalisedExp: ${getNormalisedExp(exp)} | Level: $level");
    return percentage;
  } else {
    return exp / getExpForNextLevel(level);
  }
}
