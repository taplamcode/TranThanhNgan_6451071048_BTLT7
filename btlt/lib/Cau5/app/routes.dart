import 'package:flutter/material.dart';
import '../screens/tasks/task_list_screen.dart';

class Routes {
  static const String taskList = '/task-list';

  static Map<String, WidgetBuilder> routes = {
    taskList: (context) => const TaskListScreen(),
  };
}
