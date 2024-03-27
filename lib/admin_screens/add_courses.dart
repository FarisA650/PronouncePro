import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pronouncepro/admin_screens/add_lessons.dart';
import 'package:pronouncepro/admin_screens/edit_courses.dart';
import 'package:pronouncepro/models/courses.dart';

class AddCourses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddCoursesState();
}

class AddCoursesState extends State<AddCourses> {
  Box<Courses>? coursesBox;
  late Box<Courses> enrolledBox;
  late Box<Courses> wishListedBox;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    try {
      coursesBox = await Hive.openBox<Courses>('coursenew_box');
      enrolledBox = await Hive.openBox<Courses>('enrolled_courses_box');
      wishListedBox = await Hive.openBox<Courses>('wishlisted_courses_box');
    } catch (e) {
      debugPrint("Error opening Box!");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Courses'),
      ),
      body: coursesBox == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: coursesBox!.length,
              itemBuilder: (context, index) {
                final course = coursesBox!.getAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(course?.title ?? ''),
                      trailing: GestureDetector(
                        child: const Icon(Icons.delete),
                        onTap: () {
                          if (course!.isSelected == true) {
                            deleteEnrolledCourse(index);
                          } else {
                            deleteCourse(index);
                          }
                        },
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => EditLessons(course: course!)),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddLessons()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void deleteEnrolledCourse(index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Course Already Enrolled!"),
        content: const Text("Are you sure you want to delete course?"),
        actions: [
          TextButton(
            child: const Text("Delete"),
            onPressed: () {
              coursesBox!.deleteAt(index);
              if (enrolledBox.isNotEmpty) enrolledBox.deleteAt(index);
              if (wishListedBox.isNotEmpty) wishListedBox.deleteAt(index);
              setState(() {});
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  void deleteCourse(index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Selected Course"),
        content: const Text("Are you sure you want to delete selected course"),
        actions: [
          TextButton(
            child: const Text("Delete"),
            onPressed: () {
              coursesBox!.deleteAt(index);
              if (enrolledBox.isNotEmpty) enrolledBox.deleteAt(index);
              if (wishListedBox.isNotEmpty) wishListedBox.deleteAt(index);
              setState(() {});
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
