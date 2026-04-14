import 'package:flutter/material.dart';
import 'routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Update User',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.updateUser,
      routes: Routes.routes,
    );
  }
}
