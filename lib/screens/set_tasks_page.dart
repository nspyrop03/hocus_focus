import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/welcome_widgets.dart';
import 'package:hocus_focus/widgets/set_tasks_widgets.dart';

class SetTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold( 
      body: Column(
        children: [
          TopBarWidget(), 
          SafeArea(
            child: PageTitleWidget(title: "Create Event"),
          ), // This will be just below the TopBarWidget
          SizedBox(height: 20),
          EventInputWidget(),
          SizedBox(height: 20),
          DifficultyselectionfullWidget(),
        ],
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}