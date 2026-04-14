import 'package:flutter/material.dart';
import '../screens/profile/update_user_screen.dart';

class Routes {
  static const String updateUser = '/update-user';

  static Map<String, WidgetBuilder> routes = {
    updateUser: (context) => const UpdateUserScreen(),
  };
}
