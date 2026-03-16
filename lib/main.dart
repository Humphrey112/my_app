import 'package:flutter/material.dart';
import 'package:my_app/Home_page/Onboarding.dart';
import 'package:my_app/Home_page/loginscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // Removes the red 'debug' banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // This sets your custom LoginScreen as the first thing users see
      home: const OnboardingPage(), 
    );
  }
}