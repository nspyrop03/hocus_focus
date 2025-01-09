import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';

class InputTextFieldWidget2 extends StatelessWidget {
  final String hintText; // Parameter for the hint text
  final TextEditingController? controller; // Optional controller for text input
  final double width; // Customizable width
  final double height; // Customizable height

  // Constructor with optional parameters
  InputTextFieldWidget2({
    super.key,
    this.hintText = '', // This allows different hint text to be passed
    this.controller, // Optional controller
    this.width = 250, // Default width if not provided
    this.height = 29, // Default height if not provided
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: MyStyles.roundBox8,
        color: MyColors.background,
        border: MyStyles.borderAll1,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: MyStyles.magic14,
          ),
          style: MyStyles.magic14,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class InputDateFieldWidget extends StatefulWidget {
  DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;

  InputDateFieldWidget({required this.selectedDate, required this.onChanged});

  @override
  State<InputDateFieldWidget> createState() => _InputDateFieldWidgetState();
}

class _InputDateFieldWidgetState extends State<InputDateFieldWidget> {
  String getFormattedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.selectedDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2026));
    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        widget.selectedDate = picked;
      });
      widget.onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _selectDate(context),
        child: Container(
            width: 200,
            height: 29,
            decoration: BoxDecoration(
              borderRadius: MyStyles.roundBox8,
              color: MyColors.background,
              border: MyStyles.borderAll1,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    getFormattedDate(widget.selectedDate),
                    style: MyStyles.magic14.copyWith(fontSize: 18),
                  ),
                ),
              ],
            )));
  }
}

class EventInputWidget extends StatelessWidget {
  final TextEditingController nameController;
  //final TextEditingController startDateController;
  //final TextEditingController endDateController;

  final DateTime startDate;
  final DateTime endDate;
  final ValueChanged<DateTime> onStartDateChanged;
  final ValueChanged<DateTime> onEndDateChanged;

  EventInputWidget(
      {required this.nameController,
      required this.startDate,
      required this.endDate,
      required this.onStartDateChanged,
      required this.onEndDateChanged});

  String getNameWithSpaces(String inText) {
    String outText = inText;
    int desiredLength = 'Start Date'.length;
    int currentLength = inText.length;
    int spacesToAdd = desiredLength - currentLength;
    for (int i = 0; i < spacesToAdd; i++) {
      outText += ' ';
    }
    return outText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 385,
        height: 147,
        decoration: BoxDecoration(
          borderRadius: MyStyles.roundBox16,
          boxShadow: [MyStyles.boxShadowBasic],
          color: MyColors.primary,
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8.0),
              child: Text(
                getNameWithSpaces('Name'),
                textAlign: TextAlign.left,
                style: MyStyles.magic14,
              ),
            ),
            InputTextFieldWidget2(
              controller: nameController,
              hintText: "Name event",
            )
          ]),
          Row(children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8.0),
              child: Text(
                'Start Date',
                textAlign: TextAlign.left,
                style: MyStyles.magic14,
              ),
            ),
            InputDateFieldWidget(
              selectedDate: startDate,
              onChanged: onStartDateChanged,
            ),
            /*InputTextFieldWidget2(
              controller: startDateController,
              hintText: "DD/MM/YYYY",
              width: 200,
              height: 29,
            )*/
          ]),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8.0),
                child: Text(
                  getNameWithSpaces('End Date'),
                  textAlign: TextAlign.left,
                  style: MyStyles.magic14,
                ),
              ),
              InputDateFieldWidget(
                selectedDate: endDate,
                onChanged: onEndDateChanged,
              ),
              /*
              InputTextFieldWidget2(
                controller: endDateController,
                hintText: "DD/MM/YYYY",
                width: 200,
                height: 29,
              )*/
            ],
          ),
        ]));
  }
}

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
        decoration: BoxDecoration(
          borderRadius: MyStyles.roundBox16,
          boxShadow: [MyStyles.boxShadowBasic],
          color: MyColors.primary,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 13.0, vertical: 8.0),
                  child: Text(
                    'Difficulty',
                    textAlign: TextAlign.left,
                    style: MyStyles.magic14,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 13.0),
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
            )
          ],
        ));
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
    return Container(
        width: 385,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: MyStyles.roundBox16,
          boxShadow: [MyStyles.boxShadowBasic],
          color: MyColors.primary,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 13.0, vertical: 8.0),
                  child: Text(
                    'Event Description',
                    textAlign: TextAlign.left,
                    style: MyStyles.magic14,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: InputTextFieldWidget2(
                    controller: descriptionController,
                    hintText: "Add Description",
                    width: 320,
                    height: 29,
                  ),
                ),
              ],
            )
          ],
        ));
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
