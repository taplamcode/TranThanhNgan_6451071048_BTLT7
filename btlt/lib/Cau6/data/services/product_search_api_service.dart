import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

class ProductSearchApiService {
  Future<http.Response> searchProducts(String keyword) async {
    final uri = Uri.parse(
      '${AppConstants.baseUrl}/products/search',
    ).replace(queryParameters: {'q': keyword});

    return http.get(uri, headers: {'Accept': 'application/json'});
  }
}
