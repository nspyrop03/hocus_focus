import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      constraints: BoxConstraints(maxHeight: 350),
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

class EventDisplayWidget2 extends StatelessWidget {
  final String eventName, eventDate, description;
  final int eventId;
  final VoidCallback onDelete, onFinish;

  EventDisplayWidget2({
    required this.eventId,
    required this.eventName,
    required this.eventDate,
    required this.description,
    required this.onDelete,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: 360,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [MyStyles.boxShadowBasic],
        color: MyColors.primary,
      ),
      child: /*Expanded(child:*/ Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '$eventDate ($eventName)',
                        textAlign: TextAlign.left,
                        style: MyStyles.magic14.copyWith(
                          color: MyColors.details,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        description,
                        textAlign: TextAlign.left,
                        style: MyStyles.magic14,
                      ),
                    ),
                  ],
                ),
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: onFinish,
                  child: Text(
                    'Finish',
                    textAlign: TextAlign.center,
                    style: MyStyles.magic14.copyWith(
                      color: MyColors.accept,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onDelete,
                  child: Text(
                    'Delete',
                    textAlign: TextAlign.center,
                    style: MyStyles.magic14.copyWith(
                      color: MyColors.delete,
                    ),
                  ),
                ),
              ],
            ),
          )
        ]
      ),
    );
  }
}

class HoverplusbuttonWidget extends StatelessWidget {
  final VoidCallback onTap;

  HoverplusbuttonWidget({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  color: MyColors.details,
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
