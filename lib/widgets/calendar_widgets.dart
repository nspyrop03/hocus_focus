import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:table_calendar/table_calendar.dart';

class TableBasicsExample extends StatefulWidget {
  const TableBasicsExample({super.key});

  @override
  State<TableBasicsExample> createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 400),
      child: TableCalendar(
        firstDay: DateTime(2024),
        lastDay: DateTime(2026),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },

        // Customizing styles
        calendarStyle: CalendarStyle(
          tablePadding:
              EdgeInsets.zero, // Removes extra padding around the table
          cellMargin: EdgeInsets.all(0),
          todayDecoration: BoxDecoration(
            color: MyColors.primary, // Background color for today
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(
              color: MyColors.details,
              fontFamily: 'AvolisseDEMO',
              fontSize: 14,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
          selectedDecoration: BoxDecoration(
            color: MyColors.details, // Background color for selected day
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(
              color: MyColors.primary,
              fontFamily: 'AvolisseDEMO',
              fontSize: 14,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
          weekendTextStyle: TextStyle(
              color: MyColors.details,
              fontFamily: 'AvolisseDEMO',
              fontSize: 14,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
          defaultTextStyle: TextStyle(
              color: Color(0xff000000),
              fontFamily: 'AvolisseDEMO',
              fontSize: 14,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
          outsideDaysVisible: false, // Hide days outside the current month
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false, // Remove format button if not needed
          titleCentered: true,
          headerPadding: EdgeInsets.zero, // Remove padding in the header

          formatButtonTextStyle: TextStyle(
              color: MyColors.primary,
              fontFamily: 'AvolisseDEMO',
              fontSize: 14,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
          formatButtonDecoration: BoxDecoration(
            color: MyColors.details, // Background color of the format button
            borderRadius: BorderRadius.circular(12),
          ),
          titleTextStyle: TextStyle(
              color: Color(0xff000000),
              fontFamily: 'AvolisseDEMO',
              fontSize: 24,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
          leftChevronIcon: Icon(Icons.arrow_back, color: Colors.black),
          rightChevronIcon: Icon(Icons.arrow_forward, color: Colors.black),
          //titleCentered: true,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: MyStyles.magic14,
          weekendStyle: TextStyle(
              color: MyColors.details,
              fontFamily: 'AvolisseDEMO',
              fontSize: 14,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
      ),
    );
  }
}

class EventdisplayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 60,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 360,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [MyStyles.boxShadowBasic],
                color: MyColors
                    .primary, // Replace with MyColors.primary if defined
              ),
            ),
          ),
          Positioned(
            top: 7,
            left: 5,
            child: Text(
              '15/11/2023',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyColors
                    .details, // Replace with MyColors.details if defined
                fontFamily: 'AvolisseDEMO',
                fontSize: 14,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 5,
            child: SvgPicture.asset('assets/images/vector25.svg'),
          ),
          Positioned(
            top: 45,
            left: 318,
            child: GestureDetector(
              onTap: () {
                // Handle Finish action
                print('Finish tapped');
              },
              child: Text(
                'Finish',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyColors
                      .accept, // Replace with MyColors.accept if defined
                  fontFamily: 'AvolisseDEMO',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
              ),
            ),
          ),
          Positioned(
            top: 4,
            left: 317,
            child: GestureDetector(
              onTap: () {
                // Handle Delete action
                print('Delete tapped');
              },
              child: Text(
                'Delete',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyColors
                      .delete, // Replace with MyColors.delete if defined
                  fontFamily: 'AvolisseDEMO',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
              ),
            ),
          ),
          Positioned(
            top: 22,
            left: 5,
            child: Text(
              'Event Name',
              textAlign: TextAlign.center,
              style: MyStyles.magic14,
            ),
          ),
        ],
      ),
    );
  }
}

/*
class EventdisplayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator EventdisplayWidget - INSTANCE
    return Container(
        width: 360,
        height: 60,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 360,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    boxShadow: [MyStyles.boxShadowBasic],
                    color: MyColors.primary,
                  ))),
          Positioned(
              top: 7,
              left: 5,
              child: Text(
                '15/11/2023',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MyColors.details,
                    fontFamily: 'AvolisseDEMO',
                    fontSize: 14,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
            top: 20,
            left: 5,
            child: SvgPicture.asset('assets/images/vector25.svg',
                semanticsLabel: 'vector25'),
          ),
          Positioned(
              top: 45,
              left: 318,
              child: Text(
                'Finish',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MyColors.accept,
                    fontFamily: 'AvolisseDEMO',
                    fontSize: 14,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              top: 4,
              left: 317,
              child: Text(
                'Delete',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MyColors.delete,
                    fontFamily: 'AvolisseDEMO',
                    fontSize: 14,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              top: 22,
              left: 5,
              child: Text('Event Name',
                  textAlign: TextAlign.center, style: MyStyles.magic14)),
        ]));
  }
}
*/
class HoverplusbuttonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Perform your action here
        print('Hover plus button tapped');
      },
      child: Container(
        width: 60,
        height: 60,
        child: Stack(
          children: <Widget>[
            // Background circle container
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: MyColors.details, // Replace with your color
                  borderRadius: BorderRadius.all(Radius.elliptical(60, 60)),
                ),
              ),
            ),
            // Inner content with SVGs
            Positioned(
              top: 13,
              left: 13,
              child: Container(
                width: 34,
                height: 34,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 15,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/vector24.svg', 
                        semanticsLabel: 'vector24',
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 16,
                      child: SvgPicture.asset(
                        'assets/images/vector23.svg', 
                        semanticsLabel: 'vector23',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
