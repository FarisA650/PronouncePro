import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pronouncepro/db_functions/credentials_functions.dart';
import 'package:pronouncepro/splash_screen.dart';
import 'package:pronouncepro/user_screens/home.dart';
import 'package:pronouncepro/ui_elements.dart';
import 'package:pronouncepro/user_screens/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? imagePath;

class Details extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DetailsState(); 
}

class DetailsState extends State<Details> {

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 105,
                        width: 105,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle
                        ),
                      ),
                      GestureDetector(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: imagePath != null
                            ? FileImage(File(imagePath!))
                            : const AssetImage('images/profile-user.png') as ImageProvider<Object>,
                          ),
                        onTap: () {
                          pickImage();
                        },
                      ),
                      Positioned(
                        top: 70,
                        left: 80,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle
                          ),
                        ),
                      ),
                      Positioned(
                        top: 71.5,
                        left: 81.5,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                          child: const Icon(Icons.add, size: 18, color: Colors.grey),
                        ),
                      )
                    ]
                  ),
                  
                  //const SizedBox(height: 100),
            
                  //const Text("Let's Get To Know\nMore About You...", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            
                  const SizedBox(height: 20.0),
        
                  textField("Name", nameController, 250),
            
                  //const SizedBox(height: 12),
        
                  textField("Username", usernameController, 250),
            
                  //const SizedBox(height: 12),
        
                  textField("Phone Number", phoneNumberController, 250),
            
                  const SizedBox(height: 15.0),
            
                  GestureDetector(
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: const Center(child: Text("Save Details", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)))
                    ),
                    onTap: () async {
                      saveCredentials(loggedInUserEmail, loggedInUserPassword, nameController.text, usernameController.text, phoneNumberController.text, profileImagePath: imagePath);
                      debugPrint("Save Credentials Function Called!");
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString(SplashScreenState.KEY_LOGIN, 'userLoggedIn');
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return Home();
                      }));
                    }
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }

  void pickImage() async {
    var pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path;
      });
    }
  }
}
