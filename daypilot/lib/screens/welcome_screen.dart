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
    return Scaffold(
      backgroundColor: const Color(0xfff4f4fb),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: const [SizedBox(height: 25)]),
        ),
        
      ),
    );
  }

  Widget dot() {
  return Container(
    height: 12,
    width: 12,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xffd5cdf7),
    ),
  );
}
}
