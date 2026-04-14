import 'package:flutter/material.dart';
import '../screens/users/user_screen.dart';


class Routes {
  static const String user = '/user';

  static Map<String, WidgetBuilder> routes = {
    user: (context) => const UserScreen(),
  };
}
