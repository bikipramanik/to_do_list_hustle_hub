import 'package:uuid/uuid.dart';

class TaskModel {
  static const uuid = Uuid();
  final String id;
  final String parentSectionId;
  String taskName;
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

  TaskModel copyWith({
    String? id,
    String? parentSectionId,
    String? taskName,
    bool? starred,
    DateTime? dateTime,
    String? description,
    bool? completed,
  }) {
    return TaskModel(
      taskName: taskName ?? this.taskName,
      starred: starred ?? this.starred,
      dateTime: dateTime ?? this.dateTime,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      parentSectionId: parentSectionId ?? this.parentSectionId,
    );
  }
}
