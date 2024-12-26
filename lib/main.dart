import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hocus_focus/cache.dart';
import 'package:hocus_focus/global.dart';
import 'package:hocus_focus/screens/welcome_page.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TimerModel()),
        ChangeNotifierProvider(create: (context) => RewardNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    showDailyAtTime();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Hocus Focus',
        theme: ThemeData(
          scaffoldBackgroundColor: MyColors.background,
          useMaterial3: true,
        ),
        home: WelcomePage() //MainPage()
        );
  }
}
