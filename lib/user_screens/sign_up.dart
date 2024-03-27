import 'package:flutter/material.dart';
import 'package:pronouncepro/user_screens/login.dart';
import 'package:pronouncepro/user_screens/details.dart';
import 'package:pronouncepro/ui_elements.dart';
import 'package:shared_preferences/shared_preferences.dart';

late String loggedInUserPassword;
late String loggedInUserEmail;

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Icon(Icons.lock, size: 100, color: Colors.black),
                const SizedBox(height: 12),
                const Text("Let's create an account for you..",
                    style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                emailField(emailController, 250),
                PasswordTextField("Password", passwordController, 250),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 55),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text("Suggest Password?", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))],
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: const Center(child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)))
                  ),
                  onTap: () async {
                    if (_formkey.currentState?.validate() ?? false) {
                        debugPrint("Email Controller Value: ${emailController.text}");
                        debugPrint("Password Controller Value: ${passwordController.text}");
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString('key_email', emailController.text);
                        loggedInUserPassword = passwordController.text;
                        loggedInUserEmail = emailController.text;
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Details()),
                        );
                      }
                  }
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset('images/google.png', height: 50),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset('images/apple-logo.png', height: 50),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => Login(),
                            transitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: const Text("Log In Now", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
