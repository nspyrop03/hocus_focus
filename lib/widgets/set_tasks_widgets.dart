import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:hocus_focus/widgets/welcome_widgets.dart';

import 'package:flutter/material.dart';

class EventInputWidget extends StatelessWidget {
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
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4)
                    ],
                    color: Color.fromRGBO(255, 230, 230, 1),
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
                  ],
                ),
              )),
        ]));
  }
}

class DifficultyselectionfullWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator DifficultyselectionfullWidget - INSTANCE
    return Container(
        width: 385,
        height: 89,
        child: Stack(children: <Widget>[
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
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4)
                    ],
                    color: Color.fromRGBO(255, 230, 230, 1),
                  ))),
          Positioned(
              top: 18,
              left: 13,
              child: Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Difficulty',
                        textAlign: TextAlign.left, style: MyStyles.magic14),
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
                          ),
                          SizedBox(width: 40),
                          DifficultySelectionWidget(
                            difficultyText: 'Medium',
                            bulletColor: MyColors.mediumOff,
                          ),
                          SizedBox(width: 40),
                          DifficultySelectionWidget(
                            difficultyText: 'Hard',
                            bulletColor: MyColors.hardOff,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ]));
  }
}

class DifficultySelectionWidget extends StatelessWidget {
  final String difficultyText;
  final Color bulletColor;

  DifficultySelectionWidget({
    required this.difficultyText,
    required this.bulletColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 61,
      height: 24,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: TaskBulletButtonWidget(
              color: bulletColor, // Pass the color for the bullet
            ),
          ),
          Positioned(
            top: 5,
            left: 30,
            child: Text(
              difficultyText, // Use the dynamic text
              textAlign: TextAlign.center,
              style: MyStyles.magic14,
            ),
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
        color: color, // Use the dynamic color
        border: Border.all(
          color: Color.fromRGBO(0, 0, 0, 1),
          width: 1,
        ),
      ),
    );
  }
}


