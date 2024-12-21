import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/styles.dart';

import '../styles/colors.dart';

class TaskListItemWidget extends StatefulWidget {
  final String description;
  final bool isDone;

  const TaskListItemWidget({super.key, required this.description, required this.isDone}); 

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
        children: [
          Container(
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
                onChanged: (bool? value) { 
                  setState(() {
                    isDone = value!;
                  });
                },
                activeColor: MyColors.accept,
                
              ),
            ),
          ),
          Text(
            widget.description,
            style: MyStyles.magic14,
          ),
        ],
      )
    );
  }
}