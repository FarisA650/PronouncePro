import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pronouncepro/models/courses.dart';

void saveSelectedCoursesNew(
  String title,
  String courseDescription,
  List<dynamic> beginnerLessons,
  List<dynamic> intermediateLessons,
  List<dynamic> advancedLessons,
  {bool? isSelected}
) async {
  debugPrint("saveSelectedCourses Called!");
  try {
    final courseNewBox = await Hive.openBox<Courses>('enrolled_courses_box');

    final saveNewCourses = Courses(
      title: title,
      courseDescription: courseDescription,
      beginnerLessons: List<String>.from(beginnerLessons),
      intermediateLessons: List<String>.from(intermediateLessons),
      advancedLessons: List<String>.from(advancedLessons),
      isSelected: isSelected
    );

    await courseNewBox.put("key_$title", saveNewCourses);
    debugPrint("Selected Data Entered!");
    debugPrint(isSelected.toString());
  } catch (e) {
    debugPrint("Error in Entering values: $e");
  }
}

void incrementLessonProgress(String courseTitle) async {
  try {
    final enrolledBox = await Hive.openBox<Courses>('enrolled_courses_box');
    
    // Find the Courses instance for the given courseTitle
    final Courses course = enrolledBox.values.firstWhere((course) => course.title == courseTitle);

    if (course != null) {
      // Increment lessonProgress
      course.lessonProgress = (course.lessonProgress ?? 0) + 1;

      // Save the updated Courses instance back to the Hive box
      await enrolledBox.put("key_${course.title}", course);

      debugPrint("Lesson Progress incremented for ${course.title}. New progress: ${course.lessonProgress}");
    } else {
      debugPrint("Course not found with title: $courseTitle");
    }
  } catch (e) {
    debugPrint("Error incrementing lesson progress: $e");
  }
}

void saveWishListedCourses(
  String title,
  String courseDescription,
  List<dynamic> beginnerLessons,
  List<dynamic> intermediateLessons,
  List<dynamic> advancedLessons,
  bool? isSelected,
  {bool? isWishListed}
) async {
  debugPrint("saveWishListedCourses Called!");
  try {
    final courseNewBox = await Hive.openBox<Courses>('wishlisted_courses_box');

    final saveWishListedCourses = Courses(
      title: title,
      courseDescription: courseDescription,
      beginnerLessons: List<String>.from(beginnerLessons),
      intermediateLessons: List<String>.from(intermediateLessons),
      advancedLessons: List<String>.from(advancedLessons),
      isSelected: isSelected,
      isWishListed: isWishListed
    );

    await courseNewBox.put("key_$title", saveWishListedCourses);
    debugPrint("WishListed Data Entered!");
    debugPrint(isWishListed.toString());
    debugPrint(isSelected.toString());
  } catch (e) {
    debugPrint("Error in Entering values: $e");
  }
}

void saveCoursesNew(
  String title,
  String courseDescription,
  List<dynamic> beginnerLessons,
  List<dynamic> intermediateLessons,
  List<dynamic> advancedLessons,
  {bool? isSelected, bool? isWishListed}
) async {
  debugPrint("saveCoursesNew Called!");

  try {
    final courseNewBox = await Hive.openBox<Courses>('coursenew_box');

    // Convert TextEditingController values to strings
    List beginnerLessonStrings = beginnerLessons.map((controller) => controller.text).toList();
    List intermediateLessonStrings = intermediateLessons.map((controller) => controller.text).toList();
    List advancedLessonStrings = advancedLessons.map((controller) => controller.text).toList();

    final saveNewCourses = Courses(
      title: title,
      courseDescription: courseDescription,
      beginnerLessons: beginnerLessonStrings,
      intermediateLessons: intermediateLessonStrings,
      advancedLessons: advancedLessonStrings,
      isSelected: isSelected,
      isWishListed: isWishListed
    );

    await courseNewBox.put("key_$title", saveNewCourses);
    debugPrint("Data Entered!");
  } catch (e) {
    debugPrint("Error in Entering values: $e");
  }
}
