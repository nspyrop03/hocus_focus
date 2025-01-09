import 'package:flutter/material.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/widgets/calendar_widgets.dart';
import 'main_page.dart' as main_page;
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
                            global.playSound(false);
                            await DatabaseHelper()
                                .deleteEvent(snapshot.data?[index]['id']);
                            _loadEvents();
                          },
                          onFinish: () async {
                            global.playSound(true);
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
                print("Maaaaaaaaan what's going on? ${main_page.mainPageKey.currentState == null}");
                // Navigate to Event Details Page
                main_page.mainPageKey.currentState
                    ?.onItemTapped(global.setTasksIndex);
              },
            ),
          ),
        ],
      ),
    ]);
  }
}