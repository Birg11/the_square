import 'package:flutter/material.dart';
import 'package:the_square/screens/IntroScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Use WidgetsBinding to safely access context after build method
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  IntroScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_box, size: 100, color: Colors.amber),
            const SizedBox(height: 20),
            const Text(
              "The Square",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),
            ),
            const SizedBox(height: 20),
            // const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
