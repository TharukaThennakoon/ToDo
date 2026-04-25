import 'package:flutter/material.dart';

void main() {
  runApp(const DayPilotApp());
}

class DayPilotApp extends StatelessWidget {
  const DayPilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DayPilot',
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Welcome"),
      ),
    );
  }
}