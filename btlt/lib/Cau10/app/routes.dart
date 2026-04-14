import 'package:flutter/material.dart';
import '../screens/dashboard/dashboard_screen.dart';

class Routes {
  static const String dashboard = '/dashboard';

  static Map<String, WidgetBuilder> routes = {
    dashboard: (context) => const DashboardScreen(),
  };
}
