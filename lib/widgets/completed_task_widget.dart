import 'package:flutter/material.dart';
import 'package:to_do_list_hustle_hub/models/task_model.dart';

class CompletedTaskWidget extends StatelessWidget {
  final Function(TaskModel) removeFromComplete;
  final TaskModel task;

  const CompletedTaskWidget({
    super.key,
    required this.task,
    required this.removeFromComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => removeFromComplete(task),
                icon: Icon(Icons.check),
              ),
              Text(
                task.taskName,
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
