import 'package:flutter/material.dart';
import 'package:to_do_list_hustle_hub/utils/sections.dart';
import 'package:to_do_list_hustle_hub/widgets/horizontal_bar.dart';
import 'package:to_do_list_hustle_hub/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  void deleteSection(int index) {
    if (index < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Can not be deleted"),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      setState(() {
        sections.removeAt(index);

        if (selectedIndex >= sections.length) {
          selectedIndex = sections.length - 1;
        }
      });
    }
  }

  void changeSection(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final selectedSection = sections[selectedIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 27, 27),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Tasks"),
              floating: true,
              snap: true,
              pinned: false,
              centerTitle: true,

              surfaceTintColor: const Color.fromARGB(255, 27, 27, 27),
              backgroundColor: const Color.fromARGB(255, 27, 27, 27),
            ),
            SliverPersistentHeader(
              delegate: HorizontalBarDelegate(
                onSelectionSelected: changeSection,
                onSectionDeleted: deleteSection,
                selectedIndex: selectedIndex,
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
                      (context, index) =>
                          TaskWidget(task: selectedSection.tasks[index]),

                      childCount: selectedSection.tasks.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
