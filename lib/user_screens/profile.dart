import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pronouncepro/models/user_credentials.dart';
import 'package:pronouncepro/ui_elements.dart';
import 'package:pronouncepro/user_screens/drawer.dart';
import 'package:pronouncepro/user_screens/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 154, 137),
        foregroundColor: Colors.white,
        title: const Text('Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                logOutAlert(context);
              },
            ),
          ),
        ],
      ),
      drawer: SideNavigation(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              loggedInUser == null
                ? const CircularProgressIndicator() // Show loading indicator
                : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 136,
                        height: 136,
                        decoration: const BoxDecoration(
                          color: Colors.brown,
                          shape: BoxShape.circle
                        )
                      ),
                      GestureDetector(
                        onTap :() {
                          pickImage();
                        },
                        child: CircleAvatar(
                          radius: 65,
                          backgroundImage: userCredentialsBox!.containsKey('key_$loggedInUser') &&
                                userCredentialsBox!.get('key_$loggedInUser')!.imagePath != null
                            ? FileImage(File(userCredentialsBox!.get('key_$loggedInUser')!.imagePath!))
                            : const AssetImage('images/profile-user.png') as ImageProvider,
                                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${userCredentialsBox?.get('key_$loggedInUser')?.username}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  Text(
                    '${userCredentialsBox?.get('key_$loggedInUser')?.email}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black
                    ),
                  ),
                ]
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    buildListTile(FontAwesomeIcons.user, 'Name', '${userCredentialsBox?.get('key_$loggedInUser')?.name}', 0),
                    buildListTile(Icons.email_outlined, 'Email', '${userCredentialsBox?.get('key_$loggedInUser')?.email}', 1),
                    buildListTile(Icons.phone, 'Phone Number', '${userCredentialsBox?.get('key_$loggedInUser')?.phoneNumber}', 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTile(IconData icon, String title, String subtitle, index) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(color: Colors.black)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.black)),
      trailing: index == 0 ?
      GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EditProfileDialog(userCredentials: userCredentialsBox!.get('key_$loggedInUser')!);
            },
          ).then((_) => setState(() {}));
        },
        child: const Icon(Icons.settings, color: Colors.grey)
        ) : null,
    );
  }

  void pickImage() async {
    var pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage != null) {
      setState(() {
        userCredentialsBox!.put('key_$loggedInUser', UserCredentials(
          email: userCredentialsBox!.get('key_$loggedInUser')!.email,
          password: userCredentialsBox!.get('key_$loggedInUser')!.password,
          name: userCredentialsBox!.get('key_$loggedInUser')!.name,
          username: userCredentialsBox!.get('key_$loggedInUser')!.username,
          phoneNumber: userCredentialsBox!.get('key_$loggedInUser')!.phoneNumber,
          imagePath: pickedImage.path
        ));
      });
    }
  }
}
