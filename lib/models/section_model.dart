import 'package:to_do_list_hustle_hub/models/task_model.dart';
import 'package:uuid/uuid.dart';


class SectionModel {
  static const uuid = Uuid();
  String sectionName;
  final String id;
  List<TaskModel> tasks;
  List<TaskModel> completedTask;

  SectionModel({required this.sectionName, List<TaskModel>? tasks,List<TaskModel>? completedTask})
    : id = uuid.v4(),
      tasks = tasks ?? [],
      completedTask = completedTask ?? [];
}
