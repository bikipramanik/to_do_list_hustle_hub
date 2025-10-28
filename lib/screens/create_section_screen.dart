import 'package:flutter/material.dart';


class CreateSectionScreen extends StatefulWidget {
  const CreateSectionScreen({super.key});

  @override
  State<CreateSectionScreen> createState() => _CreateSectionScreenState();
}

class _CreateSectionScreenState extends State<CreateSectionScreen> {
  final TextEditingController _sectionNameController = TextEditingController();

  @override
  void dispose() {
    _sectionNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close),
        ),
        title: Text("Create New List"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              final sectionName = _sectionNameController.text.trim();
              if (sectionName.isNotEmpty) {
                Navigator.of(context).pop(sectionName);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text("Done"),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: _sectionNameController,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              cursorHeight: 25,
              cursorColor: Colors.blueAccent,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                hintText: "Enter List Name...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
