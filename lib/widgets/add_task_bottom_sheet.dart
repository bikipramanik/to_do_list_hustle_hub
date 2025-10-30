import 'package:flutter/material.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final bool addDescriptionWhileAddingTask;
  final TextEditingController taskNameController;
  final TextEditingController taskDescriptionController;
  final Function(bool) onDescriptionToggle;
  final Function(String name, String description, bool star) onSave;

  const AddTaskBottomSheet({
    super.key,
    required this.addDescriptionWhileAddingTask,
    required this.taskNameController,
    required this.taskDescriptionController,
    required this.onDescriptionToggle,
    required this.onSave,
  });

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: AnimatedSize(
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Container(
          height: widget.addDescriptionWhileAddingTask ? 220 : 150,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  // vertical: 10,
                ),
                child: TextField(
                  controller: widget.taskNameController,
                  // onTapOutside: (event) =>
                  //     FocusScope.of(context).unfocus(),
                  cursorColor: Colors.blue,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "New Task",
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),

              if (widget.addDescriptionWhileAddingTask)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    // vertical: 10,
                  ),
                  child: TextField(
                    autofocus: false,
                    controller: widget.taskDescriptionController,
                    // onTapOutside: (event) =>
                    //     FocusScope.of(context).unfocus(),
                    cursorColor: Colors.blue,

                    decoration: InputDecoration(
                      hintText: "add description",
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => widget.onDescriptionToggle,
                      icon: Icon(
                        Icons.notes,
                        color: widget.addDescriptionWhileAddingTask
                            ? Colors.blueAccent
                            : Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.star_border_outlined),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () => widget.onSave,
                      child: Text("Save"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
