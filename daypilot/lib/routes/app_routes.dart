import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/task/add_new_task_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';
  static const String addTask = '/add-task';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashScreen(), settings);
      case onboarding:
        return _fadeRoute(const OnboardingScreen(), settings);
      case login:
        return _fadeRoute(const LoginScreen(), settings);
      case signup:
        return _slideRoute(const SignupScreen(), settings);
      case dashboard:
        return _fadeRoute(const DashboardScreen(), settings);
      case addTask:
        return _slideRoute(const AddNewTaskScreen(), settings);
      default:
        return _buildRoute(
          const Scaffold(body: Center(child: Text('Page not found'))),
          settings,
        );
    }
  }

  static PageRouteBuilder<T> _fadeRoute<T>(Widget page, RouteSettings settings) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  static PageRouteBuilder<T> _slideRoute<T>(Widget page, RouteSettings settings) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final offset = Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
        return SlideTransition(
          position: offset,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }

  static MaterialPageRoute<T> _buildRoute<T>(Widget page, RouteSettings settings) {
    return MaterialPageRoute<T>(settings: settings, builder: (_) => page);
  }
}
