import 'package:to_do_list_hustle_hub/models/section_model.dart';
import 'package:to_do_list_hustle_hub/models/task_model.dart';

List<SectionModel> sections = [];

void initializeSection() {
  sections = [
    SectionModel(sectionName: "Star"),
    SectionModel(sectionName: "My Task"),
    SectionModel(sectionName: "Shopping"),
    SectionModel(sectionName: "Gym"),
    SectionModel(sectionName: "Study"),
    SectionModel(sectionName: "Office"),
    SectionModel(sectionName: "Home"),
  ];

  for (final section in sections) {
    if (section.sectionName != "Star") {
      section.tasks = List.generate(
        20,
        (index) => TaskModel(
          taskName: "${section.sectionName} $index",
          starred: false,
          dateTime: DateTime.now(),
          completed: false,
          parentSectionId: section.id,
        ),
      );
    }
  }
}
