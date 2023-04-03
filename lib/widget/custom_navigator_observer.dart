import 'package:flutter/material.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  final VoidCallback onHomeScreen;

  CustomNavigatorObserver({required this.onHomeScreen});

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null && previousRoute.settings.name == '/') {
      onHomeScreen();
    }
    super.didPop(route, previousRoute);
  }
}
