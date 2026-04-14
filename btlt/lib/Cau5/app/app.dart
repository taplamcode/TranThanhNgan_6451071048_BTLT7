import 'package:flutter/material.dart';
import 'routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Delete Task',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.taskList,
      routes: Routes.routes,
    );
  }
}
