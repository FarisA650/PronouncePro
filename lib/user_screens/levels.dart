import 'package:flutter/material.dart';
import 'package:pronouncepro/models/courses.dart';
import 'package:pronouncepro/ui_elements.dart';
import 'package:pronouncepro/user_screens/lessons.dart';

class Levels extends StatelessWidget {
  final Courses? courses;

  Levels({this.courses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 212, 154, 137),
          foregroundColor: Colors.white,
          title: const Text("Levels")),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DisplayLesson(courseTitle: courses?.title, level: "Beginner");
                }));
              },
              child: levelsContainer("Beginner", 0),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DisplayLesson(courseTitle: courses?.title, level: "Intermediate");
                }));
              },
              child: levelsContainer("Intermediate", 1),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DisplayLesson(courseTitle: courses?.title, level: "Advanced");
                }));
              },
              child: levelsContainer("Advanced", 2),
            ),
          ],
        ),
      ),
    );
  }
}
