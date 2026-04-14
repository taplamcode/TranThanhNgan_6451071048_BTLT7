import 'dart:convert';
import '../models/dashboard_models.dart';
import '../services/dashboard_api_service.dart';

class DashboardRepository {
  final DashboardApiService apiService = DashboardApiService();

  Future<UserSummary> fetchUser() async {
    final response = await apiService.getUser();

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return UserSummary.fromJson(json);
    }

    throw Exception('Failed to load user. Status code: ${response.statusCode}');
  }

  Future<PostSummary> fetchPost() async {
    final response = await apiService.getPost();

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return PostSummary.fromJson(json);
    }

    throw Exception('Failed to load post. Status code: ${response.statusCode}');
  }

  Future<ProductSummary> fetchProduct() async {
    final response = await apiService.getProduct();

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return ProductSummary.fromJson(json);
    }

    throw Exception(
      'Failed to load product. Status code: ${response.statusCode}',
    );
  }
}
