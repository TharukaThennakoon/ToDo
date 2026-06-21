import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class NavigationService {
  static final NavigationService instance = NavigationService._();
  NavigationService._();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext? get context => navigatorKey.currentState?.context;

  NavigatorState? get _navigator => navigatorKey.currentState;

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return _navigator!.pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T, TO>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return _navigator!.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  Future<T?> pushAndClear<T>(String routeName, {Object? arguments}) {
    return _navigator!.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  void pop<T>([T? result]) => _navigator?.pop(result);

  bool canPop() => _navigator?.canPop() ?? false;

  Future<void> toOnboarding() => pushReplacementNamed(AppRoutes.onboarding);

  Future<void> toLogin() => pushReplacementNamed(AppRoutes.login);

  Future<void> toSignup() => pushNamed(AppRoutes.signup);

  Future<void> toDashboard() => pushReplacementNamed(AppRoutes.dashboard);

  Future<void> toAddTask() => pushNamed(AppRoutes.addTask);

  Future<void> logout() => pushAndClear(AppRoutes.login);
}
