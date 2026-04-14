import 'dart:convert';
import '../models/product_model.dart';
import '../services/product_api_service.dart';

class ProductRepository {
  final ProductApiService apiService = ProductApiService();

  Future<ProductModel> fetchProductDetail({int productId = 1}) async {
    final response = await apiService.getProductDetail(productId);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;

      return ProductModel.fromJson(json);
    }

    throw Exception('Failed to load product: ${response.statusCode}');
  }
}
