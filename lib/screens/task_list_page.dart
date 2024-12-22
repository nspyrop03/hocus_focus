import 'package:flutter/material.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/widgets/task_list_widgets.dart';
import 'package:hocus_focus/widgets/welcome_widgets.dart';

class TaskListPageLayout extends StatefulWidget {
  @override
  State<TaskListPageLayout> createState() => _TaskListPageLayoutState();
}

class _TaskListPageLayoutState extends State<TaskListPageLayout> {

  List<Map<String, dynamic>> _tasks = [];
  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await DatabaseHelper().getTasks();
    setState(() {
      _tasks = tasks; // update the state also
    });
  }

  void _addTask(String description, bool done) async {
    await DatabaseHelper().insertTask(description, done);
    _loadTasks();
  }
  /*
  void _deleteTaskFromList(int taskId) {
    setState(() {
      _tasks.removeWhere((element) => element['id'] == taskId);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        PageTitleWidget(title: "Tasks List"),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: FutureBuilder(
              future: DatabaseHelper().getTasks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: SizedBox(
                              width: 385,
                              height: 40,
                              child: TaskListItemWidget(
                                  onDelete: () {
                                    _loadTasks();
                                  },
                                  taskId: snapshot.data?[index]['id'],
                                  description: 
                                      snapshot.data?[index]['description'],
                                  isDone:
                                      snapshot.data?[index]['completed'] == 1)),
                        );
                      });
                } else {
                  return Center(
                      child:
                          CircularProgressIndicator()); // wait until the request is solved
                }
              }),
        ),
        //TaskListItemWidget(description: "test", isDone: true),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlusButtonWidget(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return AddTaskDialog(onAddTask: _addTask);
                    });
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
