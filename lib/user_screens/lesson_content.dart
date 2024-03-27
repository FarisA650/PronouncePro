import 'package:flutter/material.dart';
import 'package:pronouncepro/db_functions/course_functions.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:pronouncepro/models/courses.dart';
import 'package:hive/hive.dart';

class LessonContent extends StatefulWidget {
  final String lessonContent;
  final String courseTitle;

  LessonContent({required this.lessonContent, required this.courseTitle});

  @override
  _LessonContentState createState() => _LessonContentState();
}

class _LessonContentState extends State<LessonContent> {
  late YoutubePlayerController _controller;
  Box<Courses>? coursesBox;
  bool _lessonCompleted = false;

  @override
  void initState() {
    super.initState();
    openBox();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.lessonContent) as String,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
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

  Future<void> markLessonCompleted() async {
    if (!_lessonCompleted) {
      incrementLessonProgress(widget.courseTitle);
      setState(() {
        _lessonCompleted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 154, 137),
        foregroundColor: Colors.white,
        title: const Text("Display Lesson"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.blue,
                  handleColor: Colors.blueAccent,
                ),
              ),
      
              const SizedBox(height: 12),
      
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 63, 29, 56),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.black.withOpacity(0.4),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _lessonCompleted ? null : markLessonCompleted,
                child: Text(_lessonCompleted ? 'Lesson Completed' : 'Complete Lesson'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
