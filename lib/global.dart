library global;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hocus_focus/main.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const int shopIndex = 0;
const int bookIndex = 1;
const int homeIndex = 2;
const int calendarIndex = 3;
const int tasksListIndex = 4;
const int timerIndex = 5;
const int setTasksIndex = 6;
const int statisticsIndex = 7;

const int baseEventCoins = 50;
const int baseEventExp = 30;

void initializeTimeZones() {
  tz.initializeTimeZones();
}

void showClockFinishedNotification(bool isTimer) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'clock_finished_channel', 'clock_finished_notification',
      channelDescription: 'Notification for finished clock',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher_monochrome',);
  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Time\'s up!',
    isTimer ? 'Your timer has finished!' : 'Your stopwatch has finished!',
    platformChannelSpecifics,
  );
}

void showNewEventNotification(String name, String description, int difficulty) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'event_channel', 'new_event_notification',
      channelDescription: 'Notification for new event',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher_monochrome',);

  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  var diff = "an easy";
  if (difficulty == 2) {
    diff = "a mid";
  } else if (difficulty == 3) {
    diff = "a tough";
  }

  await flutterLocalNotificationsPlugin.show(
    0,
    'New Event Added!',
    '[$name] $description. Oh it\'s $diff one!',
    platformChannelSpecifics,
  );
}

// function to send notification daily at 9:00 AM
void showDailyAtTime() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'hocus_daily_channel', 'daily_remainer',
      channelDescription: 'Daily reminder to focus on your tasks',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher_monochrome',);
  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  var dbh = DatabaseHelper();
  var uEvents = await dbh.getEvents();
  var uTasks = await dbh.getUncompletedTasks();
  
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'Good morning!',
    'You have $uTasks uncompleted tasks and $uEvents uncompleted events! Time to focus on your tasks!',
    _nextInstanceOfNineAM(),
    platformChannelSpecifics,
    androidScheduleMode: AndroidScheduleMode.inexact,
    matchDateTimeComponents: DateTimeComponents.time,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.wallClockTime,
  );
}

tz.TZDateTime _nextInstanceOfNineAM() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 9);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

// function to play sound effect with bool as parameter
// 0: plays sounds/delete_sound.wav
// 1: plays sounds/finish_sound.wav
void playSound(bool isFinish) async {
  final player = AudioPlayer();
  player.audioCache = AudioCache(prefix: 'assets/');
  if (isFinish) {
    player.play(AssetSource('sounds/finish_sound.wav'));
  } else {
    player.play(AssetSource('sounds/delete_sound.wav'));
  }
  player.onPlayerComplete.listen((event) {
    player.release();
  });
}