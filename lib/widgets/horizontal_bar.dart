import 'package:flutter/material.dart';
import 'package:to_do_list_hustle_hub/models/section_model.dart';
import 'package:to_do_list_hustle_hub/screens/create_section_screen.dart';

class HorizontalBarDelegate extends SliverPersistentHeaderDelegate {
  final int selectedIndex;
  final List<SectionModel> sections;
  final Function(int) onSelectionSelected;
  final Function(int) onSectionDeleted;
  final Function(String) onSectionCreate;

  HorizontalBarDelegate({
    required this.sections,
    required this.onSelectionSelected,
    required this.onSectionDeleted,
    required this.selectedIndex,
    required this.onSectionCreate,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: const Color.fromARGB(255, 27, 27, 27), // background under bar
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        itemCount: sections.length + 1,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          if (index < sections.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => onSelectionSelected(index),
                onLongPress: () {
                  if (index > 1) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: const Color.fromARGB(255, 40, 40, 40),
                        title: const Text("Delete Section?"),
                        content: Text(
                          "Are you sure you want to delete \"${sections[index].sectionName}\"?",
                          style: const TextStyle(color: Colors.white70),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              onSectionDeleted(index);
                            },
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("This Section cannot be deleted"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.purple : Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    sections[index].sectionName,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          } else {
            return Material(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                enableFeedback: true,
                splashColor: Colors.grey,
                highlightColor: Colors.grey,
                onTap: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreateSectionScreen(),
                    ),
                  );

                  if (result != null && result.toString().trim().isNotEmpty) {
                    onSectionCreate(result.toString().trim());
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    // vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 6),
                      Text("New List"),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant HorizontalBarDelegate oldDelegate) {
    return true;
  }
}
