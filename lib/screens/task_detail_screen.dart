import 'package:flutter/material.dart';
import 'package:to_do_list_hustle_hub/models/section_model.dart';
import 'package:to_do_list_hustle_hub/models/task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  final SectionModel? section;
  final int selectedSectionIndex;
  final TaskModel task;

  const TaskDetailScreen({
    super.key,
    required this.task,
    this.section,
    required this.selectedSectionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.star_border_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Section Name"),
            Text(task.taskName),
            Text("Add Details"),
          ],
        ),
      ),
    );
  }
}
