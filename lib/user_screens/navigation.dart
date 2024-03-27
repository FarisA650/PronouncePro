import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pronouncepro/user_screens/home.dart';
import 'package:pronouncepro/user_screens/my_courses.dart';
import 'package:pronouncepro/user_screens/progress.dart';
import 'package:pronouncepro/user_screens/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Navigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NavigationState();
}

Widget home() => Home();
Widget myCourses() => MyCourses();
Widget progress() => Progress();
Widget profile() => Profile();

class NavigationState extends State<Navigation> {

  int _selectedIndex = 0;
  final List<Widget> _screens = [home(), myCourses(), progress(), profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_screens[_selectedIndex],
      bottomNavigationBar:
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 63, 29, 56),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: GNav(
              gap: 8,
              backgroundColor: const Color.fromARGB(255, 63, 29, 56),
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: const Color.fromARGB(255, 77, 60, 119),
              padding: const EdgeInsets.all(12),
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: const [
                GButton(
                  icon: Icons.home,
                  iconSize: 32,
                  text: "Home",
                ),
                GButton(
                  icon: FontAwesomeIcons.book,
                  text: "My Courses",
                ),
                GButton(
                  icon: FontAwesomeIcons.barsProgress,
                  text: "Progress"
                ),
                GButton(
                  icon: FontAwesomeIcons.user,
                  text: "Profile"
                ),
              ]
            ),
          ),
        ),
    );
  }
}