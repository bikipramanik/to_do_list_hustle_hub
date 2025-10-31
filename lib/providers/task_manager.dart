import 'package:flutter_riverpod/legacy.dart';
import 'package:to_do_list_hustle_hub/models/section_model.dart';
import 'package:to_do_list_hustle_hub/models/task_model.dart';
import 'package:to_do_list_hustle_hub/models/task_state.dart';
import 'package:to_do_list_hustle_hub/utils/sections_org.dart';

class TaskManager extends StateNotifier<TaskState> {
  TaskManager() : super(TaskState(sections: sectionsOrg));

  // -- UI related flags --
  void toggleCompletedTask() {
    state = state.copyWith(showCompletedTask: !state.showCompletedTask);
  }

  void toggleStarWhileAdding() {
    state = state.copyWith(starWhileAddingTask: !state.starWhileAddingTask);
  }

  void toggleAddDescriptionWhileAdding() {
    state = state.copyWith(
      addDescriptionWhileAddingTask: !state.addDescriptionWhileAddingTask,
    );
  }
  //change section
  void changeSection(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  // ----------- Core Operations -------------

  // adding task
  void addTask({
    required SectionModel section,
    required String taskName,
    String? taskDescription,
    bool star = false,
  }) {
    if (taskName.isEmpty) return;

    final updatedSection = section.copyWith(
      tasks: [
        ...section.tasks,
        TaskModel(
          taskName: taskName.trim(),
          starred: star,
          dateTime: DateTime.now(),
          completed: false,
          parentSectionId: section.id,
        ),
      ],
    );

    _updateSection(updatedSection);

    if (star) addToStar(updatedSection.tasks.last);
  }

  // delete Task
  void deleteTask({required TaskModel task, required int sectionIndex}) {
    final section = state.sections[sectionIndex];
    final updatedSection = section.copyWith(
      tasks: section.tasks.where((t) => t.id != task.id).toList(),
      completedTask: section.completedTask
          .where((t) => t.id != task.id)
          .toList(),
    );

    _updateSection(updatedSection);

    if (task.starred) removeFromStar(task);
  }

  //------On complete task----------
  void markAsComplete(TaskModel task) {
    final parent = state.sections.firstWhere(
      (s) => s.id == task.parentSectionId,
    );

    final updatedParent = parent.copyWith(
      tasks: parent.tasks.where((t) => t.id != task.id).toList(),
      completedTask: [...parent.completedTask, task.copyWith(completed: true)],
    );
    //Remove if starred
    if (task.starred) {
      removeFromStar(task);
    }

    _updateSection(updatedParent);
  }

  //------ mark task as Incompleted--------------
  void markAsInComplete(TaskModel task) {
    final parent = state.sections.firstWhere(
      (s) => s.id == task.parentSectionId,
    );

    final updatedParent = parent.copyWith(
      completedTask: parent.completedTask
          .where((t) => t.id != task.id)
          .toList(),
      tasks: [...parent.tasks, task.copyWith(completed: false)],
    );

    _updateSection(updatedParent);
  }

  //-------- add starred task ----------
  void addToStar(TaskModel task) {
    final starSection = state.sections[0];

    if (starSection.tasks.any((t) => t.id == task.id)) return;

    final updated = starSection.copyWith(tasks: [...starSection.tasks, task]);
    _replaceSectionAt(0, updated);
  }

  // ------ remove tasks from star -----------
  void removeFromStar(TaskModel task) {
    final starSection = state.sections[0];

    final updated = starSection.copyWith(
      tasks: starSection.tasks.where((t) => t.id != task.id).toList(),
    );

    _replaceSectionAt(0, updated);
  }

  // ------- edit Task Name ---------
  void editTaskName({
    required String newName,
    required int sectionIndex,
    required String taskId,
  }) {
    if (newName.trim().isEmpty) return;

    final section = state.sections[sectionIndex];

    final tasks = section.tasks.map((t) {
      return t.id == taskId ? t.copyWith(taskName: newName) : t;
    }).toList();

    final updated = section.copyWith(tasks: tasks);

    _updateSection(updated);
  }

  //--------edit Task Description ----------
  void editTaskDescription({
    required String taskId,
    required int sectionIndex,
    required String newDescription,
  }) {
    if (newDescription.trim().isEmpty) return;

    final section = state.sections[sectionIndex];

    final tasks = section.tasks.map((t) {
      return t.id == taskId ? t.copyWith(description: newDescription) : t;
    }).toList();

    final updated = section.copyWith(tasks: tasks);
    _updateSection(updated);
  }

  // ------------Deleting section -----------------
  void deleteSection(int index) {
    if (index < 2) return;

    final newList = [...state.sections]..removeAt(index);

    if (state.selectedIndex >= newList.length) {
      state = state.copyWith(
        sections: newList,
        selectedIndex: newList.length - 1,
      );
    } else {
      state = state.copyWith(sections: newList);
    }
  }

  //------------------Deleting section -------------
  void addSection(String sectionName) {
    final newList = [...state.sections, SectionModel(sectionName: sectionName)];

    state = state.copyWith(
      sections: newList,
      selectedIndex: newList.length - 1,
    );
  }

  

  // ---- Helper Private Methods -----

  void _updateSection(SectionModel updatedSection) {
    final newList = [
      for (final section in state.sections)
        section.id == updatedSection.id ? updatedSection : section,
    ];
    state = state.copyWith(sections: newList);
  }

  void _replaceSectionAt(int index, SectionModel section) {
    final newList = [...state.sections];
    newList[index] = section;
    state = state.copyWith(sections: newList);
  }
}

final taskManagerProvider = StateNotifierProvider<TaskManager, TaskState>((
  ref,
) {
  return TaskManager();
});
