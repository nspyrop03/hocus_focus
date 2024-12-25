import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';

class InputtextfieldWidget extends StatelessWidget {
  final String hintText; // Parameter for the hint text
  final TextEditingController? controller; // Optional controller for text input
  final double width; // Customizable width
  final double height; // Customizable height

  // Constructor with optional parameters
  const InputtextfieldWidget({
    Key? key,
    required this.hintText, // This allows different hint text to be passed
    this.controller, // Optional controller
    this.width = 280, // Default width if not provided
    this.height = 29, // Default height if not provided
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Use the customizable width
      height: height, // Use the customizable height
      child: Stack(
        children: <Widget>[
          Stack(
            children: [
              Container(
                width: width -
                    30, // Adjust the width to match the container minus padding
                height: height,
                decoration: BoxDecoration(
                  borderRadius: MyStyles.roundBox8,
                  color: MyColors.background,
                  border: MyStyles.borderAll1,
                ),
              ),
              SizedBox(
                width: width - 30, // Adjust the width for the text field
                height: height - 7, // Adjust the height of the text field
                child: TextField(
                  controller: controller, // Use the controller if provided
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText, // Use the hintText passed to the widget
                    hintStyle: MyStyles.magic14,
                  ),
                  style: MyStyles.magic14,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EventInputWidget extends StatelessWidget {

  final TextEditingController nameController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;

  EventInputWidget({required this.nameController, required this.startDateController, required this.endDateController});

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator EventbasicsinputWidget - INSTANCE
    return Container(
        width: 385,
        height: 147,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 385,
                  height: 147,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    boxShadow: [MyStyles.boxShadowBasic],
                    color: MyColors.primary,
                  ))),
          Positioned(
              top: 93,
              left: 13,
              child: Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'End Date:',
                      textAlign: TextAlign.center,
                      style: MyStyles.magic14,
                    ),
                    SizedBox(width: 15),
                    InputtextfieldWidget(
                      controller: endDateController,
                      hintText: "DD/MM/YYYY",
                      width: 200,
                      height: 29,
                    ),
                  ],
                ),
              )),
          Positioned(
              top: 53,
              left: 13,
              child: Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Start Date:',
                        textAlign: TextAlign.center, style: MyStyles.magic14),
                    SizedBox(width: 2),
                    InputtextfieldWidget(
                      controller: startDateController,
                      hintText: "DD/MM/YYYY",
                      width: 200,
                      height: 29,
                    ),
                  ],
                ),
              )),
          Positioned(
              top: 13,
              left: 13,
              child: Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Name:',
                        textAlign: TextAlign.center, style: MyStyles.magic14),
                    SizedBox(width: 38),
                    InputtextfieldWidget(
                      controller: nameController,
                      hintText: "Name task",
                    )
                  ],
                ),
              )),
        ]));
  }
}
/**/

class DifficultyselectionfullWidget extends StatefulWidget {
  final Key? key;

  const DifficultyselectionfullWidget({this.key}) : super(key: key);

  @override
  DifficultyselectionfullWidgetState createState() =>
      DifficultyselectionfullWidgetState();
}

