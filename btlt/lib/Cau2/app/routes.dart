import 'package:flutter/material.dart';
import '../screens/products/product_detail_screen.dart';

class Routes {
  static const String productDetail = '/product-detail';

  static Map<String, WidgetBuilder> routes = {
    productDetail: (context) => const ProductDetailScreen(),
  };
}
