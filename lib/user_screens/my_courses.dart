import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pronouncepro/models/courses.dart';
import 'package:pronouncepro/user_screens/drawer.dart';
import 'package:pronouncepro/user_screens/home.dart';
import 'package:pronouncepro/user_screens/levels.dart';

class MyCourses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyCoursesState();
}

class MyCoursesState extends State<MyCourses> {
  Box<Courses>? coursesBox;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    try {
      coursesBox = await Hive.openBox<Courses>('enrolled_courses_box');
    } catch (e) {
      debugPrint("Error opening Box!");
      return;
    }
    setState(() {}); // Trigger a rebuild after opening the box
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 244, 244, 244),
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 212, 154, 137),
      foregroundColor: Colors.white,
      title: const Text('My Courses'),
      actions: [
          Row(
            children: [
              GestureDetector(
                onTap : () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home())),
                child: const Icon(Icons.home, color: Colors.white)
              ),
              const SizedBox(width: 15)
            ],
          )
        ]
    ),
    drawer: SideNavigation(),
    body: ListView.builder(
      itemCount: coursesBox?.length ?? 0,
      itemBuilder: (context, index) {
        final courses = coursesBox?.getAt(index);
        if(courses!.isSelected == true) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Levels(courses: courses)));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 247, 209, 186),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Image.asset('images/language-learning.png'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              courses.title,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 76, 46, 35),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: const Text(
                                "Enrolled",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 76, 46, 35),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    ),
  );
}
}