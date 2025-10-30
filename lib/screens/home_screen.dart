import 'package:flutter/material.dart';
import 'package:to_do_list_hustle_hub/models/section_model.dart';
import 'package:to_do_list_hustle_hub/models/task_model.dart';
import 'package:to_do_list_hustle_hub/utils/sections.dart';
import 'package:to_do_list_hustle_hub/widgets/add_task_bottom_sheet.dart';
import 'package:to_do_list_hustle_hub/widgets/completed_task_widget.dart';
import 'package:to_do_list_hustle_hub/widgets/horizontal_bar.dart';
import 'package:to_do_list_hustle_hub/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  bool starWhileAddingTask = false;
  bool addDescriptionWhileAddingTask = false;

  @override
  void dispose() {
    _addTaskDescriptionController.dispose();
    _addTaskNameController.dispose();
    super.dispose();
  }

  final TextEditingController _addTaskNameController = TextEditingController();
  final TextEditingController _addTaskDescriptionController =
      TextEditingController();

  void addToStar(TaskModel task) {
    setState(() {
      if (!sections[0].tasks.any((t) => t.id == task.id)) {
        sections[0].tasks.add(task);
      }
    });
  }

  void removeFromStar(TaskModel task) {
    setState(() {
      sections[0].tasks.removeWhere(
        (t) => t.id == task.id && t.parentSectionId == task.parentSectionId,
      );
    });
  }

  //to delete sections
  void deleteSection(int index) {
    //I do not want to delete first two sections :- star & My task
    if (index < 2) {
      //showwing snackBarMessage
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Can not be deleted"),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      //others can be deleted
      setState(() {
        //changing state for updating the the UI
        sections.removeAt(index);

        //updating pointer to -1 or this will cause range out of bound
        if (selectedIndex >= sections.length) {
          selectedIndex = sections.length - 1;
        }
      });
    }
  }

  // this function change pointer and state to view the tapped section
  void changeSection(int index) {
    setState(() => selectedIndex = index);
  }

  // adding new section with updating UI, here as a parameter we are accepting the SectionModel for adding the section
  void addNewSection(SectionModel section) {
    setState(() {
      sections.add(section);
      selectedIndex++;
    });
  }

  void addTask(
    SectionModel section,
    String taskName,
    String? taskDescription,
    bool star,
  ) {
    if (taskName.isNotEmpty) {
      setState(() {
        section.tasks.add(
          TaskModel(
            parentSectionId: section.id,
            taskName: taskName,
            starred: star,
            dateTime: DateTime.now(),
            completed: false,
            description: taskDescription,
          ),
        );
      });
    }
  }

  void markAsComplete(TaskModel task) {
    final parentSection = sections.firstWhere(
      (s) => s.id == task.parentSectionId,
    );
    print("Marking as complete ----------- ${task.taskName}");
    setState(() {
      if (!parentSection.completedTask.any((t) => t.id == task.id)) {
        parentSection.completedTask.add(task);
        parentSection.tasks.removeWhere((t) => t.id == task.id);
      }
    });
  }

  void markAsInComplete(TaskModel task) {
    final parentSection = sections.firstWhere(
      (s) => s.id == task.parentSectionId,
    );
    print("Marking as incomplete ----------- ${task.taskName}");

    setState(() {
      parentSection.completedTask.add(task);
      parentSection.completedTask.removeWhere((t) => t.id == task.id);
    });
  }

  @override
  void initState() {
    super.initState();

    initializeSection();
  }

  @override
  Widget build(BuildContext context) {
    //here creating a local variable for using the current section
    final selectedSection = sections[selectedIndex];

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
              //custom delegate with extending the delegate abstract class
              delegate: HorizontalBarDelegate(
                //to point and show the tapped section
                onSelectionSelected: changeSection,
                //delete a particular section
                onSectionDeleted: deleteSection,
                //to change the color of selected index of sections
                selectedIndex: selectedIndex,
                //to crate a particular section
                //it returns a String, using that string I amcreating sections with the function addNewSection()
                onSectionCreate: (sectionName) {
                  addNewSection(SectionModel(sectionName: sectionName));
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
                        task: selectedSection.tasks[index],
                        addTaskToStar: addToStar,
                        removeTaskFromStar: removeFromStar,
                        taskCompleted: markAsComplete,
                        taskNotCompleted: markAsInComplete,
                      ),

                      childCount: selectedSection.tasks.length,
                    ),
                  ),
            if (selectedSection.completedTask.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 12, bottom: 6),
                  child: Text(
                    "Completed >",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

            // --- Completed Task List (only if not empty)
            if (selectedSection.completedTask.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => CompletedTaskWidget(
                    task: selectedSection.completedTask[index],
                    removeFromComplete: markAsInComplete,
                  ),
                  childCount: selectedSection.completedTask.length,
                ),
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
                        addDescriptionWhileAddingTask,
                    taskNameController: _addTaskNameController,
                    taskDescriptionController: _addTaskDescriptionController,
                    onDescriptionToggle: (value) {
                      setState(() => addDescriptionWhileAddingTask = value);
                    },
                    onSave: (name, description, star) {
                      addTask(sections[selectedIndex], name, description, star);
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
