import 'package:hive/hive.dart';

part 'courses.g.dart';

@HiveType(typeId: 1)
class Courses {
  @HiveField(0)
  String title;

  @HiveField(1)
  String courseDescription;

  @HiveField(2)
  List<dynamic>? beginnerLessons;

  @HiveField(3)
  List<dynamic>? intermediateLessons;

  @HiveField(4)
  List<dynamic>? advancedLessons;

  @HiveField(5)
  bool? isSelected = false;

  @HiveField(6)
  bool? isWishListed = false;

  @HiveField(7)
  int? lessonProgress = 0;

  Courses ({
    required this.title,
    required this.courseDescription,

    this.beginnerLessons,
    this.intermediateLessons,
    this.advancedLessons,

    this.isSelected,
    this.isWishListed,

    this.lessonProgress
  });
}