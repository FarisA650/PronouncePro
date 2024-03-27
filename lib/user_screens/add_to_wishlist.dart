import 'package:flutter/material.dart';
import 'package:pronouncepro/db_functions/course_functions.dart';
import 'package:pronouncepro/models/courses.dart';
import 'package:pronouncepro/user_screens/wishlist.dart';

class AddToWishList extends StatefulWidget {
  late Courses course;

  AddToWishList({required this.course});

  @override
  State<StatefulWidget> createState() => AddToWishListState();
}

class AddToWishListState extends State<AddToWishList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 154, 137),
        title: const Text("Add to WishList"),
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
              // WishList button
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
                onPressed: _wishListButtonPressed,
                child: const Text('Add to WishList'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _wishListButtonPressed() {
    bool isWishListed = true;

    widget.course.isWishListed = isWishListed;

    saveWishListedCourses(
      widget.course.title,
      widget.course.courseDescription,
      widget.course.beginnerLessons ?? [],
      widget.course.intermediateLessons ?? [],
      widget.course.advancedLessons ?? [],
      widget.course.isSelected,
      isWishListed: widget.course.isWishListed,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Added to WishList'),
        content: const Text('This course has been successfully added to your Wish List.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WishList()));
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
