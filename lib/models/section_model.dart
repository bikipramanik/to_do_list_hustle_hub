import 'package:to_do_list_hustle_hub/models/task_model.dart';
import 'package:uuid/uuid.dart';

class SectionModel {
  static var uuid = Uuid();
  String sectionName;
  String id;
  List<TaskModel> tasks;

  SectionModel({required this.sectionName, List<TaskModel>? tasks})
    : id = uuid.v4(),
      tasks = tasks ?? [];
}
