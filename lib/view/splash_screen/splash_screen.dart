import 'package:flutter/material.dart';
import 'dart:async';
import 'package:note_application_org/view/notes_screen/notes_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer( const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const NotesScreen(),
            ),
          (route) => false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "asset/splash_image.png",
              height: 200,
              width: 200,
            ),

            const SizedBox(height: 30),
            const Text(
              "NoteApp",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                 fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}