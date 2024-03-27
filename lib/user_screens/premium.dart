import 'package:flutter/material.dart';
import 'package:pronouncepro/user_screens/home.dart';

class Premium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 154, 137),
        foregroundColor: Colors.white,
        title: const Text("Premium"),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap : () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home())),
                child: const Icon(Icons.home, color: Colors.white)
              ),
              const SizedBox(width: 15)
            ],
          )
        ]
      ),
      body: const Center(
        child: Text("Premium features will be added soon!"),
      )
    );
  }
}