import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hocus_focus/cache.dart';
import 'package:hocus_focus/global.dart';
import 'package:hocus_focus/screens/main_page.dart';
import 'package:hocus_focus/screens/welcome_page.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:provider/provider.dart';
import 'screens/main_page.dart' as main_page;

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
  bool _isDatabaseCreated = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _checkDatabase();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    showDailyAtTime();
  }

  Future<void> _checkDatabase() async {
    _isDatabaseCreated = await DatabaseHelper().isDatabaseCreated();
    setState(() {
      _isLoading = false;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Hocus Focus',
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.background,
        useMaterial3: true,
      ),
      home: _isDatabaseCreated ? MainPage(key: main_page.mainPageKey) : WelcomePage(),
    );
  }
}
