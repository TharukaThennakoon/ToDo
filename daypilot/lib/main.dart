import 'package:flutter/material.dart';
import 'screens/tasky_welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasky',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),
      home: const TaskyWelcomeScreen(
        useLocalFile: true,
        localPath: '/mnt/data/19626961-af3e-4dd6-b71c-356deeb75fa3.jpg',
      ),
    );
  }
}
