import 'package:flutter/material.dart';
import '../screens/posts/create_post_screen.dart';

class Routes {
  static const String createPost = '/create-post';

  static Map<String, WidgetBuilder> routes = {
    createPost: (context) => const CreatePostScreen(),
  };
}
