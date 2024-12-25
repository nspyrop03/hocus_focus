import 'package:flutter/material.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/widgets/welcome_widgets.dart';
import 'package:hocus_focus/widgets/set_tasks_widgets.dart';
import '../global.dart' as global;
import '../widgets/welcome_widgets.dart' as welcome;

class SetTasksPageLayout extends StatelessWidget {
  final _difficultyKey = GlobalKey<DifficultyselectionfullWidgetState>();
  final _nameController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _descriptionController = TextEditingController();

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
              Align(alignment: Alignment.center, child: EventInputWidget(
                nameController: _nameController,
                startDateController: _startDateController,
                endDateController: _endDateController,
              )),
              SizedBox(height: 10),
              Align(
                  alignment: Alignment.center,
                  child: DifficultyselectionfullWidget(key: _difficultyKey)),
              SizedBox(height: 10),
              Align(
                  alignment: Alignment.center,
                  child: EventdescriptioninputWidget(
                    descriptionController: _descriptionController,
                  )),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: CreateEventButtonWidget(onPressed: () async {
                  String name = "Default Event";
                  if (_nameController.text.isNotEmpty) {
                    name = _nameController.text;
                  }

                  int difficulty = 1;
                  if (_difficultyKey.currentState?.selectedDifficulty == "Medium") {
                    difficulty = 2;
                  } else if (_difficultyKey.currentState?.selectedDifficulty == "Hard") {
                    difficulty = 3;
                  }
                  
                  String description = "Default Description";
                  if (_descriptionController.text.isNotEmpty) {
                    description = _descriptionController.text;
                  }

                  String startDate = getCurrentDate();
                  if (_startDateController.text.isNotEmpty && isValidDate(_startDateController.text)) {
                    startDate = _startDateController.text;
                  }

                  String endDate = getTomorrowDate();
                  if (_endDateController.text.isNotEmpty && isFutureDate(_endDateController.text)) {
                    endDate = _endDateController.text;
                  }

                  // Save the event to the database
                  await DatabaseHelper().createNewEvent(
                    name,
                    description,
                    startDate,
                    endDate,
                    difficulty,
                  );
                  print("Event created successfully with name: $name, description: $description, start date: $startDate, end date: $endDate, difficulty: $difficulty");

                  // Navigate to the Calendar Page
                  welcome.mainPageKey.currentState?.onItemTapped(global.calendarIndex);

                },),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String getCurrentDate() {
  DateTime now = DateTime.now();
  return "${now.day}/${now.month}/${now.year}";
}

String getTomorrowDate() {
  DateTime tomorrow = DateTime.now().add(Duration(days: 1));
  return "${tomorrow.day}/${tomorrow.month}/${tomorrow.year}";
}

// function to check if the string is valid for date, checking length, if it contains '/' and if it can be parsed to int
bool isValidDate(String date) {
  if (date.length != 10) {
    return false;
  }
  if (date[2] != '/' || date[5] != '/') {
    return false;
  }
  try {
    int.parse(date.substring(0, 2));
    int.parse(date.substring(3, 5));
    int.parse(date.substring(6, 10));
  } catch (e) {
    return false;
  }
  return true;
}

// function that uses isValidDate and also checks if the date is in the future
bool isFutureDate(String date) {
  if (!isValidDate(date)) {
    return false;
  }
  List<String> dateParts = date.split('/');
  int day = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int year = int.parse(dateParts[2]);
  DateTime now = DateTime.now();
  if (year < now.year) {
    return false;
  }
  if (year == now.year && month < now.month) {
    return false;
  }
  if (year == now.year && month == now.month && day <= now.day) {
    return false;
  }
  return true;
}

/*
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
*/