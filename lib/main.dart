import 'package:flutter/material.dart';
import 'package:hocus_focus/screens/home_page.dart';
import 'package:hocus_focus/screens/set_tasks_page.dart';
import 'package:hocus_focus/screens/task_list_page.dart';
import 'package:hocus_focus/screens/test_page.dart';
import 'package:hocus_focus/screens/timer_page.dart';
import 'package:hocus_focus/screens/welcome_page.dart';
import 'package:hocus_focus/styles/colors.dart';

void main() {  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hocus Focus',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: MyColors.background,
        useMaterial3: true,
      ),
      home: SetTasksPage()//HomePage()//TestPage()//WelcomePage()
    );
  }
}
