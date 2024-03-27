import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pronouncepro/models/courses.dart';
import 'package:pronouncepro/user_screens/add_to_wishlist.dart';
import 'package:pronouncepro/user_screens/enroll.dart';
import 'package:pronouncepro/user_screens/levels.dart';
import 'package:pronouncepro/user_screens/my_courses.dart';

class AllCourses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AllCoursesState();
}

class AllCoursesState extends State<AllCourses> {
  late Box<Courses> coursesBox;
  late Box<Courses> enrolledBox;
  late Box<Courses> wishListedBox;
  List<Courses> filteredCourses = [];

  TextEditingController searchController = TextEditingController();

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
      return;
    }
    filterCourses("");
    setState(() {}); // Trigger a rebuild after opening the box
  }

  void filterCourses(String enteredValue) {
    if (enteredValue.isEmpty) {
      filteredCourses = List.from(coursesBox.values);
    } else {
      filteredCourses = coursesBox.values
          .where((courses) =>
              courses.title.toLowerCase().contains(enteredValue.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  bool isEnrolled(Courses course) {
    return enrolledBox.values
        .any((enrolledCourse) => enrolledCourse.title == course.title);
  }

  bool isWishListed(Courses course) {
    return wishListedBox.values
        .any((wishListedCourse) => wishListedCourse.title == course.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 154, 137),
        foregroundColor: Colors.white,
        title: const Text('All Courses'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              children: [
                const SizedBox(height: 12),
                TextField(
                    onChanged: (value) {
                      filterCourses(value);
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                        labelText: "Search",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: ListView.builder(
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                final courses = filteredCourses[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Levels(courses: courses)),
                      );
                    },
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
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(8)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  'images/language-learning.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    courses.title,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 76, 46, 35),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (isEnrolled(courses)) {
                                            courseAlert("Enrolled",
                                                "My Courses", MyCourses());
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Enroll(
                                                            course: courses)));
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: isEnrolled(courses)
                                                ? Colors.green
                                                : const Color.fromARGB(
                                                    255, 63, 29, 56),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            isEnrolled(courses)
                                                ? "Enrolled"
                                                : "Enroll",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          if (isWishListed(courses)) {
                                            courseAlert("Enrolled",
                                                "My Courses", MyCourses());
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddToWishList(
                                                            course: courses)));
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: isWishListed(courses)
                                                ? Colors.green
                                                : const Color.fromARGB(
                                                    255, 63, 29, 56),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            isWishListed(courses)
                                                ? "WishListed"
                                                : "Wishlist",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
              },
            ),
          ),
        ],
      ),
    );
  }

  void courseAlert(String action, String page, screen) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Already $action"),
              content:
                  Text("This course is already enrolled. Please go to $page!"),
              actions: [
                TextButton(
                  child: const Text("My Courses"),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => screen));
                  },
                ),
                TextButton(
                  child: const Text("Back"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }
}
