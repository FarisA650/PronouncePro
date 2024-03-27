// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pronouncepro/models/user_credentials.dart';

class EditProfileDialog extends StatefulWidget {
  final UserCredentials userCredentials;

  const EditProfileDialog({required this.userCredentials});

  @override
  State<StatefulWidget> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  TextEditingController usernameEditController = TextEditingController();
  TextEditingController nameEditController = TextEditingController();
  TextEditingController emailEditController = TextEditingController();
  TextEditingController phoneNumberEditController = TextEditingController();
  TextEditingController profileImageEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameEditController.text = widget.userCredentials.username ?? '';
    nameEditController.text = widget.userCredentials.name ?? '';
    emailEditController.text = widget.userCredentials.email ?? '';
    phoneNumberEditController.text = widget.userCredentials.phoneNumber ?? '';
    profileImageEditController.text = widget.userCredentials.imagePath ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Profile", style: TextStyle(fontSize: 20)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTextField(usernameEditController, "Username"),
            const SizedBox(height: 10),
            buildTextField(nameEditController, "Name"),
            const SizedBox(height: 10),
            buildTextField(emailEditController, "Email"),
            const SizedBox(height: 10),
            buildTextField(phoneNumberEditController, "Phone Number"),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel", style: TextStyle(fontSize: 16))
        ),
        TextButton(
          onPressed: () {
            saveChanges();
          },
          child: const Text("Save Changes", style: TextStyle(fontSize: 16)),
        )
      ],
    );
  }

  Widget buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }

  Future<void> saveChanges() async {
    try {
      var userCredentialsBox = await Hive.openBox<UserCredentials>('credentials_box');

      userCredentialsBox.put('key_${widget.userCredentials.email}', UserCredentials(
        email: emailEditController.text,
        password: widget.userCredentials.password,
        name: nameEditController.text,
        username: usernameEditController.text,
        phoneNumber: phoneNumberEditController.text,
        imagePath: profileImageEditController.text
      ));

      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Error editing profile: $e');
    }
  }
}
