import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/task_list_widgets.dart';
import 'package:hocus_focus/widgets/welcome_widgets.dart';

class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TopBarWidget(),
          Expanded(
              child: Column(
            children: [
              SizedBox(height: 10,),
              PageTitleWidget(title: "Tasks List"),
              SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: SizedBox(
                        width: 385,
                        height: 40,
                        child: TaskListItemWidget(description: "Task List Entry", isDone: false)),
                    );
                  }
                ),
              ),
              //TaskListItemWidget(description: "test", isDone: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PlusButtonWidget(),
                  ),
                ],
              )
            ],
          )),
        ],
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
