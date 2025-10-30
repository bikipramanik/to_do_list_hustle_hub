import 'package:uuid/uuid.dart';

class TaskModel {
  static const uuid = Uuid();
  final String id;
  final String parentSectionId;
  final String taskName;
  bool starred;
  final DateTime dateTime;
  String? description;
  bool completed;

  TaskModel({
    required this.taskName,
    required this.starred,
    required this.dateTime,
    this.description,
    required this.completed,
    required this.parentSectionId,
  }) : id = uuid.v4();
}
