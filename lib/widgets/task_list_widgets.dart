import 'package:flutter/material.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/styles/styles.dart';

import '../styles/colors.dart';

class TaskListItemWidget extends StatefulWidget {
  final String description;
  final bool isDone;
  final int taskId;
  final VoidCallback onDelete;

  const TaskListItemWidget(
      {super.key, required this.description, required this.isDone, required this.taskId, required this.onDelete});

  @override
  State<TaskListItemWidget> createState() => _TaskListItemWidgetState();
}

class _TaskListItemWidgetState extends State<TaskListItemWidget> {
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    isDone = widget.isDone;
  }

  void _toggleTaskCompletion(bool? value) async {
    setState(() {
      isDone = value!;
    });
    await DatabaseHelper().updateTask(widget.taskId, isDone);
  }

  void _deleteTask() async {
    await DatabaseHelper().deleteTask(widget.taskId);
    widget.onDelete();  
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 385,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: MyStyles.roundBox8,
          color: MyColors.primary,
          boxShadow: [MyStyles.boxShadowBasic],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isDone ? Colors.transparent : MyColors.background,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: isDone,
                    onChanged: _toggleTaskCompletion,
                    activeColor: MyColors.accept,
                  ),
                ),
              ),
            ),
            Expanded(child:Text(
              widget.description,
              style: MyStyles.magic14,
            )),
            IconButton(
                onPressed: _deleteTask,
                icon: Icon(Icons.close, color: MyColors.delete))
          ],
        ));
  }
}

class PlusButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const PlusButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [MyStyles.boxShadowBasic],
        color: MyColors.details,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.add, color: MyColors.primary, size: 40),
      ),
    );
  }
}

class AddTaskDialog extends StatefulWidget {
  final Function(String, bool) onAddTask;

  const AddTaskDialog({super.key, required this.onAddTask});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _descriptionController = TextEditingController();
  bool _isDone = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Task', style: MyStyles.magic24,),
      backgroundColor: MyColors.primary,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description', labelStyle: MyStyles.magic14),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel', style: MyStyles.magic14.copyWith(color: MyColors.details),),
        ),
        TextButton(
          onPressed: () {
            if(_descriptionController.text.isNotEmpty) {
              widget.onAddTask(_descriptionController.text, _isDone);
              Navigator.of(context).pop();
            }
          },
          child: Text('Add', style: MyStyles.magic14.copyWith(color: MyColors.details),),
        ),
      ],
    );
  }
}