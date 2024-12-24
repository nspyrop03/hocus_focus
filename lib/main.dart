import 'package:flutter/material.dart';
import 'package:hocus_focus/cache.dart';
import 'package:hocus_focus/screens/calendar_page.dart';
import 'package:hocus_focus/screens/main_page.dart';
import 'package:hocus_focus/screens/welcome_page.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/screens/spellbook_page.dart';
import "package:hocus_focus/screens/shop_page.dart";
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database;
  runApp(
    ChangeNotifierProvider(
      create: (context) => TimerModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hocus Focus',
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.background,
        useMaterial3: true,
      ),
      home: WelcomePage() //MainPage()
    );
  }
}

