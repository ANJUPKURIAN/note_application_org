import 'package:flutter/material.dart';
import 'package:note_application_org/core/constant/color_constant.dart';
import 'package:note_application_org/view/notes_screen/notes_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    Future.delayed(
      Duration(seconds: 2)
      )
      .then((value) =>
    Navigator.pushReplacement(
    context, 
    MaterialPageRoute(
    builder: (context) => NotesScreen()
    )
    )
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: ColorConstant.primaryBlack,
      body: Center(
       child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "asset/splash_image.png",
              scale: 3,
            ),
            const SizedBox(height: 30),
            const Text(
              "Note App",
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