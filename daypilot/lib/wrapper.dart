import 'package:daypilot/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:daypilot/screens/auth/authentication.dart';
import 'package:daypilot/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // For now, we will always show the AuthenticationScreen.
    // In a real app, you would check if the user is logged in and show the appropriate screen.
    final user = Provider.of<UserModel?>(context);
    if (user != null && user.uid.isNotEmpty) {
      return const HomeScreen();
    }
    return const AuthenticationScreen();
  }
}