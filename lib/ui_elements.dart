import 'package:flutter/material.dart';
import 'package:pronouncepro/splash_screen.dart';
import 'package:pronouncepro/user_screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TextFields for Login and Signup pages
Widget textField(String field, controller, double width) {
  return Padding(
    padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
    child: SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        validator: (String? value) {
          if(value!.isEmpty) {
            return "Please Enter Valid $field";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: field,
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          
        )
      ),
    )
  );
}

//TextFields specific for email
Widget emailField(controller, double width) {
  return Padding(
    padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
    child: SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        validator: (String? value) {
          RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

          if(value!.isEmpty || !emailRegExp.hasMatch(value)) {
            return "Please Enter Valid Email";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: "Email",
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          
        )
      ),
    )
  );
}

// Text Fields only for passwords
class PasswordTextField extends StatefulWidget {
  final String field;
  final TextEditingController controller;
  final double width;

  PasswordTextField(this.field, this.controller, this.width);

  @override
  State<StatefulWidget> createState() => PasswordTextFieldState();
}

class PasswordTextFieldState extends State<PasswordTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
      child: SizedBox(
        width: widget.width,
        child: TextFormField(
          obscureText: isObscure,
          controller: widget.controller,
          validator: (String? value) {
            RegExp passwordRegExp = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$');
            
            if (value!.isEmpty || value.length < 8 || !passwordRegExp.hasMatch(value)) {
              return "Please enter a valid password with at least 8 characters including letters, numbers, and special characters";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: isObscure? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
              onPressed: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
            ),
            labelText: widget.field,
            labelStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}

//Containers in add courses List
Widget adminHomeContainer(String value) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: const Color.fromARGB(255, 29, 226, 216),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
    ),
  );
}

//Alert dialog for log out in user profile and admin side
void logOutAlert(BuildContext context) {
    var alertDialog = AlertDialog(
      title: const Text("Are you sure you want to log out?", style: TextStyle(fontSize: 18)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 50),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel", style: TextStyle(color: Colors.blueAccent, fontSize: 16))
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (route) => false);
              var prefs = await SharedPreferences.getInstance();
              prefs.setString(SplashScreenState.KEY_LOGIN, 'loggedOut');
            },
            child: const Text("Log out", style: TextStyle(color: Colors.blueAccent, fontSize: 16))
          ),
        ],
      )
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog
    );
  }

  //Container for Levels
  List<String> imageList = ['images/newbie.png', 'images/intermediate-level.png', 'images/technological.png'];
  Widget levelsContainer(String title, index) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 247, 209, 186),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Padding(
        padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Image.asset(imageList[index], width: 50, height: 50),
                const SizedBox(height: 4),
                Text(title, style: const TextStyle(color: Color.fromARGB(255, 76, 46, 35), fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        )
      ),
    );
  }

