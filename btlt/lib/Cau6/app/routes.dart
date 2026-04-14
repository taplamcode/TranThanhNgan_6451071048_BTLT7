import 'package:flutter/material.dart';
import '../screens/products/product_search_screen.dart';

class Routes {
  static const String productSearch = '/product-search';

  static Map<String, WidgetBuilder> routes = {
    productSearch: (context) => const ProductSearchScreen(),
  };
}
