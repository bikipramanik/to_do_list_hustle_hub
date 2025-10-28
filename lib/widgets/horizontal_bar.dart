import 'package:flutter/material.dart';
import 'package:to_do_list_hustle_hub/utils/sections.dart';

class HorizontalBarDelegate extends SliverPersistentHeaderDelegate {
  final int selectedIndex;
  final Function(int) onSelectionSelected;
  final Function(int) onSectionDeleted;

  HorizontalBarDelegate({
    required this.onSelectionSelected,
    required this.onSectionDeleted,
    required this.selectedIndex,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    sections.length;
    return Container(
      color: const Color.fromARGB(255, 27, 27, 27), // background under bar
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => onSelectionSelected(index),
              onLongPress: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 40, 40, 40),
                  title: const Text("Delete Section?"),
                  content: Text(
                    "Are you sure you want to delete ${sections[index].sectionName}?",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onSectionDeleted(index);
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
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
