import 'package:flutter/material.dart';
import 'package:pronouncepro/db_functions/course_functions.dart';
import 'package:pronouncepro/models/courses.dart';
import 'package:pronouncepro/user_screens/my_courses.dart';

class Enroll extends StatefulWidget {
  late Courses course;

  Enroll({required this.course});

  @override
  State<StatefulWidget> createState() => EnrollState();
}

class EnrollState extends State<Enroll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 154, 137),
        title: const Text("Enroll Course"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Course details or information
              Text(
                widget.course.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 76, 46, 35),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.course.courseDescription,
                style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 76, 46, 35)),
              ),
              const SizedBox(height: 24),
              // Enroll button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 63, 29, 56),
                  onPrimary: Colors.white,
                  elevation: 4,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _enrollButtonPressed,
                child: const Text('Enroll'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _enrollButtonPressed() {
    bool isEnrolled = true;

    widget.course.isSelected = isEnrolled;

    saveSelectedCoursesNew(
      widget.course.title,
      widget.course.courseDescription,
      widget.course.beginnerLessons ?? [],
      widget.course.intermediateLessons ?? [],
      widget.course.advancedLessons ?? [],
      isSelected: widget.course.isSelected,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enrollment Successful'),
        content: const Text('You have successfully enrolled in the course. Go to My Courses to view enrolled courses!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyCourses()));
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
