import 'package:flutter/material.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/widgets/calendar_widgets.dart';
import '../widgets/welcome_widgets.dart' as welcome;
import '../global.dart' as global;
import '../cache.dart' as cache;

class CalendarPageLayout extends StatefulWidget {
  @override
  State<CalendarPageLayout> createState() => _CalendarPageLayoutState();
}

class _CalendarPageLayoutState extends State<CalendarPageLayout> {
  Future<void> _loadEvents() async {
    await DatabaseHelper().getEvents();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TableBasicsExample(),
      Expanded(
          child: FutureBuilder(
        future: DatabaseHelper().getEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: EventdisplayWidget(
                          eventId: snapshot.data?[index]['id'],
                          eventName: snapshot.data?[index]['name'],
                          description: snapshot.data?[index]['description'],
                          eventDate: snapshot.data?[index]['end_date'],
                          onDelete: () async {
                            await DatabaseHelper()
                                .deleteEvent(snapshot.data?[index]['id']);
                            _loadEvents();
                          },
                          onFinish: () async {
                            cache.giveReward(
                                global.baseEventExp *
                                    (snapshot.data?[index]['difficulty']
                                        as int),
                                global.baseEventCoins *
                                    (snapshot.data?[index]['difficulty']
                                        as int));

                            var dbh = DatabaseHelper();
                            await dbh.increaseTotalEvents();
                            await dbh.increaseTodayOrAdd();
                            await dbh.deleteEvent(snapshot.data?[index]['id']);
                            _loadEvents();
                          },
                        )));
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      )),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HoverplusbuttonWidget(
              onTap: () {
                // Navigate to Event Details Page
                welcome.mainPageKey.currentState
                    ?.onItemTapped(global.setTasksIndex);
              },
            ),
          ),
        ],
      ),
    ]);
  }
}

/*
class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarWidget(),
          SizedBox(height: 10),
          Flexible(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ListView(
                    padding: EdgeInsets.all(10.0),
                    children: [
                      TableBasicsExample(),
                      EventdisplayWidget(),
                      SizedBox(height: 15),
                      EventdisplayWidget(),
                      SizedBox(height: 15),
                      EventdisplayWidget(),
                    ],
                  ),
                ),
                // HoverplusbuttonWidget positioned at the top-right corner
                Positioned(
                  top: 300,
                  right: 10,
                  child: HoverplusbuttonWidget(
                    onTap: () {
                      // Navigate to Event Details Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SetTasksPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/

/*

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarWidget(),
          SizedBox(height: 10),
          // Flexible ensures proper space allocation for the content
          Flexible(
            child: Stack(
              children: [
                // ListView includes TableBasicsExample and EventdisplayWidgets
                Positioned.fill(
                  child: ListView(
                    padding: EdgeInsets.all(10.0), // Add padding around the list
                    children: [
                      TableBasicsExample(),
                      EventdisplayWidget(),
                      SizedBox(height: 15),
                      EventdisplayWidget(),
                      SizedBox(height: 15),
                      EventdisplayWidget(),
                      // Add more EventdisplayWidgets as needed
                    ],
                  ),
                ),
                // HoverplusbuttonWidget positioned at the top-right corner
                Positioned(
                  top: 300, // Adjust position as needed
                  right: 10, // Adjust position as needed
                  child: HoverplusbuttonWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

*/


/*
class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarWidget(),
          SizedBox(height: 10),
          // Use Flexible to ensure proper space allocation
          Flexible(
            child: Stack(
              children: [
                // The TableBasicsExample is placed at the bottom of the Stack
                Positioned.fill(
                  child: Column(
                    children: [
                      TableBasicsExample(),
                      //SizedBox(height: 15),
                      EventdisplayWidget(),
                      SizedBox(height: 15),
                      EventdisplayWidget(),
                      SizedBox(height: 15),
                      EventdisplayWidget(),
                    ],
                  ),
                ),
                // The HoverplusbuttonWidget is positioned at the top-right corner of the Stack
                Positioned(
                  top: 300, // Adjust top position
                  right: 10, // Adjust right position
                  child: HoverplusbuttonWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
      //bottomNavigationBar: BottomBarWidget(),
    );
  }
}
*/