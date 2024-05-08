import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pronouncepro/user_screens/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pronouncepro/user_screens/login.dart';
import 'package:pronouncepro/admin_screens/admin_home.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEY_LOGIN = "isLoggedIn";

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), currentScreen); // Delay for 3 seconds
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.scale(
          scale: 3.0,
          child: Lottie.asset('animations/splashscreenanimation.json')
        ),
      ),
    );
  }

  void currentScreen() async {
    final prefs = await SharedPreferences.getInstance();
    String? isLoggedIn = prefs.getString(KEY_LOGIN);

    if (isLoggedIn == 'userLoggedIn') {
      gotoUserHomePage();
    } else if (isLoggedIn == 'adminLoggedIn') {
      gotoAdminHomePage();
    } else {
      gotoLoginPage();
    }
  }

  void gotoUserHomePage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Navigation()));
  }

  void gotoLoginPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  void gotoAdminHomePage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AdminHome()));
  }
}
