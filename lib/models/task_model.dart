class TaskModel {
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
  });
}
