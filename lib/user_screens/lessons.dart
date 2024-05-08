import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pronouncepro/models/courses.dart';
import 'package:pronouncepro/user_screens/lesson_content.dart';

class DisplayLesson extends StatefulWidget {
  final String? courseTitle;
  final String? level;

  DisplayLesson({Key? key, this.courseTitle, this.level}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DisplayLessonState();
}

class DisplayLessonState extends State<DisplayLesson> {
  late Box<Courses> coursesBox;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    coursesBox = await Hive.openBox<Courses>('coursenew_box');
    debugPrint('Number of courses in userCredentialsBox: ${coursesBox.length}');
    setState(() {}); // Trigger a rebuild after opening the box
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 154, 137),
        foregroundColor: Colors.white,
        title: Text(widget.level as String),
      ),
      // ignore: unnecessary_null_comparison
      body: coursesBox == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: coursesBox.length,
              itemBuilder: (context, index) {
                final courses = coursesBox.getAt(index);
      
      
                // Filter lessons based on the selected course title and level
                if (courses?.title == widget.courseTitle) {
                  List<dynamic>? lessons;
      
                  switch (widget.level) {
                    case 'Beginner':
                      lessons = courses?.beginnerLessons;
                      break;
                    case 'Intermediate':
                      lessons = courses?.intermediateLessons;
                      break;
                    case 'Advanced':
                      lessons = courses?.advancedLessons;
                      break;
                    default:
                      lessons = [];
                  }
      
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(courses?.title ?? 'No title', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${widget.level} Lessons:'),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: lessons?.length ?? 0,
                          itemBuilder: (context, lessonIndex) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 247, 209, 186),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: ListTile(
                                  title: Text("Lesson ${lessonIndex + 1}", style: const TextStyle(color: Color.fromARGB(255, 76, 46, 35)),),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return LessonContent(
                                        lessonContent: lessons?[lessonIndex] ?? "No Lessons",
                                        courseTitle: widget.courseTitle as String
                                      );
                                    }));
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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
