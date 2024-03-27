import 'package:flutter/material.dart';
import 'package:pronouncepro/models/courses.dart';
import 'package:pronouncepro/models/user_credentials.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pronouncepro/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserCredentialsAdapter());
  Hive.registerAdapter(CoursesAdapter());

  await Hive.openBox<UserCredentials>('credentials_box');
  await Hive.openBox<Courses>('coursenew_box');

  runApp(const PronouncePro());
}

class PronouncePro extends StatelessWidget {
  const PronouncePro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}
