import 'package:flutter/material.dart';
import 'package:to_do_list_hustle_hub/models/task_model.dart';

class TaskWidget extends StatefulWidget {
  final TaskModel task;

  const TaskWidget({super.key, required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () =>
                setState(() => widget.task.completed = !widget.task.completed),
            icon: widget.task.completed
                ? Icon(Icons.circle)
                : Icon(Icons.circle_outlined),
          ),
          Text(widget.task.taskName),
          Spacer(),
          IconButton(
            onPressed: () =>
                setState(() => widget.task.starred = !widget.task.starred),
            icon: widget.task.starred
                ? Icon(Icons.star)
                : Icon(Icons.star_border),
          ),
        ],
      ),
    );
  }
}
