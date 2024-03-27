import 'package:flutter/material.dart';
import 'package:pronouncepro/admin_screens/add_courses.dart';
import 'package:pronouncepro/db_functions/course_functions.dart';
import 'package:pronouncepro/models/courses.dart';

class EditLessons extends StatefulWidget {
  final Courses course;

  EditLessons({required this.course});

  @override
  State<StatefulWidget> createState() => _EditLessonsState();
}

class _EditLessonsState extends State<EditLessons> {
  late TextEditingController titleController;
  late TextEditingController courseDescriptionController;
  List<TextEditingController> beginnerListController = [];
  List<TextEditingController> intermediateListController = [];
  List<TextEditingController> advancedListController = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing course information
    titleController = TextEditingController(text: widget.course.title);
    courseDescriptionController = TextEditingController(text: widget.course.courseDescription);
    beginnerListController = widget.course.beginnerLessons
        ?.map((lesson) => TextEditingController(text: lesson))
        .toList() ?? [TextEditingController()];
    intermediateListController = widget.course.intermediateLessons
        ?.map((lesson) => TextEditingController(text: lesson))
        .toList() ?? [TextEditingController()];
    advancedListController = widget.course.advancedLessons
        ?.map((lesson) => TextEditingController(text: lesson))
        .toList() ?? [TextEditingController()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Lessons for ${widget.course.title}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Course Title',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Enter Title',
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Course Description',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: courseDescriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Enter Description',
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Beginner Lessons',
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  addButton(beginnerListController),
                ],
              ),
              const SizedBox(height: 8),
              Form(
                child: lessonsListGenerator(beginnerListController),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Intermediate Lessons',
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  addButton(intermediateListController),
                ],
              ),
              const SizedBox(height: 8),
              Form(
                child: lessonsListGenerator(intermediateListController),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Advanced Lessons',
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  addButton(advancedListController),
                ],
              ),
              const SizedBox(height: 8),
              Form(
                child: lessonsListGenerator(advancedListController),
              ),
              const SizedBox(height: 12),
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    saveCoursesNew(
                      titleController.text,
                      courseDescriptionController.text,
                      beginnerListController,
                      intermediateListController,
                      advancedListController,
                    );
                    debugPrint('Add Courses Tapped!');
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return AddCourses();
                    }));
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ListView to dynamically generate text fields
  Widget lessonsListGenerator(List<TextEditingController> listController) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listController.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: listController[index],
                  decoration: InputDecoration(
                    hintText: 'Lesson ${index + 1}',
                    labelText: 'Lesson ${index + 1}',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                child: const Icon(Icons.delete, size: 32),
                onTap: () {
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

  // Add button to add more text fields to the list
  Widget addButton(List<TextEditingController> listController) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          children: [
            Text(
              'Add',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5),
            Icon(Icons.add),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          listController.add(TextEditingController());
        });
      },
    );
  }
}
