import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/welcome_widgets.dart';
import 'package:hocus_focus/widgets/set_tasks_widgets.dart';

class SetTasksPageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: [
              SafeArea(
                child: PageTitleWidget(title: "Create Event"),
              ),
              SizedBox(height: 10),
              Align(alignment: Alignment.center, child: EventInputWidget()),
              SizedBox(height: 10),
              Align(
                  alignment: Alignment.center,
                  child: DifficultyselectionfullWidget()),
              SizedBox(height: 10),
              Align(
                  alignment: Alignment.center,
                  child: EventdescriptioninputWidget()),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: CreateButtonWidget(text: 'Create'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SetTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 20),
          EventdescriptioninputWidget(),
          SizedBox(height: 60),
          CreateButtonWidget(text: 'Create')
        ],
      ),
      //bottomNavigationBar: BottomBarWidget(),
    );
  }
}
