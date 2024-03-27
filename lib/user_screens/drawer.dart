import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pronouncepro/user_screens/about_us.dart';
import 'package:pronouncepro/user_screens/home.dart';
import 'package:pronouncepro/user_screens/my_courses.dart';
import 'package:pronouncepro/user_screens/profile.dart';
import 'package:pronouncepro/user_screens/progress.dart';
import 'package:pronouncepro/user_screens/wishlist.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:pronouncepro/models/user_credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SideNavigationState();
}

class _SideNavigationState extends State<SideNavigation> {
  Box<UserCredentials>? userCredentialsBox;
  String? loggedInUser;

  @override
  void initState() {
    super.initState();
    openBox();
    getLoggedInUser();
  }

  Future<void> openBox() async {
    userCredentialsBox = await Hive.openBox<UserCredentials>('credentials_box');
    setState(() {});
  }

  Future<String?> getFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("key_email");
  }

  Future<void> getLoggedInUser() async {
    String? storedEmail = await getFromSharedPreferences();
    if (storedEmail != null) {
      setState(() {
        loggedInUser = storedEmail;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
          backgroundColor: const Color.fromARGB(255, 85, 117, 113),
          child: ListView(
            children: [
              DrawerHeader(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Stack(alignment: Alignment.center, children: [
                      Container(
                          width: 90,
                          height: 90,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile()));
                        },
                        child: CircleAvatar(
                          radius: 43,
                          backgroundImage: userCredentialsBox!.containsKey('key_$loggedInUser') &&
                                userCredentialsBox!.get('key_$loggedInUser')!.imagePath != null
                            ? FileImage(File(userCredentialsBox!.get('key_$loggedInUser')!.imagePath!))
                            : const AssetImage('images/profile-user.png') as ImageProvider,
                                          ),
                      )
                    ]),
                    Text(
                        userCredentialsBox?.get('key_$loggedInUser')?.username
                            as String,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold))
                  ])),
              ListTile(
                  leading: const Icon(Icons.home, color: Colors.white),
                  title: const Text("H O M E",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => Home()));
                  }),
              ListTile(
                  leading: const Icon(FontAwesomeIcons.user, color: Colors.white),
                  title: const Text("P R O F I L E",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  }),
              ListTile(
                  leading: const Icon(FontAwesomeIcons.book, color: Colors.white),
                  title: const Text("M Y  C O U R S E S",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyCourses()));
                  }),
              ListTile(
                  leading: const Icon(FontAwesomeIcons.barsProgress,
                      color: Colors.white),
                  title: const Text("P R O G R E S S",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Progress()));
                  }),
              ListTile(
                  leading: const Icon(FontAwesomeIcons.cartShopping,
                      color: Colors.white),
                  title: const Text("W I S H L I S T",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => WishList()));
                  }),
              ListTile(
                  leading: const Icon(Icons.info,
                      color: Colors.white),
                  title: const Text("A B O U T  U S",
                      style: TextStyle(color: Colors.white)),
                  onTap : () {
                    Navigator.pushReplacement(context, 
                        MaterialPageRoute(builder: (context) => AboutUs()));
                  }
              )
            ],
          )),
    );
  }
}
