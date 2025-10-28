import 'package:to_do_list_hustle_hub/models/section_model.dart';
import 'package:to_do_list_hustle_hub/models/task_model.dart';

List<SectionModel> sections = [
  SectionModel(
    sectionName: "Star",
    tasks: List.generate(
      100,
      (index) => TaskModel(
        taskName: "Star Task $index",
        starred: false,
        dateTime: DateTime.now(),
        completed: false,
      ),
    ),
  ),
  SectionModel(
    sectionName: "MyTask",
    tasks: List.generate(
      100,
      (index) => TaskModel(
        taskName: "MyTask $index",
        starred: false,
        dateTime: DateTime.now(),
        completed: false,
      ),
    ),
  ),
  SectionModel(
    sectionName: "Work",
    tasks: List.generate(
      100,
      (index) => TaskModel(
        taskName: "Work Task $index",
        starred: false,
        dateTime: DateTime.now(),
        completed: false,
      ),
    ),
  ),
  SectionModel(
    sectionName: "Home",
    tasks: List.generate(
      100,
      (index) => TaskModel(
        taskName: "Home Task $index",
        starred: false,
        dateTime: DateTime.now(),
        completed: false,
      ),
    ),
  ),
  SectionModel(
    sectionName: "Gym",
    tasks: List.generate(
      100,
      (index) => TaskModel(
        taskName: "Gym Task $index",
        starred: false,
        dateTime: DateTime.now(),
        completed: false,
      ),
    ),
  ),
  SectionModel(
    sectionName: "Shopping",
    // tasks: List.generate(
    //   100,
    //   (index) => TaskModel(
    //     taskName: "Gym Task $index",
    //     starred: false,
    //     dateTime: DateTime.now(),
    //     completed: false,
    //   ),
    // ),
  ),
];
