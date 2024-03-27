import 'package:flutter/material.dart';
import 'package:pronouncepro/admin_screens/add_courses.dart';
import 'package:pronouncepro/db_functions/course_functions.dart';
import 'package:pronouncepro/ui_elements.dart';

class AddLessons extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddLessonsState();
}

class AddLessonsState extends State<AddLessons> {
  TextEditingController titleController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();

  List<TextEditingController> beginnerListController = [];
  List<TextEditingController> intermediateListController = [];
  List<TextEditingController> advancedListController = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Lessons"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Course Title",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            textField("Enter Title", titleController, double.infinity),

            const SizedBox(height: 12),

            const Text(
              "Course Description",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            textField("Enter Description", courseDescriptionController, double.infinity),

            const SizedBox(height: 12),

            buildLessonSection(
              "Beginner Lessons",
              beginnerListController,
            ),

            const SizedBox(height: 12),

            buildLessonSection(
              "Intermediate Lessons",
              intermediateListController,
            ),

            const SizedBox(height: 12),

            buildLessonSection(
              "Advanced Lessons",
              advancedListController,
            ),

            const SizedBox(height: 12),

            GestureDetector(
              onTap: () {
                saveCoursesNew(
                  titleController.text,
                  courseDescriptionController.text,
                  beginnerListController,
                  intermediateListController,
                  advancedListController,
                );
                debugPrint("Add Courses Tapped!");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AddCourses()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    "Add Course",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLessonSection(String title, List<TextEditingController> listController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            addButton(listController),
          ],
        ),
        const SizedBox(height: 8),
        lessonsListGenerator(listController),
      ],
    );
  }

  Widget lessonsListGenerator(List<TextEditingController> listController) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listController.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Expanded(
                child: textField("Lesson ${index + 1}", listController[index], double.infinity),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    listController.removeAt(index);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget addButton(List<TextEditingController> listController) {
    return GestureDetector(
      onTap: () {
        setState(() {
          listController.add(TextEditingController());
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          children: [
            Text(
              "Add",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5),
            Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}
