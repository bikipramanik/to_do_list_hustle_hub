import 'package:to_do_list_hustle_hub/models/section_model.dart';

class TaskState {
  final List<SectionModel> sections;
  final int selectedIndex;
  final bool starWhileAddingTask;
  final bool addDescriptionWhileAddingTask;
  final bool showCompletedTask;

  TaskState({
    required this.sections,
    this.selectedIndex = 1,
    this.starWhileAddingTask = false,
    this.showCompletedTask = false,
    this.addDescriptionWhileAddingTask = false,
  });

  TaskState copyWith({
    List<SectionModel>? sections,
    int? selectedIndex,
    bool? starWhileAddingTask,
    bool? addDescriptionWhileAddingTask,
    bool? showCompletedTask,
  }) {
    return TaskState(
      sections: sections ?? this.sections,
      addDescriptionWhileAddingTask:
          addDescriptionWhileAddingTask ?? this.addDescriptionWhileAddingTask,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      showCompletedTask: showCompletedTask ?? this.showCompletedTask,
      starWhileAddingTask: starWhileAddingTask ?? this.starWhileAddingTask,
    );
  }
}
