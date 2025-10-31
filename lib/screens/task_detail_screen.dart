import 'package:flutter/material.dart';

import 'package:to_do_list_hustle_hub/models/task_model.dart';
import 'package:to_do_list_hustle_hub/utils/sections_org.dart';

class TaskDetailScreen extends StatefulWidget {
  final int selectedSectionIndex;
  final TaskModel task;
  final Function(TaskModel) addToStar;
  final Function(TaskModel) removeFromStar;
  final Function(TaskModel, int) deleteTask;
  final Function({
    required String taskId,
    required int sectionIndex,
    required String newName,
  })
  onEditTaskName;
  final Function(TaskModel) markAsComplete;
  final Function(TaskModel) markAsInComplete;

  final Function({
    required String description,
    required int sectionIndex,
    required String taskId,
  })
  onEditDescription;

  const TaskDetailScreen({
    super.key,
    required this.task,

    required this.selectedSectionIndex,
    required this.addToStar,
    required this.removeFromStar,
    required this.deleteTask,
    required this.onEditTaskName,
    required this.onEditDescription,
    required this.markAsComplete,
    required this.markAsInComplete,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController _taskNameEditingController;

  late TextEditingController _taskDescriptionEditingController;
  @override
  void initState() {
    super.initState();
    _taskNameEditingController = TextEditingController(
      text: widget.task.taskName,
    );
    _taskDescriptionEditingController = TextEditingController(
      text: widget.task.description ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => setState(() {
              widget.task.starred = !widget.task.starred;

              print(
                "Star condition from detail screen ${widget.task.taskName} ----- ${widget.task.starred}",
              );

              if (widget.task.starred) {
                widget.addToStar(widget.task);
              } else {
                widget.removeFromStar(widget.task);
              }
            }),
            icon: widget.task.starred
                ? Icon(Icons.star)
                : Icon(Icons.star_border),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 40, 40, 40),
                  title: Text("Delete this task?"),
                  content: Text(
                    "Are you sure you want to delete \"${widget.task.taskName}\" task?",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.deleteTask(
                          widget.task,
                          widget.selectedSectionIndex,
                        );
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Delete",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Row(
              children: [
                Text(
                  sectionsOrg[widget.selectedSectionIndex].sectionName,
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.lightBlueAccent),
              ],
            ),
            TextField(
              controller: _taskNameEditingController,
              onChanged: (value) {
                if (value.trim().isNotEmpty) {
                  widget.onEditTaskName(
                    newName: value.trim(),
                    sectionIndex: widget.selectedSectionIndex,
                    taskId: widget.task.id,
                  );
                }
              },
              style: TextStyle(fontSize: 20, color: Colors.white),
              onTapOutside: (_) => FocusScope.of(context).unfocus(),

              decoration: InputDecoration(border: InputBorder.none),
            ),
            Row(
              children: [
                const Icon(Icons.notes, color: Colors.white38),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _taskDescriptionEditingController,
                    onTapOutside: (value) {
                      FocusScope.of(context).unfocus();
                    },

                    onChanged: (value) {
                      if (value.trim().isNotEmpty) {
                        widget.onEditDescription(
                          description: value.trim(),
                          sectionIndex: widget.selectedSectionIndex,
                          taskId: widget.task.id,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      hintText:
                          widget.task.description == null ||
                              widget.task.description!.isEmpty
                          ? "Add descriptions..."
                          : null,
                      hintStyle: TextStyle(color: Colors.white24),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          widget.task.completed
              ? widget.markAsInComplete(widget.task)
              : widget.markAsComplete(widget.task);
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 135, 217, 255),
          foregroundColor: Colors.black,
        ),
        child: Text(
          widget.task.completed ? "Mark as Incompleted" : "Mark as Complete",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
