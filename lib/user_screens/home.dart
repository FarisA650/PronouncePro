import 'package:flutter/material.dart';
import 'package:pronouncepro/ui_elements.dart';
import 'package:pronouncepro/user_screens/all_courses.dart';
import 'package:pronouncepro/user_screens/drawer.dart';
import 'package:pronouncepro/user_screens/premium.dart';


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 154, 137),
        foregroundColor: Colors.white,
        title: const Text("Home"),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  logOutAlert(context);
                },
                child: const Icon(Icons.logout),
              ),
              const SizedBox(width: 15)
            ],
          )
        ]
      ),
      drawer: SafeArea(
        child: SideNavigation()
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Premium()));
                },
                child: buildPremiumContainer()
              ),
              const SizedBox(height: 15),
              buildFreeContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPremiumContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 209, 186),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
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
                  child: Image.asset('images/premium.png'),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Check out\nour Premium Courses",
                  style: TextStyle(
                    color: Color.fromARGB(255, 76, 46, 35),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Text(
              "\$4.99/Yr",
              style: TextStyle(
                color: Color.fromARGB(255, 76, 46, 35),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFreeContainer() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AllCourses();
        }));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 247, 209, 186),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
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
                  const Text(
                    "Continue with\nour Free Courses",
                    style: TextStyle(
                      color: Color.fromARGB(255, 76, 46, 35),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Text(
                "Free",
                style: TextStyle(
                  color: Color.fromARGB(255, 76, 46, 35),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