class DifficultyselectionfullWidgetState
    extends State<DifficultyselectionfullWidget> {
  String selectedDifficulty = ''; // Tracks the selected difficulty

  @override
  void initState() {
    super.initState();
    selectedDifficulty = 'Easy'; // Default selected difficulty
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 385,
      height: 89,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 385,
              height: 89,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: [MyStyles.boxShadowBasic],
                color: MyColors.primary,
              ),
            ),
          ),
          Positioned(
            top: 18,
            left: 13, // Position the "Difficulty" label from the left edge
            child: Container(
              decoration: BoxDecoration(),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align the text to the left
                children: <Widget>[
                  Text(
                    'Difficulty',
                    style: MyStyles.magic14,
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(),
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        DifficultySelectionWidget(
                          difficultyText: 'Easy',
                          bulletColor: MyColors.easyOff,
                          selectedColor: MyColors.accept,
                          svgTickPath: 'assets/images/vector27.svg',
                          isSelected: selectedDifficulty == 'Easy',
                          onTap: () {
                            setState(() {
                              selectedDifficulty = 'Easy';
                            });
                          },
                        ),
                        SizedBox(width: 40),
                        DifficultySelectionWidget(
                          difficultyText: 'Medium',
                          bulletColor: MyColors.mediumOff,
                          selectedColor: MyColors.mediumOn,
                          svgTickPath: 'assets/images/vector27.svg',
                          isSelected: selectedDifficulty == 'Medium',
                          onTap: () {
                            setState(() {
                              selectedDifficulty = 'Medium';
                            });
                          },
                        ),
                        SizedBox(width: 40),
                        DifficultySelectionWidget(
                          difficultyText: 'Hard',
                          bulletColor: MyColors.hardOff,
                          selectedColor: MyColors.hardOn,
                          svgTickPath: 'assets/images/vector27.svg',
                          isSelected: selectedDifficulty == 'Hard',
                          onTap: () {
                            setState(() {
                              selectedDifficulty = 'Hard';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DifficultySelectionWidget extends StatelessWidget {
  final String difficultyText;
  final Color bulletColor;
  final Color selectedColor;
  final String svgTickPath;
  final bool
      isSelected; // New parameter to determine if this widget is selected
  final VoidCallback onTap; // Callback when the widget is tapped

  const DifficultySelectionWidget({
    Key? key,
    required this.difficultyText,
    required this.bulletColor,
    required this.selectedColor,
    required this.svgTickPath,
    required this.isSelected, // Pass isSelected to track if this difficulty is selected
    required this.onTap, // Pass onTap callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call the onTap callback when clicked
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Bullet button with dynamic color
              TaskBulletButtonWidget(
                color: isSelected ? selectedColor : bulletColor,
              ),
              // Tick icon, visible only when selected
              if (isSelected)
                SvgPicture.asset(
                  svgTickPath, // Path to your SVG file
                  width: 16, // Adjust width as needed
                  height: 16, // Adjust height as needed
                ),
            ],
          ),
          SizedBox(width: 10), // Space between bullet and text
          // Text for difficulty
          Text(
            difficultyText,
            style: MyStyles.magic14,
          ),
        ],
      ),
    );
  }
}

class TaskBulletButtonWidget extends StatelessWidget {
  final Color color;

  TaskBulletButtonWidget({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
        border: Border.all(
          color: Color.fromRGBO(0, 0, 0, 1),
          width: 1,
        ),
      ),
    );
  }
}

class EventdescriptioninputWidget extends StatelessWidget {

  final TextEditingController descriptionController;

  EventdescriptioninputWidget({required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator EventinputWidget - INSTANCE
    return SizedBox(
        width: 385,
        height: 100,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 385,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: MyStyles.roundBox16,
                    boxShadow: [MyStyles.boxShadowBasic],
                    color: MyColors.primary,
                  ))),
          Positioned(
              top: 35,
              left: 13,
              child: InputtextfieldWidget(
                controller: descriptionController,
                hintText: "Add Description",
                width: 385,
                height: 29,
              )),
          Positioned(
              top: 14,
              left: 13,
              child: Text('Event Description',
                  textAlign: TextAlign.left, style: MyStyles.magic14)),
        ]));
  }
}

class CreateEventButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  CreateEventButtonWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 150,
        height: 62,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: MyStyles.roundBox8,
            boxShadow: [MyStyles.boxShadowBasic],
            color: MyColors.secondary,
            border: MyStyles.borderAll1,
          ),
          child: OutlinedButton(
            onPressed: onPressed,
            style: MyStyles.createButtonStyle,
            child: Text(
              'Create',
              style: MyStyles.magic24.copyWith(color: Colors.black),
            ),
          ),
        ));
  }
}
