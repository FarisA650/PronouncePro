import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pronouncepro/models/user_credentials.dart';
import 'package:pronouncepro/user_screens/home.dart';

void saveCredentials(String emailController, String passwordController, String nameController, String usernameController, String phoneNumberController, {String? profileImagePath}) async {
  debugPrint("saveCredentials Called!");
  try {
    final userCredentialsBox = await Hive.openBox<UserCredentials>('credentials_box');

      final email = emailController;
      final password = passwordController;
      final name = nameController;
      final username = usernameController;
      final phoneNumber = phoneNumberController;
      final imagePath = profileImagePath;

      if (email.isNotEmpty && password.isNotEmpty) {

        final existingCredentials = userCredentialsBox.get('key_$email');

        if(existingCredentials != null){
          debugPrint("Email Already Exist!");
          return;
        }

        final userCredentials = UserCredentials(
          email: email,
          password: password,
          name: name,
          username: username,
          phoneNumber: phoneNumber,
          imagePath: imagePath
        );

        await userCredentialsBox.put('key_$email', userCredentials);
        debugPrint("Data Entered!");
        debugPrint("Email: ${userCredentials.email}");
        debugPrint("Password: ${userCredentials.password}");
        debugPrint("Name: ${userCredentials.name}");
        debugPrint("Username: ${userCredentials.username}");
        debugPrint("Phone Number: ${userCredentials.phoneNumber}");
      } else {
        debugPrint("Email or password is empty!");
      }
    } catch (e) {
      debugPrint("Error in Entering values! : $e");
  }
}

logIn(BuildContext context, String email, String password) async {
  debugPrint("areEnteredCredentialsPresent Called!");
  try {
    final userCredentialsBox = await Hive.openBox<UserCredentials>('credentials_box');

    final existingCredentials = userCredentialsBox.values.firstWhere(
        (credentials) => credentials.email == email && credentials.password == password
    );

    if (existingCredentials != null) {
      debugPrint("Entered credentials are already present in the database!");
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Home();
      }));
    } else {
      debugPrint("Entered credentials are not found in the database!");
    }
  } catch (e) {
    debugPrint("Error in checking entered credentials presence! : $e");
  }
}