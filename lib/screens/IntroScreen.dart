import 'package:flutter/material.dart';
import 'package:the_square/screens/HomeScreen.dart';

class IntroScreen extends StatelessWidget {
   IntroScreen({super.key});

  final List<String> descriptions = [
    "Manage your tasks effectively with the Eisenhower Matrix.",
    "Focus on what's important and urgent.",
    "Double click to add, one click to edit it "
    "lastly drag and drop."

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        itemCount: descriptions.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.task, size: 100, color: Colors.amber),
              const SizedBox(height: 20),
              Text(
                descriptions[index],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              if (index == descriptions.length - 1)
                ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(shadowColor: Colors.amber,
                  backgroundColor: Colors.white // Background color
),
                  onPressed: () {
                    Navigator.pushReplacement(
                      
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  child: const Text("Get Started",style: TextStyle(color: Colors.black),),
                )
            ],
          );
        },
      ),
    );
  }
}
