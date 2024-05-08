import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pronouncepro/models/courses.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pronouncepro/user_screens/drawer.dart';
import 'package:pronouncepro/user_screens/navigation.dart';

class Progress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProgressState();
}

class ProgressState extends State<Progress> {
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
        title: const Text("Progress"),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap : () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navigation())),
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
          if (courses!.isSelected == true) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 247, 209, 186),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset('images/language-learning.png'),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            courses.title,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 76, 46, 35),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      CircularPercentIndicator(
                        animation: true,
                        animationDuration: 1000,
                        radius: 50,
                        lineWidth: 12,
                        percent: courses.lessonProgress != null &&
                                courses.beginnerLessons != null &&
                                courses.intermediateLessons != null &&
                                courses.advancedLessons != null
                            ? courses.lessonProgress! /
                                (courses.beginnerLessons!.length +
                                    courses.intermediateLessons!.length +
                                    courses.advancedLessons!.length)
                            : 0.0,
                        progressColor: Colors.yellow,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          "${(courses.lessonProgress != null && courses.beginnerLessons != null && courses.intermediateLessons != null && courses.advancedLessons != null ? (courses.lessonProgress! / (courses.beginnerLessons!.length + courses.intermediateLessons!.length + courses.advancedLessons!.length) * 100) : 0.0).toStringAsFixed(2)}%",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
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
