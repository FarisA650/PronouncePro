import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pronouncepro/models/user_credentials.dart';

class ViewUsers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ViewUsersState();
}

class ViewUsersState extends State<ViewUsers> {
  Box<UserCredentials>? userCredentialsBox;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    userCredentialsBox = await Hive.openBox<UserCredentials>('credentials_box');
    setState(() {}); // Trigger a rebuild after opening the box
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
      ),
      body: userCredentialsBox == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: userCredentialsBox!.length,
                itemBuilder: (context, index) {
                  final userCredentials = userCredentialsBox!.getAt(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                    child: Card(
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: userCredentials?.imagePath != null
                                  ? FileImage(File(userCredentials!.imagePath as String))
                                  : const AssetImage('images/profile-user.png') as ImageProvider
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Email: ${userCredentials?.email}', style: const TextStyle(color: Colors.white, fontSize: 16)),
                                  const SizedBox(height: 8),
                                  Text('Name: ${userCredentials?.name}', style: const TextStyle(color: Colors.white, fontSize: 16)),
                                  const SizedBox(height: 8),
                                  Text('Username: ${userCredentials?.username}', style: const TextStyle(color: Colors.white, fontSize: 16)),
                                  const SizedBox(height: 8),
                                  Text('Phone Number: ${userCredentials?.phoneNumber}', style: const TextStyle(color: Colors.white, fontSize: 16)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
