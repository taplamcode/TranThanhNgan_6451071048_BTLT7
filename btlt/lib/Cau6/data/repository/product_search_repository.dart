import 'dart:convert';
import '../models/product_model.dart';
import '../services/product_search_api_service.dart';

class ProductSearchRepository {
  final ProductSearchApiService apiService = ProductSearchApiService();

  Future<List<ProductModel>> searchProducts(String keyword) async {
    final response = await apiService.searchProducts(keyword);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final list = (json['products'] as List<dynamic>? ?? <dynamic>[])
          .cast<Map<String, dynamic>>();

      return list.map(ProductModel.fromJson).toList();
    }

    throw Exception(
      'Failed to search products. Status code: ${response.statusCode}',
    );
  }
}
