import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import '/widgets/welcome_widgets.dart';

class SetTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SafeArea(child: PageTitleWidget(title: "Create Event"))
          ],
        )
      ,)
    );
  }
}