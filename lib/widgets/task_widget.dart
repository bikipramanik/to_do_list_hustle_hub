import 'package:flutter/material.dart';
import 'package:to_do_list_hustle_hub/models/task_model.dart';
import 'package:to_do_list_hustle_hub/screens/task_detail_screen.dart';

class TaskWidget extends StatefulWidget {
  final TaskModel task;
  final Function(TaskModel) addTaskToStar;
  final Function(TaskModel) removeTaskFromStar;
  final Function(TaskModel) taskCompleted;
  final Function(TaskModel) taskNotCompleted;

  const TaskWidget({
    super.key,
    required this.task,
    required this.addTaskToStar,
    required this.removeTaskFromStar,
    required this.taskCompleted,
    required this.taskNotCompleted,
  });

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              TaskDetailScreen(task: widget.task, selectedSectionIndex: 1),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => setState(() {
                widget.task.completed = !widget.task.completed;

                if (widget.task.completed) {
                  widget.taskCompleted(widget.task);
                } else {
                  widget.taskNotCompleted(widget.task);
                }
              }),
              icon: widget.task.completed
                  ? Icon(Icons.circle)
                  : Icon(Icons.circle_outlined),
            ),
            Text(widget.task.taskName),
            Spacer(),
            IconButton(
              onPressed: () => setState(() {
                widget.task.starred = !widget.task.starred;

                print(
                  "Star condition ${widget.task.taskName} ----- ${widget.task.starred}",
                );
                if (widget.task.starred) {
                  widget.addTaskToStar(widget.task);
                } else {
                  widget.removeTaskFromStar(widget.task);
                }
              }),
              icon: widget.task.starred
                  ? Icon(Icons.star)
                  : Icon(Icons.star_border),
            ),
          ],
        ),
      ),
    );
  }
}
