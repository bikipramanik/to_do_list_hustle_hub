import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list_hustle_hub/providers/task_manager.dart';
import 'package:to_do_list_hustle_hub/screens/task_detail_screen.dart';
import 'package:to_do_list_hustle_hub/widgets/add_task_bottom_sheet.dart';
import 'package:to_do_list_hustle_hub/widgets/completed_task_widget.dart';
import 'package:to_do_list_hustle_hub/widgets/horizontal_bar.dart';
import 'package:to_do_list_hustle_hub/widgets/task_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {


  @override
  void dispose() {
    _addTaskDescriptionController.dispose();
    _addTaskNameController.dispose();
    super.dispose();
  }

  final TextEditingController _addTaskNameController = TextEditingController();
  final TextEditingController _addTaskDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(taskManagerProvider.notifier).initializeSections();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskState = ref.watch(taskManagerProvider); //the data
    final taskManager = ref.watch(taskManagerProvider.notifier); //the logic

    if (taskState.sections.isEmpty) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 43, 43, 43),
        body: const Center(
          child: Text(
            "No sections yet! Create one to get started.",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            taskManager.addSection("My Tasks");
          },
          child: const Icon(Icons.add),
        ),
      );
    }
    final selectedSection = taskState.sections[taskState.selectedIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 43, 43),
      //safe area is maiinly used to avoid the top part of the mobile(notification bar, front camera)
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            //appbar
            SliverAppBar(
              title: Text("Tasks"),
              floating: true,
              snap: true,
              pinned: false,
              centerTitle: true,

              surfaceTintColor: const Color.fromARGB(255, 27, 27, 27),
              backgroundColor: const Color.fromARGB(255, 27, 27, 27),
            ),
            //horizontal scrollbar under the appbar : which is for sections of tasks
            SliverPersistentHeader(
              //custom delegate with extending
              //kethe delegate abstract class
              delegate: HorizontalBarDelegate(
                sections: taskState.sections,
                //to point and show the tapped section
                onSelectionSelected: taskManager.changeSection,
                //delete a particular section
                onSectionDeleted: (index) => taskManager.deleteSection(index),
                //to change the color of selected index of sections
                selectedIndex: taskState.selectedIndex,
                //to crate a particular section
                //it returns a String, using that string I amcreating sections with the function addNewSection()
                onSectionCreate: (sectionName) {
                  taskManager.addSection(sectionName);
                },
              ),
              pinned: true,
            ),

            selectedSection.tasks.isEmpty
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "Add something to this section",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => TaskWidget(
                        sections: taskState.sections,
                        task: selectedSection.tasks[index],
                        addTaskToStar: taskManager.addToStar,
                        removeTaskFromStar: taskManager.removeFromStar,
                        taskCompleted: taskManager.markAsComplete,
                        taskNotCompleted: taskManager.markAsInComplete,
                        deleteTask: (task, i) => taskManager.deleteTask(
                          task: task,
                          sectionIndex: taskState.selectedIndex,
                        ),
                        onEditTaskName:
                            ({
                              required newName,
                              required sectionIndex,
                              required taskId,
                            }) => taskManager.editTaskName(
                              newName: newName,
                              sectionIndex: taskState.selectedIndex,
                              taskId: taskId,
                            ),
                        onEditDescription:
                            ({
                              required description,
                              required sectionIndex,
                              required taskId,
                            }) => taskManager.editTaskDescription(
                              taskId: taskId,
                              sectionIndex: taskState.selectedIndex,
                              newDescription: description,
                            ),
                        sectionIndex: taskState.selectedIndex,
                      ),

                      childCount: selectedSection.tasks.length,
                    ),
                  ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 12, bottom: 6),
                  child: TextButton(
                    onPressed: () {
                      ref
                          .read(taskManagerProvider.notifier)
                          .toggleCompletedTask();
                    },
                    child: Row(
                      children: [
                        Text(
                          "Completed ",
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        taskState.showCompletedTask
                            ? Icon(
                                Icons.arrow_drop_up,
                                size: 25,
                                color: Colors.lightBlueAccent,
                              )
                            : Icon(
                                Icons.arrow_drop_down,
                                size: 25,
                                color: Colors.lightBlueAccent,
                              ),
                      ],
                    ),
                  ),
                ),
              ),

            // --- Completed Task List (only if not empty)
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final completedTask = selectedSection.completedTask[index];
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailScreen(
                        sections: taskState.sections,
                        task: completedTask,
                        selectedSectionIndex: taskState.selectedIndex,
                        addToStar: taskManager.addToStar,
                        removeFromStar: taskManager.removeFromStar,
                        deleteTask: (task, index) => taskManager.deleteTask(
                          task: task,
                          sectionIndex: taskState.selectedIndex,
                        ),
                        onEditTaskName:
                            ({
                              required newName,
                              required sectionIndex,
                              required taskId,
                            }) => taskManager.editTaskName(
                              newName: newName,
                              sectionIndex: taskState.selectedIndex,
                              taskId: taskId,
                            ),
                        onEditDescription:
                            ({
                              required description,
                              required sectionIndex,
                              required taskId,
                            }) => taskManager.editTaskDescription(
                              taskId: taskId,
                              sectionIndex: taskState.selectedIndex,
                              newDescription: description,
                            ),
                        markAsComplete: taskManager.markAsComplete,
                        markAsInComplete: taskManager.markAsInComplete,
                      ),
                    ),
                  ),
                  child: Container(
                    color: Colors.black,
                    child: CompletedTaskWidget(
                      task: selectedSection.completedTask[index],
                      removeFromComplete: taskManager.markAsInComplete,
                    ),
                  ),
                );
              }, childCount: selectedSection.completedTask.length),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setModalState) {
                  return AddTaskBottomSheet(
                    addDescriptionWhileAddingTask:
                        taskState.addDescriptionWhileAddingTask,
                    taskNameController: _addTaskNameController,
                    taskDescriptionController: _addTaskDescriptionController,
                    onDescriptionToggle: (value) {
                      taskManager.toggleAddDescriptionWhileAdding;
                    },
                    onSave: (name, description, star) {
                      taskManager.addTask(
                        section: taskState.sections[taskState.selectedIndex],
                        taskName: name,
                        star: star,
                      );
                      _addTaskNameController.clear();
                      _addTaskDescriptionController.clear();
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}
